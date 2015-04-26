//
//  ADPBooksViewController.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 15/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class LARBook;
@class LARLibraryViewController;

@protocol LARLibraryViewControllerDelegate <NSObject>

@optional
-(void) libraryTableViewController: (LARLibraryViewController *)library didSelectedBook:(LARBook *) book;

@end

@interface LARLibraryViewController : AGTCoreDataTableViewController <LARLibraryViewControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (weak, nonatomic) id<LARLibraryViewControllerDelegate> delegate;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *tableSections;
@property (nonatomic, strong) NSMutableArray *tableSectionsAndItems;

@end
