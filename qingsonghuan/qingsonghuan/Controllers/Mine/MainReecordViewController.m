//
//  MainReecordViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/1.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MainReecordViewController.h"
#import "MainReecordTableViewCell.h"
#import "MJRefreshControl.h"
#import "FlightSubmitViewController.h"

static NSString * const MainReecordTableViewCellID = @"MainReecordTableViewCellID";
/**
 上传记录
 */
@interface MainReecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reecordTableView;

//源数据
@property (nonatomic, strong) FlightListModel *flightListModel;
//是否正在请求
@property (nonatomic, assign) BOOL isRequest;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation MainReecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传记录";
    self.flightListModel = [[FlightListModel alloc]init];
    [self setupView];
    [self setupData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flightEdit:) name:NOTIFICATION_FLIGHT_EDIT object:nil];
}
//修改成功通知
- (void)flightEdit:(NSNotification *)notification {
    FlightModel *editModel = (FlightModel *)notification.object;
    if (self.indexPath) {
        [self.flightListModel.listArr replaceObjectAtIndex:self.indexPath.row withObject:editModel];
        [self.reecordTableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupView {
    [self.view addSubview:self.reecordTableView];
    [self.reecordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
- (void)setupData {
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.reecordTableView headerBlock:^{
        [weakSelf getListFlight:YES];
    } footerBlock:^{
        [weakSelf getListFlight:NO];
    }];
    [MJRefreshControl beginRefresh:self.reecordTableView];
}
//请求数据
- (void)getListFlight:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.flightListModel.page + 1),
                            @"limit":@(20),
                            @"user_id":[UserModel sharedInstance].userId
                            };
    [RequestPath flight_getListFlightParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.flightListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.reecordTableView];
        [self.reecordTableView reloadData];
        if (!self.flightListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.reecordTableView];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.reecordTableView];
    }];
}
//删除航班
- (void)delFlight:(NSIndexPath *)indexPath {
    NSDictionary *param = @{@"flight_id":self.flightListModel.listArr[indexPath.row].flight_id};
    [RequestPath flight_delFlightView:self.view param:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"删除成功" ToView:self.view];
        [self.flightListModel.listArr removeObjectAtIndex:indexPath.row];
        [self.reecordTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
#pragma mark -- event
- (void)signOutBtnEvent:(UIButton *)sender {
    [[UserModel sharedInstance] signOut];
}
- (void)backBtnEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.flightListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainReecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: MainReecordTableViewCellID];
    WeakSelf;
    FlightModel *model = self.flightListModel.listArr[indexPath.row];
    [cell reloadUIWithMolde:model mainReecordEditBlock:^{
        weakSelf.indexPath = indexPath;
        FlightSubmitViewController *VC = [[FlightSubmitViewController alloc]init];
        [VC reloadData:model];
        VC.isEdit = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    } mainReecordDeleteBlock:^{
        [weakSelf delFlight:indexPath];
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightModel *model = self.flightListModel.listArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectFlightModel:)]) {
        [self.delegate selectFlightModel:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -- setup
- (UITableView *)reecordTableView{
    if (!_reecordTableView) {
        _reecordTableView = [[UITableView alloc] init];
        _reecordTableView.delegate = self;
        _reecordTableView.dataSource = self;
        _reecordTableView.estimatedRowHeight = 100;
        _reecordTableView.showsVerticalScrollIndicator = NO;
        _reecordTableView.showsHorizontalScrollIndicator = NO;
        _reecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_reecordTableView registerClass:[MainReecordTableViewCell class] forCellReuseIdentifier:MainReecordTableViewCellID];
    }
    return _reecordTableView;
}

@end
