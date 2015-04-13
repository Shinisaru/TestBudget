//
//  Transaction.h
//  TestBudget
//
//  Created by Vladislav Sinitsyn on 4/13/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * isExpense;

@end
