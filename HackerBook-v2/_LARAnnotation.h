// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARAnnotation.h instead.

@import CoreData;
#import "LARHackerBookBaseClass.h"

extern const struct LARAnnotationAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *text;
} LARAnnotationAttributes;

extern const struct LARAnnotationRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *localization;
	__unsafe_unretained NSString *photo;
} LARAnnotationRelationships;

@class LARBook;
@class LARLocalization;
@class LARPhoto;

@interface LARAnnotationID : NSManagedObjectID {}
@end

@interface _LARAnnotation : LARHackerBookBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LARAnnotationID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARLocalization *localization;

//- (BOOL)validateLocalization:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _LARAnnotation (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (LARBook*)primitiveBook;
- (void)setPrimitiveBook:(LARBook*)value;

- (LARLocalization*)primitiveLocalization;
- (void)setPrimitiveLocalization:(LARLocalization*)value;

- (LARPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(LARPhoto*)value;

@end
