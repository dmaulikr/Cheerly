//
//  UserVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "UserVC.h"
#import "Constants.h"

@implementation UserVC

- (void)openUsername:(NSString *)username {
    self.username = username;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Colors lightBackground];
    self.title = self.username;
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.view addSubview:_tableView];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [_refreshControl setTintColor:[Colors normalGray]];
    [_tableView addSubview:_refreshControl];
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    PFQuery *query = [PFQuery queryForUser];
    [query whereKey:@"username" equalTo:self.username];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        _user = (PFUser*)object;
        [self setUpHeader];
        [self reload];
        [progressHUD hide:YES];
    }];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:self.view.frame];
}
- (void)setUpHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [view setBackgroundColor:[Colors darkGray]];
    [view setClipsToBounds:YES];
    
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(110, 20, 100, 100)];
    [picture setClipsToBounds:YES];
    [picture setBackgroundColor:[Colors darkGray]];
    [picture setContentMode:UIViewContentModeScaleAspectFill];
    [picture setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", self.user.username]]];
    [picture.layer setBorderColor:[UIColor whiteColor].CGColor];
    [picture.layer setBorderWidth:5.0];
    [picture.layer setCornerRadius:50.0];
    [view addSubview:picture];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 20)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[Font boldSize:18]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setText:[self.user objectForKey:@"name"]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:nameLabel];
    
    _tableView.tableHeaderView = view;
    
}

- (void)reload {
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass([Post class])];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:self.user];
    [query includeKey:@"user"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _posts = objects;
        [_tableView reloadData];
        [_refreshControl endRefreshing];
    }];
}

#pragma TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _posts.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [[PostCell alloc] init];
    [cell initWithPost:_posts[indexPath.row] onController:self];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 410;
}
- (IBAction)postCheerAction:(id)sender {
    NSString *post_id = @"";
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        post_id = [sender view].restorationIdentifier;
    }
    else {
        post_id = [sender restorationIdentifier];
        [sender setSelected:!([sender isSelected])];
        
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor clearColor];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feed_cheer_hud.png"]];
    [hud hide:YES afterDelay:2.0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"objectId" equalTo:post_id];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [object incrementKey:@"cheers_count"];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {[self reload];}];
    }];
}
- (IBAction)achieveAction:(id)sender {
    NSString *post_id = [sender view].restorationIdentifier;
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [progressHUD setMode:MBProgressHUDModeCustomView];
    [progressHUD setLabelText:@"Congrats!"];
    [progressHUD setCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"featured_swipe_rsvp.png"]]];
    [progressHUD hide:YES afterDelay:2.0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"objectId" equalTo:post_id];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {[self reload];}];
    }];
    
}



@end
