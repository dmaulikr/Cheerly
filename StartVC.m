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
    
    _fbButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 50 , 300, 40)];
    [_fbButton setBackgroundColor:[UIColor blueColor]];
    [_fbButton setTitle:@"Connect with Facebook" forState:UIControlStateNormal];
    [_fbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_fbButton addTarget:self action:@selector(facebookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fbButton];
    
}

- (IBAction)faceookAction:(id)sender {

    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFFacebookUtils logInWithPermissions:@[@"email"] block:^(PFUser *user, NSError *error) {
        [progressHUD hide:YES];
        /*if (!user) {
         NSLog(@"Uh oh. The user cancelled the Facebook login.");
         }
         else if (user.isNew) {
         NSLog(@"User signed up and logged in through Facebook!");
         }
         else {
         NSLog(@"User logged in through Facebook!");
         }*/
        
        if (user) {
            
        }
    }];

}

@end
