//
//  DesignHelper.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "DesignHelper.h"
#import "Constants.h"

@implementation DesignHelper


#pragma NavBar

+ (void)setNavBarAppeareance {
    [[UINavigationBar appearance] setBackgroundImage:[Colors toImage:[Colors organge]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor], UITextAttributeTextShadowColor : [UIColor clearColor], UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeFont : [Font normalSize:0.0]}];
}
+ (UIBarButtonItem*)barButton:(NSString *)title target:(id)controller selector:(SEL)selector {
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:controller action:selector];
}
+ (UIBarButtonItem*)barButton:(NSString *)title target:(id)controller selector:(SEL)selector loading:(BOOL)loading {
    if (loading) {
        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [active setFrame:CGRectMake(0, 0, 40, 20)];
        [active startAnimating];
        return [[UIBarButtonItem alloc] initWithCustomView:active];
    }
    else return [self barButton:title target:controller selector:selector];
}
+ (UIBarButtonItem*)barButtonImage:(NSString*)image_name target:(id)controller selector:(SEL)selector {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:controller action:selector];
    [barButton setBackgroundImage:[UIImage imageNamed:@"nil.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButton setImage:[UIImage imageNamed:image_name]];
    return barButton;
}
+ (UIBarButtonItem*)barBackButton:(NSString *)title target:(id)controller selector:(SEL)selector {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:controller action:selector];
    [barButton setBackgroundImage:[[UIImage imageNamed:@"nav_back.png"] stretchableImageWithLeftCapWidth:14 topCapHeight:0] forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    [barButton setTitlePositionAdjustment:UIOffsetMake(3, 0) forBarMetrics:UIBarMetricsDefault];
    return barButton;
}
+ (UIBarButtonItem*)barBackButton:(UIViewController *)controller {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [button addTarget:controller.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"nav_back_custom.png"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIView*)navLogo {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo.png"]];
}

@end
