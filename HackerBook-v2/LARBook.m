#import "LARBook.h"
#import "LARAuthor.h"
#import "LARTag.h"
#import "LARPhoto.h"
#import "LARPdf.h"

@interface LARBook ()

@end

@implementation LARBook

+(instancetype)  initWithTitulo: (NSString *)titulo
                     isFavorite: (BOOL) isFavorite
                         author: (NSString *) authors
                           tags: (NSString *) tags
                            pdf: (NSString *) urlPDF
                       urlPhoto: (NSString *) urlPhoto
                        context: (NSManagedObjectContext * ) context{
    
    LARBook *book = [self insertInManagedObjectContext:context];
    book.title = titulo;
    [book setIsFavoriteValue:isFavorite];
    
    [LARAuthor addAuthorWithNames:authors context:context book:book];

    [LARTag addTagWithNames:tags context:context book:book];
    
    [LARPhoto addPhotoWithName: titulo andURL: urlPhoto context:context book:book];
    
    [LARPdf addPdfWithName:titulo andURL:urlPDF context:context book:book];

    return book;
}

-(NSString *) authorsWithNameAndSeparate{
    
    NSSet *authors = self.authors;
    NSMutableString *authorsString = [[NSMutableString alloc] init];
    
    for (LARAuthor *author in authors) {
        [authorsString appendString:author.name];
        [authorsString appendString:@", "];
    }
    
    return authorsString;
}

-(NSString *) tagsWithNameAndSeparate{
    
    NSSet *tags = self.tags;
    NSMutableString *tagsString = [[NSMutableString alloc] init];
    
    for (LARTag *tag in tags) {
        [tagsString appendString:tag.name];
        [tagsString appendString:@", "];
    }
    
    return tagsString;
    
}




















@end
