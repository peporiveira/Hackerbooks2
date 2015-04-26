// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARAnnotation.m instead.

#import "_LARAnnotation.h"

const struct LARAnnotationAttributes LARAnnotationAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
	.text = @"text",
};

const struct LARAnnotationRelationships LARAnnotationRelationships = {
	.book = @"book",
	.localization = @"localization",
	.photo = @"photo",
};

@implementation LARAnnotationID
@end

@implementation _LARAnnotation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:moc_];
}

- (LARAnnotationID*)objectID {
	return (LARAnnotationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@dynamic text;

@dynamic book;

@dynamic localization;

@dynamic photo;

@end

