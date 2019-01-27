//
//  ManagerViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ManagerViewController.h"
#import "ManagerTableViewCell.h"
#import "RegNumberViewController.h"
#import "DeviceViewController.h"
#import "AdviceViewController.h"
#import "UserListViewController.h"
#import "PublishNoticeViewController.h"
static NSString * const ManagerTableViewCellID = @"ManagerTableViewCellID";

@interface ManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *managerTableView;

@property (nonatomic, strong) NSArray *listArr;
@end

@implementation ManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理员";
    self.listArr = @[@"注册人数统计",@"设备分布统计",@"上传航班统计",@"站内信统计",@"公告",@"意见反馈",@"用户统计"];
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.managerTableView];
    [self.managerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ManagerTableViewCellID];
    [cell reloadViewTitle:self.listArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //注册人数统计
    if (indexPath.row == 0) {
        RegNumberViewController *regNumVC = [[RegNumberViewController alloc]init];
        regNumVC.type = ManagerTypeUser;
        [self.navigationController pushViewController:regNumVC animated:YES];
    }
    //设备分布统计
    if (indexPath.row == 1) {
        DeviceViewController *deviceVC = [[DeviceViewController alloc]init];
        [self.navigationController pushViewController:deviceVC animated:YES];
    }
    //上传航班统计
    if (indexPath.row == 2) {
        RegNumberViewController *regNumVC = [[RegNumberViewController alloc]init];
        regNumVC.type = ManagerTypeFlight;
        [self.navigationController pushViewController:regNumVC animated:YES];
    }
    //站内信统计
    if (indexPath.row == 3) {
        RegNumberViewController *regNumVC = [[RegNumberViewController alloc]init];
        regNumVC.type = ManagerTypeLetter;
        [self.navigationController pushViewController:regNumVC animated:YES];
    }
    //发布公告
    if (indexPath.row == 4) {
        PublishNoticeViewController *publishVC = [[PublishNoticeViewController alloc]init];
        [self.navigationController pushViewController:publishVC animated:YES];
    }
    //意见反馈
    if (indexPath.row == 5) {
        AdviceViewController *adviceVC = [[AdviceViewController alloc]init];
        [self.navigationController pushViewController:adviceVC animated:YES];
    }
    //用户统计
    if (indexPath.row == 6) {
        UserListViewController *userListVC = [[UserListViewController alloc]init];
        [self.navigationController pushViewController:userListVC animated:YES];
    }
}
#pragma mark -- setup
- (UITableView *)managerTableView{
    if (!_managerTableView) {
        _managerTableView = [[UITableView alloc] init];
        _managerTableView.delegate = self;
        _managerTableView.dataSource = self;
        _managerTableView.rowHeight = 50;
        _managerTableView.showsVerticalScrollIndicator = NO;
        _managerTableView.showsHorizontalScrollIndicator = NO;
        _managerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_managerTableView registerClass:[ManagerTableViewCell class] forCellReuseIdentifier:ManagerTableViewCellID];
    }
    return _managerTableView;
}


@end
