//
//  MenuVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "MenuVC.h"
#import "Constants.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Colors darkGray];

    PFUser *user = [PFUser currentUser];

    UIImageView *menuBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    [menuBackground setImage:[UIImage imageNamed:@"menu_sample.png"]];
    [self.view addSubview:menuBackground];
    
    // User
    //UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 134, 320, 46)];
    [homeButton setBackgroundColor:[UIColor clearColor]];
    [homeButton addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeButton];
    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 265, 320, 46)];
    [logoutButton setBackgroundColor:[UIColor clearColor]];
    [logoutButton addTarget:self action:@selector(logoutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    
}

- (void)initViewControllers {
    self.feedVC = [[UINavigationController alloc] initWithRootViewController:[[FeedVC alloc] init]];
}

#pragma Actions

- (IBAction)homeButtonAction:(id)sender {
    [self.sidePanelController setCenterPanel:_feedVC];
}
- (IBAction)logoutButtonAction:(id)sender {
    [PFUser logOut];
    StartVC *controller = [[StartVC alloc] init];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:^{
        _feedVC = nil;
        self.sidePanelController.centerPanel = nil;
        self.sidePanelController.leftPanel = nil;
    }];

}

@end
