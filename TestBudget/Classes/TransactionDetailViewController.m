//
//  TransactionDetailViewController.m
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "TransactionFormViewController.h"
#import "TBCell.h"

@interface TransactionDetailViewController () <UIAlertViewDelegate>

- (void)actDelete:(id)sender;
- (void)actEdit:(id)sender;
- (void)doDelete;

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@end

@implementation TransactionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDoesRelativeDateFormatting:YES];
    self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    UIBarButtonItem * edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actEdit:)];
    UIBarButtonItem * del = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(actDelete:)];
    
    self.navigationItem.rightBarButtonItems = @[edit, del];
    
}

- (void)doDelete {
    
    [self.transaction MR_deleteInContext:self.ctx];
    @weakify(self);
    [self.ctx MR_saveWithOptions:MRSaveParentContexts completion:^(BOOL success, NSError *error) {
        @strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TBRefreshData" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)actDelete:(id)sender {
    NSString *msg = NSLocalizedString(@"Are you sure you want to delete this record?", @"");
    NSString *title = NSLocalizedString(@"Delete record", @"");
    if (SYS_VER_EQ_OR_GREATER_THAN(@"8.0")) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        @weakify(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"YES"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    @strongify(self);
                                                    [self doDelete];
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"NO"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil]];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
        [alert show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self doDelete];
    }
}

- (void)actEdit:(id)sender {
    [self performSegueWithIdentifier:@"edit" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transaction.guid.length > 0 ? 4 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsCell"
                                                            forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    if (row > 0 && self.transaction.guid.length > 0) {
        row --;
    }
    
    if (row == 0) {
        if (self.transaction.guid.length > 0) {
            cell.lblTitle.text = NSLocalizedString(@"GUID", @"");
            cell.lblDetail.text = self.transaction.guid;
        } else {
            cell.lblTitle.text = NSLocalizedString(@"Amount", @"");
            NSString *amount;
            if (self.transaction.isExpense.boolValue) {
                amount = @"-";
            } else {
                amount = @"+";
            }
            
            cell.lblDetail.text = [amount stringByAppendingString:[NSString stringWithFormat:@"%.2f", 0.01 * floor(self.transaction.value.doubleValue * 100)]];
        }
    } else if (row == 1) {
        cell.lblTitle.text = NSLocalizedString(@"Date", @"");
        cell.lblDetail.text = [self.dateFormatter stringFromDate:self.transaction.date];
    } else {
        cell.lblTitle.text = NSLocalizedString(@"Kind", @"");
        cell.lblDetail.text = self.transaction.kind;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row > 0 && self.transaction.guid.length > 0) {
        row --;
    }
    
    if (row == 2) {
        NSString *text = self.transaction.kind;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:17]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(216, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
        
        CGFloat h = rect.size.height + 25;
        return h < 44 ? 44 : h;
        
    } else {
        return 44.0;
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"edit"]) {
        TransactionFormViewController *vc = ((TransactionFormViewController *) segue.destinationViewController);
        vc.type = TBFormTypeEdit;
        NSManagedObjectContext *ctx = local_conext();
        vc.ctx = ctx;
        vc.transaction = [self.transaction MR_inContext:ctx];
    }
}


@end
