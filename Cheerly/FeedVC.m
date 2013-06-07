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
    _tableView.tableHeaderView = [self profileView:[PFUser currentUser]];
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

- (UIView*)profileView:(PFUser*)user {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [view setBackgroundColor:[Colors darkGray]];
    [view setClipsToBounds:YES];
    
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(110, 20, 100, 100)];
    [picture setClipsToBounds:YES];
    [picture setBackgroundColor:[Colors darkGray]];
    [picture setContentMode:UIViewContentModeScaleAspectFill];
    [picture setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", user.username]]];
    [picture.layer setBorderColor:[UIColor whiteColor].CGColor];
    [picture.layer setBorderWidth:5.0];
    [picture.layer setCornerRadius:50.0];
    [view addSubview:picture];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 20)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[Font boldSize:18]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setText:[user objectForKey:@"name"]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:nameLabel];
    return view;
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
    [query orderByDescending:@"createdAt"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _posts = objects;
        [_tableView reloadData];
    }];
}

#pragma TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _posts.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = _posts[indexPath.row];

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    

    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    [image setImageWithURL:[NSURL URLWithString:[(PFFile*)[post objectForKey:@"image"] url]]];
    [image setClipsToBounds:YES];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [image setBackgroundColor:[Colors normalGray]];
    [cell addSubview:image];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}



@end
