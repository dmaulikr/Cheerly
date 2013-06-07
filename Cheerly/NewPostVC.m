//
//  NewPostVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "NewPostVC.h"
#import "Constants.h"

@implementation NewPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New Goal";
    self.view.backgroundColor = [Colors lightBackground];
    self.navigationItem.leftBarButtonItem = [DesignHelper barButtonImage:@"navbar_cancel.png" target:self selector:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [DesignHelper barButton:@"Post" target:self selector:@selector(postAction)];
    [self setUp];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_imageCache) [_image setImage:_imageCache];
    [_captionField setHidden:(_imageCache == nil)];
}
- (void)setUp {
    
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    [_image setImage:[UIImage imageNamed:@"newpost_placeholder.png"]];
    [_image setClipsToBounds:YES];
    [_image setUserInteractionEnabled:YES];
    [_image setContentMode:UIViewContentModeScaleAspectFill];
    [_image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction:)]];
    [_image setClipsToBounds:YES];
    [_image.layer setCornerRadius:5.0];
    [self.view addSubview:_image];
    
    _captionField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    [_captionField setBackgroundColor:[UIColor clearColor]];
    [_captionField setTextColor:[UIColor whiteColor]];
    [_captionField setFont:[Font normalSize:18]];
    [_captionField setHidden:YES];
    [_captionField setDelegate:self];
    [self.view addSubview:_captionField];
    
    UIButton *postButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 320, 300, 40)];
    [postButton setBackgroundImage:[[UIImage imageNamed:@"orange_button.png"] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [postButton setTitle:@"Post" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateHighlighted];
    [postButton setClipsToBounds:YES];
    [postButton.titleLabel setFont:[Font boldSize:18]];
    [postButton.layer setCornerRadius:5.0];
    [postButton addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postButton];
    
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Post

- (void)postAction {
    
    if (_imageCache && _captionField.text.length > 0) {
        Post *post = [[Post alloc] initWithClassName:@"Post"];
        post.user = [PFUser currentUser];
        post.image = [PFFile fileWithName:@"goal_image.jpg" data:UIImageJPEGRepresentation(self.imageCache, 0.8)];
        post.caption = _captionField.text;
        
        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Uploaded");
            }
            else {
                NSLog(@"%@", error);
            }
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

#pragma Image

- (IBAction)imageAction:(id)sender {

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    BlockActionSheet *alert = [BlockActionSheet sheetWithTitle:nil];
    [alert addOrangeButtonWithTitle:@"Take a Picture" block:^{
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alert addOrangeButtonWithTitle:@"Choose from Library" block:^{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alert addButtonWithTitle:@"Cancel" block:nil];
    [alert showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _imageCache = info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
