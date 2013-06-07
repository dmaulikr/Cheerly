//
//  Colors.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Colors : NSObject

+ (UIImage*)toImage:(UIColor*)color;

// Labels
+ (UIColor*)lightGray;
+ (UIColor*)normalGray;
+ (UIColor*)darkGray;

// Backgrounds
+ (UIColor*)lightBackground;
+ (UIColor*)lightBackgroundShadow;
+ (UIColor*)background;
+ (UIColor*)backgroundShadow;
+ (UIColor*)organge;
+ (UIColor*)organgeShadow;

@end
