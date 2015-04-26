#import "_LARPdf.h"

@interface LARPdf : _LARPdf {}


+(void) addPdfWithName: (NSString *) titulo andURL: (NSString *) urlPdf context: (NSManagedObjectContext *) context book: (LARBook *) book;
+(void) setNewImageWithData:(NSData *) data intoPdf:(LARPdf *) pdf andNSManagedObjectContext: (NSManagedObjectContext *) context;

@end
