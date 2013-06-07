//
//  DesignHelper.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface DesignHelper : NSObject

// User

+ (UIView*)profileOfUser:(PFUser*)user;

// NavBar

+ (void)setNavBarAppeareance;
+ (UIBarButtonItem*)barButton:(NSString*)title target:(id)controller selector:(SEL)selector;
+ (UIBarButtonItem*)barButton:(NSString*)title target:(id)controller selector:(SEL)selector loading:(BOOL)loading;
+ (UIBarButtonItem*)barButtonImage:(NSString*)image_name target:(id)controller selector:(SEL)selector;
+ (UIBarButtonItem*)barBackButton:(NSString*)title target:(id)controller selector:(SEL)selector;
+ (UIBarButtonItem*)barBackButton:(UIViewController*)controller;
+ (UIView*)navLogo;


@end
