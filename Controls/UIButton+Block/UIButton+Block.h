//
//  UIButton+Block.h
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)

@property (nonatomic, strong) NSMutableDictionary *actions;

- (void)setTouchAction:(void(^)())block;

@end