#import "LARPhoto.h"
@import UIKit;
#import "LARBook.h"
#import "LARAnnotation.h"

@interface LARPhoto ()

// Private interface goes here.

@end

@implementation LARPhoto

+(void) addPhotoWithName: (NSString *) titulo andURL: (NSString *) urlPhoto context: (NSManagedObjectContext *) context book: (LARBook *) book{
    
    UIImage* image = [UIImage imageNamed:@"emptyBookCover.png"];
    
    NSMutableString *nombreLibro = [[NSMutableString alloc] init];
    [nombreLibro appendString:@"Documents/HackerBook/Pictures/"];
    [nombreLibro appendString:urlPhoto];
    [nombreLibro appendString:@".jpg"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString  *photoFile = [NSHomeDirectory() stringByAppendingPathComponent:nombreLibro];
    
    if (![fileManager fileExistsAtPath:photoFile]){
        LARPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                                        inManagedObjectContext:context];
        
        photo.photoData = UIImageJPEGRepresentation(image, 0.9);
        photo.photoUrl = urlPhoto;
        
        book.photo = photo;
        
        [self downloadImage:photo withNSManagedObjectContext: context];
        
    }else{
        // El fichero ya está cacheado en local, lo leemos
        image = [UIImage imageWithData:
                  [NSData dataWithContentsOfURL:[NSURL URLWithString:nombreLibro]]];
        
        LARPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                                        inManagedObjectContext:context];
        
        photo.photoData = UIImageJPEGRepresentation(image, 0.9);
        photo.photoUrl = urlPhoto;
        
        book.photo = photo;

    }

}

#pragma mark - Remote Image
+(void) downloadImage: (LARPhoto *) photo withNSManagedObjectContext: (NSManagedObjectContext *) context{
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0),
                   ^{
                       NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo.photoUrl]];
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           // Lo hago en primer plano para asegurarme de
                           // todas las ntificaciones van en la ocla
                           // principal
                           [self setNewImageWithData:data intoPhoto: photo andNSManagedObjectContext: context];
                       });
                   });
    
}
+(void) setNewImageWithData:(NSData *) data intoPhoto:(LARPhoto *) photo andNSManagedObjectContext: (NSManagedObjectContext *) context{
    
    
    
    // Guardo la imagen en  (con el nombre que tenia en la url
    // original.
    //NSURL *localURL = [self localURLForRemoteURL:self.remoteImageURL];
    //[data writeToURL:localURL atomically:YES];
    
    // Asigno como nueva imagen (esto envía notificación de KVO)
    //photo.image = [UIImage imageWithData:data];
    photo.photoData = data;
    
    NSError *error;
    [context save:&error];
    
    [self setupNotifications];
    [self saveImagesIntoDcouments:photo];
}

+(void) saveImagesIntoDcouments: (LARPhoto *) photo{

        
        //Guardamos la imagen con el nombre del libro + jpg
        NSMutableString *nombreLibro = [[NSMutableString alloc] init];
        [nombreLibro appendString:@"Documents/HackerBook/Pictures/"];
        [nombreLibro appendString:photo.photoUrl];
        [nombreLibro appendString:@".jpg"];
        
        //Averiguar la URL a la carpeta Documents
        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:nombreLibro];
        
        
        
        [photo.photoData writeToFile:jpgPath atomically:YES];
    
}

-(void) setImage:(UIImage *)image{
    
    // Convertir la UIImage en un NSData
    if (image) {
        self.photoData = UIImageJPEGRepresentation(image, 0.9);
    }
    
}

-(UIImage *) image{
    
    // Convertir la NSData en UIImage
    return [UIImage imageWithData:self.photoData];
}

-(void) saveImage: (UIImage *)image inAnnotation: (LARAnnotation *) annotation andContext: (NSManagedObjectContext *) context{
    
    LARPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                                    inManagedObjectContext:context];
    photo.image = image;
    photo.annotation = annotation;
    photo.photoData = UIImageJPEGRepresentation(image, 0.9);
    
    NSError * error;
    
    [context save:&error];
    
    // Convertir la UIImage en un NSData
    self.photoData = UIImageJPEGRepresentation(photo.image, 0.9);
}

#pragma mark - Notifications
+(void) setupNotifications{
    
    NSNotification *n = [NSNotification
                         notificationWithName:@"CHANGE_BOOKS_IN_TAGS"
                         object:self
                         userInfo:@{@"bookFavorite" : self}];
    
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
}

@end
