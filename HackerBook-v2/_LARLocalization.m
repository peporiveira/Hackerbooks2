// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARLocalization.m instead.

#import "_LARLocalization.h"

const struct LARLocalizationAttributes LARLocalizationAttributes = {
	.direction = @"direction",
	.latitude = @"latitude",
	.longitude = @"longitude",
};

const struct LARLocalizationRelationships LARLocalizationRelationships = {
	.annotation = @"annotation",
};

@implementation LARLocalizationID
@end

@implementation _LARLocalization

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Localization" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Localization";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Localization" inManagedObjectContext:moc_];
}

- (LARLocalizationID*)objectID {
	return (LARLocalizationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic direction;

@dynamic latitude;

@dynamic longitude;

@dynamic annotation;

@end

