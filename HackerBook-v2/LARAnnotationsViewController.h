//
//  LARAnnotationsViewController.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 20/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class LARBook;

@interface LARAnnotationsViewController : AGTCoreDataTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 style:(UITableViewStyle)aStyle
                                  book:(LARBook *) book;
@property(nonatomic, strong) LARBook *model;


@end
