//
//  LARPhotoViewController.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 25/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LARPhoto;
@class LARAnnotation;

@interface LARPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)takePicture:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@property(nonatomic, strong) LARPhoto *model;
@property(nonatomic, strong) LARAnnotation *annotation;
@property(nonatomic, strong) NSManagedObjectContext *context;

-(id) initWithModel:(LARPhoto *) model andAnnotation: (LARAnnotation *) annotation andContext: (NSManagedObjectContext *) context;

@end
