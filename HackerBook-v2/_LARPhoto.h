// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARPhoto.h instead.

@import CoreData;
#import "LARHackerBookBaseClass.h"

extern const struct LARPhotoAttributes {
	__unsafe_unretained NSString *photoData;
	__unsafe_unretained NSString *photoUrl;
} LARPhotoAttributes;

extern const struct LARPhotoRelationships {
	__unsafe_unretained NSString *annotation;
	__unsafe_unretained NSString *book;
} LARPhotoRelationships;

@class LARAnnotation;
@class LARBook;

@interface LARPhotoID : NSManagedObjectID {}
@end

@interface _LARPhoto : LARHackerBookBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LARPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* photoUrl;

//- (BOOL)validatePhotoUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARAnnotation *annotation;

//- (BOOL)validateAnnotation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _LARPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSString*)primitivePhotoUrl;
- (void)setPrimitivePhotoUrl:(NSString*)value;

- (LARAnnotation*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(LARAnnotation*)value;

- (LARBook*)primitiveBook;
- (void)setPrimitiveBook:(LARBook*)value;

@end
