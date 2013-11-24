//
//  NSDictionary+Null.h
//  Panogramic
//
//  Created by Francisco Yarad on 3/14/13.
//  Copyright (c) 2013 fyarad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NotNull)

- (BOOL)notNull:(NSString*)key;
- (BOOL)notNull:(NSString*)key ofKey:(NSString*)secondKey;

@end
