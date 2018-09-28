//
//  FlightListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListViewController.h"
#import "FlightListTableViewCell.h"
//筛选
#import "FlightFilterViewController.h"
//航班详情
#import "FlightListDetailViewController.h"
//上传航班
#import "FlightSubmitViewController.h"
//头部view
#import "FlightHeaderView.h"

#import "MJRefreshControl.h"
#import "RegNeedInfoModel.h"
#import "FlightFilterModel.h"


static NSString * const FlightListTableViewCellID = @"FlightListTableViewCellID";
/**
 航班列表
 */
@interface FlightListViewController ()<UITableViewDelegate, UITableViewDataSource>
//头部view
@property (nonatomic, strong) FlightHeaderView *headerView;
//尾部view
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UITableView *flightTableView;
//筛选按钮
@property (nonatomic, strong) UIButton *filterBtn;
//筛选页面
@property (nonatomic, strong) FlightFilterViewController *filterVC;

//数据源
@property (nonatomic, strong) FlightFilterModel *filterModel;

@property (nonatomic, assign) BOOL isRequest;
@end

@implementation FlightListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"航班列表";
    [self setNavigationBar];
    [self setupView];
    [self setupData];
}
- (void)setNavigationBar {
    UIButton *leftBtn = [UIButton buttonWithImage:@"flight_menu"];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UIBarButtonItem *leftNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNagetiveSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[leftNagetiveSpacer, leftButtonItem];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.filterBtn];
    UIBarButtonItem *rightNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[rightButtonItem, rightNagetiveSpacer];
}
- (void)setupView {
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.height.mas_equalTo(168);
    }];
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.flightTableView];
    [self.flightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
}
#pragma mark -- request
- (void)setupData {
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.flightTableView headerBlock:^{
        [weakSelf getListFlight:YES];
    } footerBlock:^{
        [weakSelf getListFlight:NO];
    }];
    self.headerView.flightHeaderBlock = ^{
        //站内信
        NSLog(@"站内信");
    };
}
- (void)getListFlight:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param;
    [RequestPath flight_getListFlightParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.flightTableView];
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.flightTableView];
    }];
}
#pragma mark -- event
//个人中心菜单
- (void)leftNavigationBarEvent:(UIButton *)sender {
    NSLog(@"个人中心");
}
//筛选
- (void)rightBtnNavigationBarEvent:(UIButton *)sender {
    if (sender.selected) {
        [self.filterVC dismiss];
    } else {
        if (![RegNeedInfoModel checkRegData]) {
            [RequestPath user_regNeedInfoView:nil success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
                [self presentFilterVC];
            } failure:^(ErrorType errorType, NSString *mes) {
            }];
        } else {
            [self presentFilterVC];
        }
    }
    sender.selected = !sender.selected;
}
- (void)presentFilterVC {
    if (self.filterVC) {
        self.filterVC = nil;
    }
    __weak __typeof(self)weakSelf = self;
    self.filterVC = [[FlightFilterViewController alloc]initWithFilterModel:self.filterModel flilterSelectBlock:^(FlightFilterModel *filterModel) {
        weakSelf.filterModel = filterModel;
        [weakSelf rightBtnNavigationBarEvent:self.filterBtn];
    }];
    [self addChildViewController:self.filterVC];
    [self.view addSubview:self.filterVC.view];
    [self.filterVC show];
}
//我要上传
- (void)submitBtnEvent:(UIButton *)sender {
    FlightSubmitViewController *submitVC = [[FlightSubmitViewController alloc]init];
    [self.navigationController pushViewController:submitVC animated:YES];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: FlightListTableViewCellID];
    [cell reloadViewWithModel:@"" index:indexPath.row flightMailBlcok:^{
        NSLog(@"点击信封");
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightListDetailViewController *detailVC = [[FlightListDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- setup
- (FlightHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[FlightHeaderView alloc]init];
    }
    return _headerView;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor color_99D3F8];
        UIButton *submitBtn = [UIButton buttonWithTitle:@"我要上传" font:SYSTEM_BOLD_FONT(17) titleColor:[UIColor color_84BBDE] backgroundImage:@"flight_submit"];
        [submitBtn addTarget:self action:@selector(submitBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(-20);
        }];
        _footerView = view;
    }
    return _footerView;
}
- (UITableView *)flightTableView{
    if (!_flightTableView) {
        _flightTableView = [[UITableView alloc] init];
        _flightTableView.delegate = self;
        _flightTableView.dataSource = self;
        _flightTableView.rowHeight = 44;
        _flightTableView.showsVerticalScrollIndicator = NO;
        _flightTableView.showsHorizontalScrollIndicator = NO;
        _flightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_flightTableView registerClass:[FlightListTableViewCell class] forCellReuseIdentifier:FlightListTableViewCellID];
    }
    return _flightTableView;
}
//筛选按钮
- (UIButton *)filterBtn {
    if (!_filterBtn) {
        _filterBtn = [UIButton buttonWithImage:@"flight_search" title:@"筛选" selectTitel:@"取消" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_17];
        _filterBtn.frame = CGRectMake(0, 0, 60, 40);
        [_filterBtn addTarget:self action:@selector(rightBtnNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterBtn;
}

@end
