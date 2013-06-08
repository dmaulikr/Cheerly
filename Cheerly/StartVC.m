//
//  StartVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "StartVC.h"
#import "Constants.h"

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [Colors lightBackground];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 320, 568)];
    [backgroundView setImage:[UIImage imageNamed:@"start_sample.png"]];
    [self.view addSubview:backgroundView];
    
    _fbButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 98 , 300, 40)];
    [_fbButton setBackgroundImage:[UIImage imageNamed:@"start_fb_button.png"] forState:UIControlStateNormal];
    [_fbButton addTarget:self action:@selector(facebookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fbButton];
    
}

- (IBAction)facebookAction:(id)sender {

    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFFacebookUtils logInWithPermissions:@[@"email"] block:^(PFUser *user, NSError *error) {

        if (user.isNew) {
            [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (connection.urlResponse.statusCode == 200) {
                    if ([result notNull:@"name"]) [user setObject:result[@"name"] forKey:@"name"];
                    if ([result notNull:@"email"]) user.email = result[@"email"];
                    if ([result notNull:@"username"]) user.username = result[@"username"];
                    else user.username = result[@"id"];
                    [user saveInBackground];
                }
                [progressHUD hide:YES];
                [SplashVC presentMenuOnController:self];
            }];
        }
        else {
            if (user) [SplashVC presentMenuOnController:self];
            [progressHUD hide:YES];
        }
    }];

}

@end
