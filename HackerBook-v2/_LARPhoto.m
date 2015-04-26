// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARPhoto.m instead.

#import "_LARPhoto.h"

const struct LARPhotoAttributes LARPhotoAttributes = {
	.photoData = @"photoData",
	.photoUrl = @"photoUrl",
};

const struct LARPhotoRelationships LARPhotoRelationships = {
	.annotation = @"annotation",
	.book = @"book",
};

@implementation LARPhotoID
@end

@implementation _LARPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (LARPhotoID*)objectID {
	return (LARPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic photoUrl;

@dynamic annotation;

@dynamic book;

@end

