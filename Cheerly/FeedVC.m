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
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [DesignHelper profileOfUser:[PFUser currentUser]];
    [self.view addSubview:_tableView];
    
    UIButton *newPost = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 86) / 2, self.view.bounds.size.height - 86-49, 86, 86)];
    [newPost setBackgroundImage:[UIImage imageNamed:@"newpost.png"] forState:UIControlStateNormal];
    [newPost addTarget:self action:@selector(newPostAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newPost];
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:self.view.frame];
}
- (IBAction)newPostAction:(id)sender {
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[NewPostVC alloc] init]] animated:YES completion:nil];
}
- (void)reload {
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass([Post class])];
    [query whereKey:@"user" containedIn:@[[PFUser currentUser]]];
    [query includeKey:@"post"];
    [query orderByDescending:@"createdAt"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];

}

#pragma TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}



@end
