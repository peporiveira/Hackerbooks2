#import "_LARBook.h"

@interface LARBook : _LARBook {}

//Designated
+(instancetype)  initWithTitulo: (NSString *)titulo
                     isFavorite: (BOOL) isFavorite
                         author: (NSString *) authors
                           tags: (NSString *) tags
                            pdf: (NSString *) urlPDF
                       urlPhoto: (NSString *) urlPhoto
                        context: (NSManagedObjectContext * ) context;

-(NSString *) authorsWithNameAndSeparate;
-(NSString *) tagsWithNameAndSeparate;

@end
