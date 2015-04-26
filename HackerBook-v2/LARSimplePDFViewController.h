//
//  LARSimplePDFViewController.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 20/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LARBook;

@interface LARSimplePDFViewController : UIViewController

@property(nonatomic, strong) LARBook *model;
@property (weak, nonatomic) IBOutlet UIWebView *pdfView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property(nonatomic, strong) NSManagedObjectContext *context;

-(IBAction)displayAnnotations:(id)sender;

-(id)initWithModel:(LARBook *) book andContext: (NSManagedObjectContext *) context;

@end
