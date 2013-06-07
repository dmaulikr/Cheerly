//
//  Colors.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "Colors.h"

@implementation Colors

+ (UIImage*)toImage:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// Labels

+ (UIColor*)lightGray {
    return [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
}
+ (UIColor*)normalGray {
    return [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
}
+ (UIColor*)darkGray {
    return [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
}

// Backgrounds

+ (UIColor*)lightBackground {
    return [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.0];
}
+ (UIColor*)lightBackgroundShadow {
    return [UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.0];
}
+ (UIColor*)background {
    return [UIColor colorWithRed:0.58 green:0.58 blue:0.65 alpha:1.0];
}
+ (UIColor*)backgroundShadow {
    return [UIColor colorWithRed:0.49 green:0.55 blue:0.55 alpha:1.0];
}
+ (UIColor*)organge {
    return [UIColor colorWithRed:0.90 green:0.49 blue:0.22 alpha:1.0];
}
+ (UIColor*)organgeShadow {
    return [UIColor colorWithRed:0.83 green:0.33 blue:0.16 alpha:1.0];
}


@end
