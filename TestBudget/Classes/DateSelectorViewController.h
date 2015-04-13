//
//  DateSelectorViewController.h
//  TestBudget
//
//  Created by Vladislav Sinitsyn on 4/13/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelectorViewController : UIViewController

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) DateCallback dateChangeBlock;


@end
