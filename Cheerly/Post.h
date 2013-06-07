//
//  Post.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface Post : PFObject

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) PFFile *image;


@end
