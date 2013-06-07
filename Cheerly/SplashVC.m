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

    if (currentUser.isAuthenticated) {
        [SplashVC presentMenuOnController:self];
    }
    else {
        StartVC *controller = [[StartVC alloc] init];
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

+ (void)presentMenuOnController:(UIViewController*)controller {
    MenuVC *menuVC = [[MenuVC alloc] init];
    [menuVC initViewControllers];
    
    JASidePanelController *panelController = [[JASidePanelController alloc] init];
    [panelController setShouldDelegateAutorotateToVisiblePanel:NO];
    [panelController setLeftPanel:menuVC];
    [panelController setCenterPanel:menuVC.feedVC];
    panelController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] setPanelController:panelController];
    [controller presentViewController:panelController animated:YES completion:nil];

}

@end
