// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARTag.h instead.

@import CoreData;
#import "LARHackerBookBaseClass.h"

extern const struct LARTagAttributes {
	__unsafe_unretained NSString *name;
} LARTagAttributes;

extern const struct LARTagRelationships {
	__unsafe_unretained NSString *books;
} LARTagRelationships;

@class LARBook;

@interface LARTagID : NSManagedObjectID {}
@end

@interface _LARTag : LARHackerBookBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LARTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _LARTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(LARBook*)value_;
- (void)removeBooksObject:(LARBook*)value_;

@end

@interface _LARTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
