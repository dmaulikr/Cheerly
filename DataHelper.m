//
//  DataHelper.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper

+ (UserProfile*)user:(PFUser *)user {
    
    UserProfile *userProfile = [[UserProfile alloc] initWithClassName:NSStringFromClass([UserProfile class])];

    return userProfile;
}

@end
