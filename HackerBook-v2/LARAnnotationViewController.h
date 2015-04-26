//
//  LARAnnotationViewController.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 20/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LARAnnotation;

@interface LARAnnotationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *titleAnnotation;
@property (weak, nonatomic) IBOutlet UILabel *creationDateView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (nonatomic, strong) LARAnnotation *model;
@property(nonatomic, strong) NSManagedObjectContext *context;

-(id) initWithModel:(LARAnnotation *) model andContext: (NSManagedObjectContext *) context;



- (IBAction)displayPhoto:(id)sender;
- (IBAction)displayShare:(id)sender;
- (IBAction)displayRemove:(id)sender;

@end
