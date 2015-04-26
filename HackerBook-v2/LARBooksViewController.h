//
//  LARBooksViewController.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 15/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LARLibraryViewController.h"
@class LARBook;


@interface LARBooksViewController : UIViewController <UISplitViewControllerDelegate, LARLibraryViewControllerDelegate>

@property (strong, nonatomic) LARBook *model;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *authors;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UIButton *favorite;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

-(IBAction)displayPdf:(id)sender;
-(IBAction)markFavorite:(id)sender;
-(IBAction)displayAnnotation:(id)sender;

-(id) initWithModel:(LARBook *) model andFetchResultController:(NSFetchedResultsController *) fetchedResultsController;
-(id) initWithFetchResultController:(NSFetchedResultsController *) fetchedResultsController;

@end
