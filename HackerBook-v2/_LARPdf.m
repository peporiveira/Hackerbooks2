// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LARPdf.m instead.

#import "_LARPdf.h"

const struct LARPdfAttributes LARPdfAttributes = {
	.pdfData = @"pdfData",
	.pdfUrl = @"pdfUrl",
};

const struct LARPdfRelationships LARPdfRelationships = {
	.book = @"book",
};

@implementation LARPdfID
@end

@implementation _LARPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PDF" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PDF";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PDF" inManagedObjectContext:moc_];
}

- (LARPdfID*)objectID {
	return (LARPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic pdfUrl;

@dynamic book;

@end

