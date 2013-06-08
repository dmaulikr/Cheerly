//
//  PostCell.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "PostCell.h"
#import "Constants.h"

@implementation PostCell

- (void)initWithPost:(Post *)post onController:(UIViewController *)controller {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
    [content setBackgroundColor:[UIColor whiteColor]];
    [content.layer setCornerRadius:5.0];
    [content setClipsToBounds:YES];
    [self addSubview:content];
    
    PFUser *user = post[@"user"];
    
    // User image
    UIButton *userImage = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [userImage setBackgroundColor:[Colors darkGray]];
    [userImage setClipsToBounds:YES];
    [userImage setContentMode:UIViewContentModeScaleAspectFill];
    [userImage.layer setCornerRadius:userImage.frame.size.width/2];
    [userImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=120&height=120", user.username]] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
    [userImage setTouchAction:^{
        UserVC *userVC = [[UserVC alloc] init];
        [userVC openUsername:user.username];
        [controller.navigationController pushViewController:userVC animated:YES];
    }];
    [content addSubview:userImage];
    
    // Username
    UIButton *userName = [[UIButton alloc] initWithFrame:CGRectMake(60, 12, 200, 20)];
    [userName setBackgroundColor:[UIColor clearColor]];
    [userName setTitle:user[@"name"] forState:UIControlStateNormal];
    [userName setTitleColor:[Colors darkGray] forState:UIControlStateNormal];
    [userName setTitleColor:[Colors organge] forState:UIControlStateHighlighted];
    [userName.titleLabel setFont:[Font normalSize:18]];
    [userName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [userName setTouchAction:^{
        UserVC *userVC = [[UserVC alloc] init];
        [userVC openUsername:user.username];
        [controller.navigationController pushViewController:userVC animated:YES];
    }];
    [content addSubview:userName];
    
    // Timestamp
    UILabel *timestamp = [[UILabel alloc] initWithFrame:CGRectMake(60, 31, 200, 16)];
    [timestamp setBackgroundColor:[UIColor clearColor]];
    [timestamp setFont:[Font normalSize:14]];
    [timestamp setTextColor:[Colors normalGray]];
    [timestamp setText:[AppHelper humanTimeInterval:post.createdAt longformat:YES]];
    [content addSubview:timestamp];
    
    // Achieve
    if ([user.username isEqualToString:[PFUser currentUser].username]) {
        UIImageView *achieve = [[UIImageView alloc] initWithFrame:CGRectMake(259, 14.5, 31, 31)];
        [achieve setImage:[UIImage imageNamed:@"feed_achive.png"]];
        [achieve setUserInteractionEnabled:YES];
        [achieve setRestorationIdentifier:post.objectId];
        [achieve addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(achieveAction:)]];
        [content addSubview:achieve];
    }
    
    // Image
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 300, 300)];
    [image setImageWithURL:[NSURL URLWithString:[(PFFile*)[post objectForKey:@"image"] url]]];
    [image setClipsToBounds:YES];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [image setBackgroundColor:[Colors normalGray]];
    [image setUserInteractionEnabled:YES];
    [image setRestorationIdentifier:post.objectId];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(postCheerAction:)];
    [doubleTap setNumberOfTapsRequired:2];
    [image addGestureRecognizer:doubleTap];
    
    [content addSubview:image];
    
    // Caption
    NSString *caption = [post[@"caption"] uppercaseString];
    float captionHeight = [caption sizeWithFont:[Font boldSize:24] constrainedToSize:CGSizeMake(280, 600)].height;
    
    UIView *captionBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 60 + ((300-captionHeight)/2), 300, captionHeight)];
    [captionBackground setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [content addSubview:captionBackground];
    
    UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60 + ((300-captionHeight)/2), 280, captionHeight)];
    [captionLabel setBackgroundColor:[UIColor clearColor]];
    [captionLabel setFont:[Font boldSize:24]];
    [captionLabel setTextColor:[UIColor whiteColor]];
    [captionLabel setText:caption];
    [captionLabel setNumberOfLines:0];
    [captionLabel setTextAlignment:NSTextAlignmentCenter];
    [captionLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(postCheerAction:)];
    [doubleTap2 setNumberOfTapsRequired:2];
    [captionLabel addGestureRecognizer:doubleTap2];
    [captionLabel setRestorationIdentifier:post.objectId];
    [content addSubview:captionLabel];
    
    
    // Buttons
    UIButton *commentButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 365, 30, 30)];
    [commentButton setBackgroundImage:[UIImage imageNamed:@"feed_comment.png"] forState:UIControlStateNormal];
    [commentButton setBackgroundImage:[UIImage imageNamed:@"feed_comment_s.png"] forState:UIControlStateHighlighted];
    [commentButton setBackgroundImage:[UIImage imageNamed:@"feed_comment_s.png"] forState:UIControlStateSelected];
    //[commentButton addTarget:controller action:@selector(postCheerAction:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:commentButton];

    UIButton *cheerButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 365, 30, 30)];
    [cheerButton setBackgroundImage:[UIImage imageNamed:@"feed_cheer.png"] forState:UIControlStateNormal];
    [cheerButton setBackgroundImage:[UIImage imageNamed:@"feed_cheer_s.png"] forState:UIControlStateHighlighted];
    [cheerButton setBackgroundImage:[UIImage imageNamed:@"feed_cheer_s.png"] forState:UIControlStateSelected];
    [cheerButton addTarget:controller action:@selector(postCheerAction:) forControlEvents:UIControlEventTouchUpInside];
    [cheerButton setRestorationIdentifier:post.objectId];
    [content addSubview:cheerButton];
    
    // Cheers count
    UILabel *cheersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 365, 180, 30)];
    [cheersCountLabel setBackgroundColor:[UIColor clearColor]];
    [cheersCountLabel setFont:[Font normalSize:14]];
    [cheersCountLabel setTextColor:[Colors normalGray]];
    if ([[post objectForKey:@"cheers_count"] intValue] > 0) {
        [cheersCountLabel setText:[NSString stringWithFormat:@"%d cheers", [[post objectForKey:@"cheers_count"] intValue]]];
        [cheerButton setSelected:YES];
    }
    [content addSubview:cheersCountLabel];


}

@end
