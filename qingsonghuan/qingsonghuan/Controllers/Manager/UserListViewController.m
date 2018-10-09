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
#import "UserListScreenModel.h"
#import "UserListScreenViewController.h"
static NSString * const UserListTableViewCellID = @"UserListTableViewCellID";

@interface UserListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *userListTableV;
//源数据
@property (nonatomic, strong) UserListModel *userListModel;
//是否正在请求
@property (nonatomic, assign) BOOL isRequest;

@property (nonatomic, strong) UIButton *screenBtn;


//筛选
@property (nonatomic, strong) UserListScreenModel *userListScreenModel;
//筛选页面
@property (nonatomic, strong) UserListScreenViewController *screenVC;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户列表";
    self.userListModel = [[UserListModel alloc]init];
    self.userListScreenModel = [[UserListScreenModel alloc]init];
    [self setupView];
    [self setNavigationBar];
    [self setupData];
}
- (void)setupView {
    [self.view addSubview:self.userListTableV];
    [self.userListTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
- (void)setNavigationBar {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.screenBtn];
    UIBarButtonItem *rightNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[rightButtonItem, rightNagetiveSpacer];
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
//列表数据
- (void)getUserInfo:(BOOL)refresh {
    
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.userListModel.page + 1),
                            @"limit":@(20),
                            @"user_id":[UserModel sharedInstance].userId,
                            @"user_phone":self.userListScreenModel.user_phone,
                            @"work_number":self.userListScreenModel.work_number
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
//删除 注销 取消注销
- (void)operationUser:(NSInteger)status indexPath:(NSIndexPath *)indexPath {
    ManagerUserModel *model = self.userListModel.listArr[indexPath.row];
    [RequestPath statistics_editUserStatusView:self.view param:@{@"user_id":model.user_id,@"status":@(status)} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        if (status == 0||status == 1) {
            //取消注销
            model.status = status;
            self.userListModel.listArr[indexPath.row] = model;
            [self.userListTableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [self.userListModel.listArr removeObjectAtIndex:indexPath.row];
            [self.userListTableV deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        [MBProgressHUD showSuccess:@"操作成功" ToView:self.view];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
#pragma mark -- event
//筛选
- (void)rightBtnNavigationBarEvent:(UIButton *)sender {
    if (sender.selected) {
        [self.screenVC dismiss];
        sender.selected = !sender.selected;
    } else {
        [self presentScreenVC];
        sender.selected = !sender.selected;
    }
}
- (void)presentScreenVC {
    if (self.screenVC) {
        self.screenVC = nil;
    }
    WeakSelf;
    self.screenVC = [[UserListScreenViewController alloc]initWithUserListScreenModel:self.userListScreenModel userListScreenBlock:^(UserListScreenModel *userListScreenModel) {
        weakSelf.userListScreenModel = userListScreenModel;
        [weakSelf rightBtnNavigationBarEvent:self.screenBtn];
        [MJRefreshControl beginRefresh:weakSelf.userListTableV];
    }];
    [self addChildViewController:self.screenVC];
    [self.view addSubview:self.screenVC.view];
    [self.screenVC show];
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
        [weakSelf operationUser:(model.status ?  0:1 ) indexPath:indexPath];
    } userListDeleteBlock:^{
        [weakSelf operationUser:2 indexPath:indexPath];
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
//筛选按钮
- (UIButton *)screenBtn {
    if (!_screenBtn) {
        _screenBtn = [UIButton buttonWithImage:@"flight_search" title:@"筛选" selectTitel:@"取消" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_17];
        _screenBtn.frame = CGRectMake(0, 0, 60, 40);
        [_screenBtn addTarget:self action:@selector(rightBtnNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenBtn;
}
@end
