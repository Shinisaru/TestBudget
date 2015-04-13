//
//  TransactionsViewController.h
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

@interface TransactionsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@end
