//
//  MenuVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "MenuVC.h"
#import "Constants.h"

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Colors background];
}

- (void)initViewControllers {
    self.feedVC = [[UINavigationController alloc] initWithRootViewController:[[FeedVC alloc] init]];
}

@end
