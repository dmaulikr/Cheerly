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
    
    _fbButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 50 , 300, 40)];
    [_fbButton setBackgroundColor:[Colors organge]];
    [_fbButton setTitle:@"Connect with Facebook" forState:UIControlStateNormal];
    [_fbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_fbButton addTarget:self action:@selector(facebookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fbButton];
    
}

- (IBAction)facebookAction:(id)sender {

    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFFacebookUtils logInWithPermissions:@[@"email"] block:^(PFUser *user, NSError *error) {

        if (user.isNew) {
            [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (connection.urlResponse.statusCode == 200) {
                    NSLog(@"%@", result);
                    UserProfile *newUser = [[UserProfile alloc] initWithClassName:@"UserProfile"];
                    newUser.user = user;
                    if ([result notNull:@"name"]) newUser.name = result[@"name"];
                    if ([result notNull:@"email"]) user.email = result[@"email"];
                    if ([result notNull:@"username"]) user.username = result[@"username"];
                    else user.username = result[@"id"];
                    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        [newUser saveInBackground];                       
                    }];
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
