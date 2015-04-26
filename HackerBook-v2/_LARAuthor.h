// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARAuthor.h instead.

@import CoreData;
#import "LARHackerBookBaseClass.h"

extern const struct LARAuthorAttributes {
	__unsafe_unretained NSString *name;
} LARAuthorAttributes;

extern const struct LARAuthorRelationships {
	__unsafe_unretained NSString *books;
} LARAuthorRelationships;

@class LARBook;

@interface LARAuthorID : NSManagedObjectID {}
@end

@interface _LARAuthor : LARHackerBookBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LARAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _LARAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(LARBook*)value_;
- (void)removeBooksObject:(LARBook*)value_;

@end

@interface _LARAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
