// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARLocalization.h instead.

@import CoreData;
#import "LARHackerBookBaseClass.h"

extern const struct LARLocalizationAttributes {
	__unsafe_unretained NSString *direction;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
} LARLocalizationAttributes;

extern const struct LARLocalizationRelationships {
	__unsafe_unretained NSString *annotation;
} LARLocalizationRelationships;

@class LARAnnotation;

@interface LARLocalizationID : NSManagedObjectID {}
@end

@interface _LARLocalization : LARHackerBookBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LARLocalizationID* objectID;

@property (nonatomic, strong) NSString* direction;

//- (BOOL)validateDirection:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* latitude;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* longitude;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LARAnnotation *annotation;

//- (BOOL)validateAnnotation:(id*)value_ error:(NSError**)error_;

@end

@interface _LARLocalization (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveDirection;
- (void)setPrimitiveDirection:(NSString*)value;

- (NSString*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSString*)value;

- (NSString*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSString*)value;

- (LARAnnotation*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(LARAnnotation*)value;

@end
