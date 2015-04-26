#import "LARAnnotation.h"
#import "LARBook.h"
#import "LARPhoto.h"

@interface LARAnnotation ()

// Private interface goes here.

@end

@implementation LARAnnotation

+(instancetype) annotationWithName:(NSString *) name
                              book:(LARBook *) book
                           context:(NSManagedObjectContext *) context{
    
    LARAnnotation *ann = [self insertInManagedObjectContext:context];
    
    ann.creationDate = [NSDate date];
    ann.name = name;
    
    LARPhoto *photo = [LARPhoto insertInManagedObjectContext:context];
    photo.photoData = [NSData new];
    photo.photoUrl = @"";
    
    ann.photo = photo;
    ann.modificationDate = [NSDate date];
    
    ann.book = book;
    
    return ann;
}

-(NSInteger) numberOfObjects{
    
    return [[self.book.annotations allObjects] count];
}

@end

