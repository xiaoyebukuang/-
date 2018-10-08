//
//  NoticeViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "NoticeDetailViewController.h"
static NSString * const NoticeTableViewCellID = @"NoticeTableViewCellID";

@interface NoticeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *noticeTableV;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.noticeTableV];
    [self.noticeTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NoticeTableViewCellID];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeDetailViewController *noticeDetailVC = [[NoticeDetailViewController alloc]init];
    [self.navigationController pushViewController:noticeDetailVC animated:YES];
}
#pragma mark -- setup

- (UITableView *)noticeTableV{
    if (!_noticeTableV) {
        _noticeTableV = [[UITableView alloc] init];
        _noticeTableV.delegate = self;
        _noticeTableV.dataSource = self;
        _noticeTableV.rowHeight = 70;
        _noticeTableV.showsVerticalScrollIndicator = NO;
        _noticeTableV.showsHorizontalScrollIndicator = NO;
        _noticeTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_noticeTableV registerClass:[NoticeTableViewCell class] forCellReuseIdentifier:NoticeTableViewCellID];
    }
    return _noticeTableV;
}@end
