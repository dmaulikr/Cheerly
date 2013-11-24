//
//  UIButton+Block.m
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//

#import "UIButton+Block.h"

#import "/usr/include/objc/runtime.h"

@implementation UIButton (Block)

static char overviewKey;

@dynamic actions;

- (void)setTouchAction:(void (^)())block {
    if ([self actions] == nil) [self setActions:[[NSMutableDictionary alloc] init]];
    [[self actions] setObject:block forKey:@"TouchInside"];
    [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)doTouchUpInside:(id)sender {
    void(^block)();
    block = self.actions[@"TouchInside"];
    block();
}


#pragma Memory Managment

- (void)setActions:(NSMutableDictionary*)actions {
    objc_setAssociatedObject (self, &overviewKey,actions,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)actions {
    return objc_getAssociatedObject(self, &overviewKey);
}


@end
