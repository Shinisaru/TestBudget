//
//  TBAmountCell.h
//  TestBudget
//
//  Created by vlad on 09/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBAmountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *plusMinusImageView;
@property (weak, nonatomic) IBOutlet UITextField *lblAmount;

@end
