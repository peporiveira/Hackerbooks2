#import "LARTag.h"
#import "LARBook.h"

@interface LARTag ()

// Private interface goes here.

@end

@implementation LARTag


+(void) addTagWithNames: (NSString *) tags context: (NSManagedObjectContext *) context book: (LARBook *) book{
    
    NSMutableSet *tagsSet = [[NSMutableSet alloc] init];
    
    NSArray *bookTags = [tags componentsSeparatedByString:@", "];
    
    for (NSString *tagName in bookTags) {
        
        //Lo busco
        NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", tagName];
        [fetch setPredicate:predicate];
        NSError *error;
        NSArray *results = [context executeFetchRequest:fetch error:&error];
        
        if (results.count != 0 ) {
            
            
            [book addTagsObject:[results lastObject]];
            
        }else{
            LARTag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
                                                        inManagedObjectContext:context];
            tag.name = tagName;
            [tagsSet addObject:tag];
            book.tags = tagsSet;
            
        }
        
    }
    
}

#pragma mark - Favorites

+(void) addTagFavoriteWithBook: (LARBook *)book andManagedObjectContext: (NSManagedObjectContext *) managedObjectContext{
    
    NSMutableSet *tagsSet = [book.tags mutableCopy];
    
    NSArray *arrayFavorites = [self existFavoritesInManagedObjectContext: managedObjectContext];
    
    LARTag *tag;
    if (arrayFavorites.count == 0) {
        tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
                                                    inManagedObjectContext:managedObjectContext];
        tag.name = @"Favorite";
        
    }else{
        tag = [arrayFavorites lastObject];
    }
    [tagsSet addObject:tag];
    
    book.tags = tagsSet;
    
    
}

+(NSArray *) existFavoritesInManagedObjectContext: (NSManagedObjectContext *) managedObjectContext{
    
    // Buscar
    NSFetchRequest *req = [NSFetchRequest
                           fetchRequestWithEntityName:[LARTag entityName]];
    
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:LARTagAttributes.name
                             ascending:YES
                             selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20;
    req.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"Favorite"];
    
    NSError *error;
    return [managedObjectContext executeFetchRequest:req error:&error];
    
    

}

+(void) removeBook: (LARBook *) book InFavoriteWithManagedObjectContext: (NSManagedObjectContext *) managedObjectContext{
    
    
    NSSet *set = book.tags;
    
    for (LARTag *tag in set) {
        if ([tag.name isEqualToString:@"Favorite"]) {
            [book removeTagsObject:tag];
            [self removeTagFavoriteWithManagedObjectContext:managedObjectContext];
            
            
            
            break;
        }
    }
    
}

+(void) removeTagFavoriteWithManagedObjectContext: (NSManagedObjectContext *) managedObjectContext{
    
    //Compruebo si hay libros en el Tag Favorite
    NSArray *arrayFavorites = [self existFavoritesInManagedObjectContext:managedObjectContext];
    
    if (arrayFavorites.count > 0) {
        
        LARTag *tag = [arrayFavorites lastObject];
        
        if (tag.books.count == 0) {
            [managedObjectContext deleteObject:tag];
        }
        
    }
    
    
}







#pragma mark - Comparison
- (NSComparisonResult)compare:(LARTag *)other{
    
    /* favorite always comes first */
    static NSString *fav = @"Favorite";
    
    if ([[self normalizedName] isEqualToString:[other normalizedName]]) {
        return NSOrderedSame;
    }else if ([[self normalizedName] isEqualToString:fav]){
        return NSOrderedAscending;
    }else if ([[other normalizedName] isEqualToString:fav]){
        return NSOrderedDescending;
    }else{
        return [self.name compare:other.normalizedName];
    }
}

-(NSString*) normalizedName{
    return self.name;
}




-(NSInteger) numberOfObjects{
    
    return [[self.books allObjects] count];
}





#pragma mark - Methods to search



+ (NSArray *)fetchItemsInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSArray *results = [[NSArray alloc] init];
    
    
    //prepare fetch request for items
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:managedObjectContext];
    
    
    //execute fetch request
    NSError *error = nil;
    
    NSArray *items = [managedObjectContext executeFetchRequest:request error:&error];
    
    if(items) {
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil];
        
        results = [items sortedArrayUsingDescriptors:sortDescriptors];
    }
    
    return results;
}

+ (NSArray *)fetchDistinctItemGroupsInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSArray *results = [[NSArray alloc] init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entity];
    
    [request setResultType:NSDictionaryResultType];
    
    [request setReturnsDistinctResults:YES];
    
    [request setPropertiesToFetch:@[@"name"]];
    
    NSError *error = nil;
    
    //note, an array of NSDictionaries is returned where the key is the property name (e.g. group) and the value is the letter
    NSArray *items = [managedObjectContext executeFetchRequest:request error:&error];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:items.count];
    
    for(NSDictionary *currentDictionary in items) {
        
        [mutableArray addObject:[currentDictionary objectForKey:@"name"]];
    }
    
    results = [NSArray arrayWithArray:mutableArray];
    
    return results;
}

+ (NSMutableArray *)fetchItemNamesBeginningWith:(NSString *)searchText inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSArray *results = [[NSArray alloc] init];
    
    //prepare fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:managedObjectContext];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[c] %@", searchText];
    
    //execute fetch request
    NSArray *items =  [managedObjectContext executeFetchRequest:request error:nil];
    
    //serialize to an array of name string objects
    NSMutableArray *tags = [[NSMutableArray alloc] initWithCapacity:items.count];
    
    for(LARTag *currentItem in items) {
        
        //add the item name
        [tags addObject:currentItem];
    }
    
    //serialize to non-mutable
    results = [NSArray arrayWithArray: tags];
    
    return tags;
}

+ (NSMutableArray *)fetchItemNamesByGroupInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSArray *results = [[NSArray alloc] init];
    
    
    //groups
    NSArray *itemGroups = [LARTag fetchDistinctItemGroupsInManagedObjectContext:managedObjectContext];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:itemGroups.count];
    
    for(NSString *group in itemGroups) {
        
        //items in group
        NSArray *groupItems = [LARTag fetchItemNamesBeginningWith:group inManagedObjectContext:managedObjectContext];
        
        
        //create item and group structure
        NSDictionary *itemAndGroup = [[NSDictionary alloc] initWithObjectsAndKeys:groupItems, group, nil];
        
        [mutableArray addObject:itemAndGroup];
    }
    
    //serialize to non-mutable
    results = [NSArray arrayWithArray:mutableArray];
    
    return mutableArray;
}

+ (NSDictionary *)fetchItemNamesByGroupFilteredBySearchText:(NSString *)searchText inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSDictionary *result = nil;
    
    //to be used as the key for the returned NSDictionary
    NSString *firstLetterOfSearchText = [[searchText substringToIndex:1] uppercaseString];
    
    NSArray *itemNames = [LARTag fetchItemNamesBeginningWith:searchText inManagedObjectContext:managedObjectContext];
    
    result = [[NSDictionary alloc] initWithObjectsAndKeys:itemNames, firstLetterOfSearchText, nil];
    
    return result;
}

@end
