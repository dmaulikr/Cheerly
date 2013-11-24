//
//  NSDictionary+Null.m
//  Panogramic
//
//  Created by Francisco Yarad on 3/14/13.
//  Copyright (c) 2013 fyarad. All rights reserved.
//

#import "NSDictionary+Null.h"

@implementation NSDictionary (NotNull)

- (BOOL)notNull:(NSString *)key {
    return (self[key] != nil) ? ((NSNull*)self[key] != [NSNull null]) : false;
}
- (BOOL)notNull:(NSString *)key ofKey:(NSString *)secondKey {
    return ([self notNull:key]) ? [(NSDictionary*)self[key] notNull:secondKey] : false;
}
@end
