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
    self.title = @"Charlie";
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton *newPano = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 86) / 2, self.view.bounds.size.height - 86-44, 86, 86)];
    //[newPano setBackgroundImage:[UIImage imageNamed:@"newpano.png"] forState:UIControlStateNormal];
    //[newPano setBackgroundImage:[UIImage imageNamed:@"newpano_selected.png"] forState:UIControlStateHighlighted];
    [newPano setBackgroundColor:[Colors organge]];
    [newPano setBackgroundImage:[Colors toImage:[Colors organgeShadow]] forState:UIControlStateHighlighted];
    [newPano.layer setCornerRadius:43];
    [newPano setClipsToBounds:YES];
    [newPano addTarget:self action:@selector(newPostAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newPano];
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:self.view.frame];
}
- (IBAction)newPostAction:(id)sender {
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[NewPostVC alloc] init]] animated:YES completion:nil];
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
