//
//  Utils.h
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#ifndef TestBudget_Utils_h
#define TestBudget_Utils_h

static NSString * const kTransactionCahceName = @"MagicalRecord-Cache-Transaction";

static inline BOOL SYS_VER_EQ_OR_GREATER_THAN(NSString *version) {
    NSComparisonResult res = [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch];
    return  res != NSOrderedAscending;
}

static inline NSManagedObjectContext * reading_conext() {
    return [NSManagedObjectContext MR_defaultContext];
}

static inline NSManagedObjectContext * local_conext() {
    return [NSManagedObjectContext MR_contextWithParent:reading_conext()];
}


static inline NSFetchedResultsController * fr_controller(NSFetchRequest *request) {
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:reading_conext()
                                                 sectionNameKeyPath:nil
                                                          cacheName:kTransactionCahceName];

}

typedef void (^VoidCallback)(void);
typedef void (^DateCallback)(NSDate *);

#endif
