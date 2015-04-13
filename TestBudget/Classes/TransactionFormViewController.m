//
//  AddTransactionViewController.m
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import "TransactionFormViewController.h"
#import "DateSelectorViewController.h"
#import "Transaction.h"
#import "TBAmountCell.h"
#import "TBTextCell.h"

static NSString *aCellIdentifier = @"AmountCell";
static NSString *txCellIdentifier = @"TextCell";
static NSString *dCellIdentifier = @"DateCell";

@interface TransactionFormViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, weak) TBAmountCell *amountCell;
@property (nonatomic, weak) TBTextCell *textCell;
@property (nonatomic, retain) NSDate *date;

@property (nonatomic, retain) UISegmentedControl *typeSegment;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

- (void)typeChanged:(id)sender;

- (IBAction)actSave:(id)sender;

- (void)keyboardWillShowHandler:(NSNotification *)notification;
- (void)keyboardWillHideHandler:(NSNotification *)notification;
- (void)keyboardWillChangeFrameWithNotification:(NSNotification *)notification;

@end

@implementation TransactionFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDoesRelativeDateFormatting:YES];
    self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    self.tableView.tableFooterView = self.headerView;
    self.btnSave.layer.shadowOffset = CGSizeMake(1, 1);
    
    self.typeSegment = [[UISegmentedControl alloc] initWithItems:@[
        NSLocalizedString(@"Income", @""),
        NSLocalizedString(@"Expense", @"")
    ]];
    
    [self.typeSegment addTarget:self action:@selector(typeChanged:)
               forControlEvents:UIControlEventValueChanged];
    self.typeSegment.selectedSegmentIndex = 0;
    
    if (self.type == TBFormTypeEdit) {
        self.date = self.transaction.date;
        self.typeSegment.selectedSegmentIndex = self.transaction.isExpense.boolValue ? 1 : 0;
    }
    
    UIView *wrapper = [[UIView alloc] initWithFrame:self.typeSegment.bounds];
    [wrapper addSubview:self.typeSegment];
    
    self.navigationItem.titleView = wrapper;
    
    self.date = [NSDate date];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShowHandler:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHideHandler:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShowHandler:(NSNotification *)notification {
    [self keyboardWillChangeFrameWithNotification:notification];
}

- (void)keyboardWillHideHandler:(NSNotification *)notification {
    [self keyboardWillChangeFrameWithNotification:notification];
}

- (void)keyboardWillChangeFrameWithNotification:(NSNotification *)notification {
    
    NSDictionary* userInfo = notification.userInfo;
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options =[userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;

    CGRect keyboardScreenBeginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardScreenEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect keyboardViewBeginFrame = [self.view convertRect:keyboardScreenBeginFrame fromView:self.view.window];
    CGRect keyboardViewEndFrame = [self.view convertRect:keyboardScreenEndFrame fromView:self.view.window];
    
    CGFloat originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y;
    
    self.bottomConstraint.constant -= originDelta;
    
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:options | UIViewAnimationOptionBeginFromCurrentState
                     animations:^
    {
        [self.view layoutIfNeeded];
        NSInteger row = self.textCell.textView.isFirstResponder ? 2 : 0;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row
                                                                  inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
    } completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)typeChanged:(id)sender {
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"01234567890."] invertedSet];
    return [string rangeOfCharacterFromSet:set].location == NSNotFound;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    NSString *cellIdentifier;
    
    if (indexPath.row == 0) {
        cellIdentifier = aCellIdentifier;
    } else if (indexPath.row == 2) {
        cellIdentifier = txCellIdentifier;
    } else {
        cellIdentifier = dCellIdentifier;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        self.amountCell = ((TBAmountCell *) cell);
        self.amountCell.lblAmount.delegate = self;
        
        if (self.type == TBFormTypeEdit) {
            self.amountCell.lblAmount.text = [NSString stringWithFormat:@"%.2f", 0.01 * floor(self.transaction.value.doubleValue * 100)];
        }
        
        if (self.typeSegment.selectedSegmentIndex == 0) {
            [self.amountCell.plusMinusImageView setImage:[UIImage imageNamed:@"plus"]];
        } else {
            [self.amountCell.plusMinusImageView setImage:[UIImage imageNamed:@"minus"]];
        }
    } else if (indexPath.row == 2) {
        self.textCell = ((TBTextCell *) cell);
        if (self.type == TBFormTypeEdit) {
            self.textCell.textView.text = self.transaction.kind;
        }
    } else {
        
        cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.date];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 132.0;
    } else {
        return 44.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (!self.btnSave.enabled) return;
    
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"pick_date" sender:self];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pick_date"]) {
        ((DateSelectorViewController *) segue.destinationViewController).date = self.date;
        
        @weakify(self);
        ((DateSelectorViewController *) segue.destinationViewController).dateChangeBlock = ^(NSDate *datePicked)
        {
            @strongify(self);
            self.date = datePicked;
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        };
    }
}

- (IBAction)actSave:(id)sender {
    NSString *amount = self.amountCell.lblAmount.text;
    if (amount.length == 0) return;
    
    NSManagedObjectContext *ctx = local_conext();
    
    Transaction *t;
    if (self.type == TBFormTypeCreate) {
        t = [Transaction MR_createInContext:ctx];
    } else {
        t = [self.transaction MR_inContext:ctx];
    }
    
    t.value = @(amount.doubleValue);
    t.kind = self.textCell.textView.text;
    t.date = self.date;
    t.isRaw = @(YES);
    t.isExpense = @(self.typeSegment.selectedSegmentIndex == 1);
    
    self.navigationItem.backBarButtonItem.enabled = NO;
    self.btnSave.enabled = NO;
    
    @weakify(self);
    [ctx MR_saveWithOptions:MRSaveParentContexts completion:^(BOOL success, NSError *error) {
        @strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TBRefreshData" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
}
@end
