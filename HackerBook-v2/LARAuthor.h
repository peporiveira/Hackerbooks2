#import "_LARAuthor.h"

@interface LARAuthor : _LARAuthor {}


+(instancetype)  initWithName: (NSString *)name
                      context: (NSManagedObjectContext * ) context;

+(void) addAuthorWithNames: (NSString *) tags context: (NSManagedObjectContext *) context book: (LARBook *) book;

@end
