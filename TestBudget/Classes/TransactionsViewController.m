//
//  TransactionsViewController.m
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import "TransactionsViewController.h"
#import "TransactionFormViewController.h"
#import "TransactionDetailViewController.h"
#import "ComBean_keeper.pb.h"
#import "TBTitleView.h"
#import "Transaction.h"
#import <Reachability/Reachability.h>

@interface TransactionsViewController () <UIAlertViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) TBTitleView *titleView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *lblIncome;
@property (weak, nonatomic) IBOutlet UILabel *lblExpense;

@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) id syncAlert;
@property (nonatomic, assign) BOOL syncCanceled;
@property (nonatomic, retain) NSURLSessionTask *dataTask;

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@property (nonatomic, retain) Transaction *selectedTransaction;

@property (nonatomic, assign) NSUInteger oldCount;

- (void)actSynchronize:(id)sender;
- (void)actAddRecord:(id)sender;

- (void)fetchRecords:(VoidCallback)callback;
- (void)ptrHandler;
- (void)doSync;
- (void)handleSyncData:(NSData *)data;

- (void)refreshData:(NSNotification *)notification;

@end

@implementation TransactionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView = [[NSBundle mainBundle] loadNibNamed:@"TBTitleView" owner:nil options:nil][0];
    
    self.navigationItem.titleView = self.titleView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actSynchronize:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actAddRecord:)];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDoesRelativeDateFormatting:YES];
    self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    [self spawnFetchedResultsController];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    self.refreshControl.tintColor = [UIColor darkGrayColor];
    [self.refreshControl addTarget:self
                            action:@selector(ptrHandler)
                  forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.titleView.lblBalance.text = @"";
    self.lblExpense.text = @"";
    self.lblIncome.text = @"";
    self.tableView.tableHeaderView = self.headerView;
    
    [self ptrHandler];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"TBRefreshData" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TBRefreshData" object:nil];
}

- (void)refreshBalance {
    NSArray *allTransactions = [Transaction MR_findAll];
    
    // long double may not be enough
    long double totalIncome = 0;
    long double totalExpense = 0;
    long double balance = 0;
    
    for (Transaction *t in allTransactions) {
        if (t.isExpense.boolValue) {
            totalExpense += t.value.doubleValue;
            balance -= t.value.doubleValue;
        } else {
            totalIncome += t.value.doubleValue;
            balance += t.value.doubleValue;
        }
    }
    
    self.titleView.lblBalance.text = [NSString stringWithFormat:@"%.2f", 0.01 * floor(balance * 100)];
    self.lblIncome.text = [NSString stringWithFormat:@"%.2f", 0.01 * floor(totalIncome * 100)];
    self.lblExpense.text = [NSString stringWithFormat:@"%.2f", 0.01 * floor(totalExpense * 100)];
}

- (void)refreshData:(NSNotification *)notification {
    NSArray *sections = [self.fetchedResultsController sections];
    self.oldCount = sections.count;
    
    [self refreshBalance];
}

- (void)spawnFetchedResultsController {
    NSFetchRequest *request = [Transaction MR_requestAllSortedBy:@"date"
                                                       ascending:NO
                                                   withPredicate:nil
                                                       inContext:reading_conext()];
    
    self.fetchedResultsController = fr_controller(request);
    self.fetchedResultsController.delegate = self;
    
    [NSFetchedResultsController deleteCacheWithName:kTransactionCahceName];
}

- (void)ptrHandler {
    [NSFetchedResultsController deleteCacheWithName:kTransactionCahceName];
    self.limit = 20;
    
    NSArray *sections = [self.fetchedResultsController sections];
    self.oldCount = sections.count;
    
    [self refreshBalance];
    
    @weakify(self);
    [self fetchRecords:^{
        @strongify(self);
        if (self.refreshControl && self.refreshControl.isRefreshing) {
            [self.refreshControl endRefreshing];
        }
    }];
}

- (void)fetchRecords:(VoidCallback)callback {
    if (nil == self.fetchedResultsController) return;
    
    self.fetchedResultsController.fetchRequest.fetchLimit = self.limit;
    
    [Transaction MR_performFetch:self.fetchedResultsController];
    
    if (callback) {
        callback();
    }
}

- (void)actAddRecord:(id)sender {
    [self performSegueWithIdentifier:@"add_record" sender:self];
}

- (void)actSynchronize:(id)sender {
    
    NSString *msg = NSLocalizedString(@"Do you want to synchronize data with server?", @"");
    
    if (SYS_VER_EQ_OR_GREATER_THAN(@"8.0")) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        @weakify(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"YES"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    @strongify(self);
                                                    [self doSync];
                                                  }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil]];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
        alert.tag = 1;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self doSync];
    } else if (alertView.tag != 1) {
        [self cancelSync];
    }
}

- (void)doSync {
    if (![[Reachability reachabilityWithHostName:@"bean-keeper.appspot.com"] isReachable]) {
        [self showMessage:NSLocalizedString(@"Synchronization host not reachable", @"") title:@"Error"];
        return;
    }
    
    NSString *msg = NSLocalizedString(@"Synchronization in progress, please wait", @"");
    
    if (SYS_VER_EQ_OR_GREATER_THAN(@"8.0")) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        @weakify(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            @strongify(self);
            [self cancelSync];
        }]];
        self.syncAlert = alert;
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        self.syncAlert = alert;
        alert.tag = 2;
        [alert show];
    }
    
    @weakify (self);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *transactions = [Transaction MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isRaw == YES"]];
        
        NSDate *clientTamstamp = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientTamstamp"];
        if (nil == clientTamstamp) {
            clientTamstamp = [NSDate date];
        }
        
        AccountDeltaBuilder *deltaBuilder = [AccountDelta builder];
        
        for (Transaction * t in transactions) {
            TransactionBuilder *builder = [PBTransaction builder];
            if (t.guid.length > 0) {
                [builder setGuid:t.guid];
            }
            [builder setKind:t.kind];
            Float64 value = t.value.floatValue;
            if (t.isExpense.boolValue) {
                value *= -1;
            }
            [builder setValue:value];
            [builder setDeleted:t.is_deleted.boolValue];
            [builder setDate:t.date.timeIntervalSince1970];
            
            PBTransaction *pb = [builder build];
            [deltaBuilder addAddedOrModified:pb];
        }
        
        AccountDelta *delta = [deltaBuilder build];
        
        @strongify(self);
        
        if (!self.syncCanceled) {
            NSURL *url = [NSURL URLWithString:@"http://bean-keeper.appspot.com/bk"];
            NSMutableURLRequest *syncRequest = [NSMutableURLRequest requestWithURL:url
                                                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                                   timeoutInterval:60];
            [syncRequest setHTTPMethod:@"POST"];
            [syncRequest setHTTPBody:delta.data];
            
            self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:syncRequest
                                                            completionHandler:^(NSData *data,
                                                                                NSURLResponse *response,
                                                                                NSError *error)
            {
                @strongify(self);

                if (nil == error) {
                    [self handleSyncData:data];
                } else {
                    [self showMessage:error.localizedDescription title:@"Error"];
                }
            }];
            
            [self.dataTask resume];
        }
        
    });
}

- (void)showMessage:(NSString *)errorMessage title:(NSString *)title {
    if (SYS_VER_EQ_OR_GREATER_THAN(@"8.0")) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:errorMessage
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)handleSyncData:(NSData *)data {
    if (self.syncCanceled)  {
        self.syncCanceled = NO;
        return;
    }
    AccountDelta *delta = nil;
    
    @try {
         delta = [AccountDelta parseFromData:data];
    }
    @catch (NSException *exception) {
        
        if (SYS_VER_EQ_OR_GREATER_THAN(@"8.0")) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [((UIAlertView *) self.syncAlert) dismissWithClickedButtonIndex:99 animated:YES];
        }
        
        [self showMessage:exception.reason title:exception.name];
    }
    
    if (nil == delta) {
        return;
    }
    
    NSManagedObjectContext *ctx = local_conext();
    
    // insert or update existing transactions
    for (PBTransaction *pbt in [delta addedOrModified]) {
        Transaction *t = [Transaction MR_findFirstByAttribute:@"guid" withValue:pbt.guid inContext:ctx];
        
        if (nil == t) {
            t = [Transaction MR_createInContext:ctx];
        }
        
        t.guid = pbt.guid;
        t.value = [NSNumber numberWithDouble:fabs(pbt.value)];
        t.isExpense = @(pbt.value < 0);
        t.isRaw = @(NO);
        t.kind = pbt.kind;
        t.is_deleted = @(pbt.deleted);
        t.date = [NSDate dateWithTimeIntervalSince1970:pbt.date];
    }
    
    // ToDo: delete all transactions without guid -- should be replaced with server response ??? unclear
    
    @weakify(self);
    
    self.fetchedResultsController = nil;
    
    [ctx MR_saveWithOptions:MRSaveParentContexts completion:^(BOOL success, NSError *error) {
    
        @strongify(self);
        
        if (SYS_VER_EQ_OR_GREATER_THAN(@"8.0")) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [((UIAlertView *) self.syncAlert) dismissWithClickedButtonIndex:99 animated:YES];
        }
        
        if (nil != error) {
            [self showMessage:error.localizedDescription title:@"Error"];
        } else {
            [self showMessage:NSLocalizedString(@"Synchronization completed", @"") title:@"Success"];
            [self spawnFetchedResultsController];
            [self ptrHandler];
        }
    }];
}

- (void)cancelSync {
    self.syncCanceled = YES;
    if (self.dataTask) {
        [self.dataTask suspend];
        self.dataTask = nil;
        self.syncCanceled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *sections = [self.fetchedResultsController sections];
    return (nil == sections) ? 0 : sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultsController sections];
    id sectionInfo = [sections objectAtIndex:section];
    NSInteger count = [sectionInfo numberOfObjects];
    return count > 0 ? count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sections = [self.fetchedResultsController sections];
    id sectionInfo = [sections objectAtIndex:indexPath.section];
    NSInteger count = [sectionInfo numberOfObjects];
    
    UITableViewCell *cell;
    
    if (count == 0) {
        static NSString *tCellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:tCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"No records found\n\nTap here to add one";
    } else {
        static NSString *tCellIdentifier = @"TransactionCell";
        cell = [tableView dequeueReusableCellWithIdentifier:tCellIdentifier forIndexPath:indexPath];
        
        Transaction * t = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.textLabel.text = [self.dateFormatter stringFromDate:t.date];
        
        NSMutableString *amount = [NSMutableString string];
        
        if (t.isExpense.boolValue) {
            [amount appendString:@"-"];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:229.0 / 255.0 green:66.0 / 255.0 blue:75.0 / 255.0 alpha:1.0];
        } else {
            [amount appendString:@"+"];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:41.0 / 255.0 green:181.0 / 255.0 blue:36.0 / 255.0 alpha:1.0];
        }
        
        [amount appendFormat:@"%.2f", 0.01 * floor(t.value.doubleValue * 100)];
        cell.detailTextLabel.text = amount;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sections = [self.fetchedResultsController sections];
    id sectionInfo = [sections objectAtIndex:indexPath.section];
    NSInteger count = [sectionInfo numberOfObjects];
    
    if (count == 0) {
        return CGRectGetHeight(self.tableView.frame)
//            - CGRectGetHeight(self.headerView.frame)
            - CGRectGetMaxY(self.navigationController.navigationBar.frame);
    }
    
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sections = [self.fetchedResultsController sections];
    id sectionInfo = [sections objectAtIndex:indexPath.section];
    NSInteger count = [sectionInfo numberOfObjects];
    
    if (count == 0) {
        [self actAddRecord:nil];
    } else {
        self.selectedTransaction = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"show_details" sender:self];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark NSFetchedResultsControllerDelegate calls

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex
      orChangeType:(NSFetchedResultsChangeType)type
{
    
    NSIndexSet *iSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    UITableViewRowAnimation animation = UITableViewRowAnimationNone;
    
    switch(type) {
        case NSFetchedResultsChangeInsert : {
            [self.tableView insertSections:iSet withRowAnimation:animation];
        } break;
            
        case NSFetchedResultsChangeDelete : {
            [self.tableView deleteSections:iSet withRowAnimation:animation];
        } break;
            
        case NSFetchedResultsChangeUpdate : {
            [self.tableView reloadSections:iSet withRowAnimation:animation];
        } break;
            
        // NSFetchedResultsChangeMove unhandled -- moving unsupported
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    UITableViewRowAnimation animation = UITableViewRowAnimationNone;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert : {
            if (self.oldCount == 0) {
                self.oldCount --;
                [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0
                                                         inSection:0]]
                                      withRowAnimation:animation];
            }
            
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:animation];
        } break;
            
        case NSFetchedResultsChangeDelete : {
            
            NSArray *sections = [self.fetchedResultsController sections];
            id sectionInfo = [sections objectAtIndex:indexPath.section];
            NSInteger count = [sectionInfo numberOfObjects];
            
            if (count == 0) {
                [self.tableView reloadData];
            } else {
                [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:animation];
            }
        }
            break;
            
        case NSFetchedResultsChangeUpdate : {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:animation];
        } break;
            
        // NSFetchedResultsChangeMove unhandled -- moving unsupported
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"add_record"]) {
        ((TransactionFormViewController *) segue.destinationViewController).type = TBFormTypeCreate;
    } else if ([segue.identifier isEqualToString:@"show_details"]) {
        NSManagedObjectContext *ctx = local_conext();
        ((TransactionDetailViewController *) segue.destinationViewController).ctx = ctx;
        ((TransactionDetailViewController *) segue.destinationViewController).transaction = [self.selectedTransaction MR_inContext:ctx];
    }
}


@end
