//
//  TBCell.h
//  TestBudget
//
//  Created by Vladislav Sinitsyn on 4/13/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

@end
