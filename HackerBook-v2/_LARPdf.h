// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARPdf.h instead.

@import CoreData;
#import "LARHackerBookBaseClass.h"

extern const struct LARPdfAttributes {
	__unsafe_unretained NSString *pdfData;
	__unsafe_unretained NSString *pdfUrl;
} LARPdfAttributes;

extern const struct LARPdfRelationships {
	__unsafe_unretained NSString *book;
} LARPdfRelationships;

@class LARBook;

@interface LARPdfID : NSManagedObjectID {}
@end

@interface _LARPdf : LARHackerBookBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LARPdfID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* pdfUrl;

//- (BOOL)validatePdfUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _LARPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (NSString*)primitivePdfUrl;
- (void)setPrimitivePdfUrl:(NSString*)value;

- (LARBook*)primitiveBook;
- (void)setPrimitiveBook:(LARBook*)value;

@end
