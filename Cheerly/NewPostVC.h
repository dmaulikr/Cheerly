//
//  NewPostVC.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABFlatSwitch.h"
#import "HPGrowingTextView.h"

@interface NewPostVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, HPGrowingTextViewDelegate>

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIImage *imageCache;
@property (strong, nonatomic) HPGrowingTextView *captionField;
@property (strong, nonatomic) ABFlatSwitch *facebookSwitch;
@property (strong, nonatomic) ABFlatSwitch *twitterSwitch;


@end
