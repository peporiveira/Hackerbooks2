//
//  LARAnnotation.h
//  HackerBook-v2
//
//  Created by Luis Aparicio on 15/04/2015.
//  Copyright (c) 2015 ALuis Aparicio. All rights reserved.
//

#import "_LARAnnotation.h"
@class LARBook;

@interface LARAnnotation : _LARAnnotation {}

+(instancetype) annotationWithName:(NSString *) name
                              book:(LARBook *) book
                           context:(NSManagedObjectContext *) context;

@end
