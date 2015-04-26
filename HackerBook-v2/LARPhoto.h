#import "_LARPhoto.h"
@import UIKit;
@class LARBook;

@interface LARPhoto : _LARPhoto {}

+(void) addPhotoWithName: (NSString *) titulo andURL: (NSString *) urlPhoto context: (NSManagedObjectContext *) context book: (LARBook *) book;
-(void) setImage:(UIImage *)image;
-(UIImage *) image;
-(void) saveImage: (UIImage *)image inAnnotation: (LARAnnotation *) annotation andContext: (NSManagedObjectContext *) context;

@end
