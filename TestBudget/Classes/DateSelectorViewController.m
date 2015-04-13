//
//  DateSelectorViewController.m
//  TestBudget
//
//  Created by Vladislav Sinitsyn on 4/13/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import "DateSelectorViewController.h"
#import "SHButton.h"

@interface DateSelectorViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet SHButton *btnOk;

- (IBAction)datePickerChanged:(id)sender;
- (IBAction)actDatePicked:(id)sender;

@end

@implementation DateSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Select date", @"");
    self.btnOk.layer.shadowOffset = CGSizeMake(1, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)datePickerChanged:(id)sender {
    self.date = self.datePicker.date;
}

- (IBAction)actDatePicked:(id)sender {
    if (self.dateChangeBlock) {
        self.dateChangeBlock(self.date);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
