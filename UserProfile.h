//
//  UserProfile.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface UserProfile : PFObject

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) int followersCount;
@property (nonatomic) int followingCount;
@property (nonatomic) int goalCount;

@end
