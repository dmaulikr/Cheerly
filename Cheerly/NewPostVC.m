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
    
    _captionField = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(10, 10 + ((300-47)/2), 300, 47)];
    _captionField.minNumberOfLines = 1;
    _captionField.maxNumberOfLines = 8;
    _captionField.returnKeyType = UIReturnKeySend;
    _captionField.font = [Font boldSize:24];
    _captionField.textColor = [UIColor whiteColor];
    _captionField.delegate = self;
    _captionField.hidden = YES;
    _captionField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:_captionField];

    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(10, 320, 300, 80)];
    [shareView setBackgroundColor:[UIColor whiteColor]];
    [shareView setClipsToBounds:YES];
    [shareView.layer setCornerRadius:5.0];
    [self.view addSubview:shareView];
    
    UILabel *shareFacebookLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 280, 40)];
    [shareFacebookLabel setBackgroundColor:[UIColor clearColor]];
    [shareFacebookLabel setFont:[Font boldSize:14]];
    [shareFacebookLabel setTextColor:[Colors normalGray]];
    [shareFacebookLabel setText:@"Share to Facebook"];
    [shareView addSubview:shareFacebookLabel];
    
    _facebookSwitch = [[ABFlatSwitch alloc] initWithFrame:CGRectMake(220, 7.5, 70, 25)];
    _facebookSwitch.labelFont = [Font boldSize:16];
    _facebookSwitch.labelColor = [UIColor whiteColor];
    _facebookSwitch.onTintColor = [Colors organge];
    _facebookSwitch.offTintColor = [Colors lightGray];
    _facebookSwitch.knobInset = NO;
    _facebookSwitch.onText = @"YES";
    _facebookSwitch.offText = @"NO";
    [_facebookSwitch setOn:YES];
    //[_facebookSwitch addTarget:self action:@selector(facebookSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [shareView addSubview:_facebookSwitch];
    
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 300, 1)];
    [divider setBackgroundColor:[Colors lightBackground]];
    [shareView addSubview:divider];
    
    UILabel *shareTwitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 280, 40)];
    [shareTwitterLabel setBackgroundColor:[UIColor clearColor]];
    [shareTwitterLabel setFont:[Font boldSize:14]];
    [shareTwitterLabel setTextColor:[Colors normalGray]];
    [shareTwitterLabel setText:@"Share to Twitter"];
    [shareView addSubview:shareTwitterLabel];

    _twitterSwitch = [[ABFlatSwitch alloc] initWithFrame:CGRectMake(220, 47.5, 70, 25)];
    _twitterSwitch.labelFont = [Font boldSize:16];
    _twitterSwitch.labelColor = [UIColor whiteColor];
    _twitterSwitch.onTintColor = [Colors organge];
    _twitterSwitch.offTintColor = [Colors lightGray];
    _twitterSwitch.knobInset = NO;
    _twitterSwitch.onText = @"YES";
    _twitterSwitch.offText = @"NO";
    //[_twitterSwitch addTarget:self action:@selector(twitterSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [shareView addSubview:_twitterSwitch];

    UIButton *postButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 410, 300, 40)];
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
        post.image = [PFFile fileWithData:UIImageJPEGRepresentation(self.imageCache, 0.8)];
        post.caption = _captionField.text;
        post.cheers_count = 0;
        
        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Uploaded");
            }
            else {
                NSLog(@"%@", error);
            }
        }];
        
        // Post to Fb
        if (_facebookSwitch.isOn) {
            
           /* [[FBSession activeSession] requestNewPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceOnlyMe completionHandler:^(FBSession *session, NSError *error) {


            }];*/
            

            
            
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma Image

- (IBAction)imageAction:(id)sender {

    if (_captionField.isFirstResponder) {
        [_captionField resignFirstResponder];
    }
    else {
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
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _imageCache = info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma TextView

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height {
    [_captionField setFrame:CGRectMake(10, 10 + ((300 - height) / 2), 300, height)];
}


@end
