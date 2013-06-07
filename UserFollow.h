//
//  UserFollow.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface UserFollow : PFObject

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) PFUser *receiver;

@end
