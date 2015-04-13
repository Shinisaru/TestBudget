//
//  AddTransactionViewController.h
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

typedef NS_ENUM(NSUInteger, TBFormType) {
    TBFormTypeCreate,
    TBFormTypeEdit
};

@interface TransactionFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) TBFormType type;
@property (nonatomic, retain) NSManagedObjectContext *ctx;
@property (nonatomic, retain) Transaction *transaction;

@end
