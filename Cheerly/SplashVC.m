//
//  SplashVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "SplashVC.h"
#import "Constants.h"

@implementation SplashVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];

    if (currentUser) {

    }
    else {

    }

    StartVC *controller = [[StartVC alloc] init];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];

}

@end
