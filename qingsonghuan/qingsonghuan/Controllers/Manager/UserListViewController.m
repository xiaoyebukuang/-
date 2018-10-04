//
//  UserListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserListViewController.h"
#import "UserListTableViewCell.h"
#import "MJRefreshControl.h"
#import "UserListModel.h"

static NSString * const UserListTableViewCellID = @"UserListTableViewCellID";

@interface UserListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *userListTableV;
//源数据
@property (nonatomic, strong) UserListModel *userListModel;
//是否正在请求
@property (nonatomic, assign) BOOL isRequest;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户列表";
    self.userListModel = [[UserListModel alloc]init];
    [self setupView];
    [self setupData];
}
- (void)setupView {
    [self.view addSubview:self.userListTableV];
    [self.userListTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
- (void)setupData {
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.userListTableV headerBlock:^{
        [weakSelf getUserInfo:YES];
    } footerBlock:^{
        [weakSelf getUserInfo:NO];
    }];
    [MJRefreshControl beginRefresh:self.userListTableV];
}
- (void)getUserInfo:(BOOL)refresh {
    
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.userListModel.page + 1),
                            @"limit":@(20),
                            @"user_id":[UserModel sharedInstance].userId
                            };
    [RequestPath statistics_getUserListParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.userListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.userListTableV];
        [self.userListTableV reloadData];
        if (!self.userListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.userListTableV];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.userListTableV];
    }];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: UserListTableViewCellID];
    WeakSelf;
    ManagerUserModel *model = self.userListModel.listArr[indexPath.row];
    [cell reloadUIWithMolde:model userListCancelBlock:^{
        NSLog(@"注销");
    } userListDeleteBlock:^{
        NSLog(@"删除");
    }];
    return cell;
}
#pragma mark -- setup
- (UITableView *)userListTableV{
    if (!_userListTableV) {
        _userListTableV = [[UITableView alloc] init];
        _userListTableV.delegate = self;
        _userListTableV.dataSource = self;
        _userListTableV.estimatedRowHeight = 100;
        _userListTableV.showsVerticalScrollIndicator = NO;
        _userListTableV.showsHorizontalScrollIndicator = NO;
        _userListTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_userListTableV registerClass:[UserListTableViewCell class] forCellReuseIdentifier:UserListTableViewCellID];
    }
    return _userListTableV;
}

@end
