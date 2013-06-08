//
//  FeedVC.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "FeedVC.h"
#import "Constants.h"

@implementation FeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Colors lightBackground];
    self.navigationItem.titleView = [DesignHelper navLogo];
    
    _posts = [[NSArray alloc] init];
    
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

    UIButton *newPost = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 86) / 2, self.view.bounds.size.height - 86-49, 86, 86)];
    [newPost setBackgroundImage:[UIImage imageNamed:@"newpost.png"] forState:UIControlStateNormal];
    [newPost addTarget:self action:@selector(newPostAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newPost];
    
    [self reload];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:self.view.frame];
}
- (IBAction)newPostAction:(id)sender {
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[NewPostVC alloc] init]] animated:YES completion:nil];
}
- (void)reload {
    MBProgressHUD *progressHUD = (_posts.count == 0) ? [MBProgressHUD showHUDAddedTo:self.view animated:YES] : [[MBProgressHUD alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass([Post class])];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _posts = objects;
        [_tableView reloadData];
        [_refreshControl endRefreshing];
        [progressHUD hide:YES];
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
