//
//  NewPostVC.h
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPostVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIImage *imageCache;
@property (strong, nonatomic) UITextField *captionField;


@end
