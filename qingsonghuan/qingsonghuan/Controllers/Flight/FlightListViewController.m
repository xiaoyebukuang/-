//
//  FlightListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListViewController.h"
#import "MailListViewController.h"
#import "FlightListTableViewCell.h"
//个人中心
#import "MineViewController.h"
//筛选
#import "FlightFilterViewController.h"
//航班详情
#import "FlightListDetailViewController.h"
//上传航班
#import "FlightSubmitViewController.h"
//头部view
#import "FlightHeaderView.h"

#import "MJRefreshControl.h"
#import "FlightFilterModel.h"
#import "FlightListModel.h"


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

//筛选数据
@property (nonatomic, strong) FlightFilterModel *flightFilterModel;
//源数据
@property (nonatomic, strong) FlightListModel *flightListModel;
//是否正在请求
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation FlightListViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [RequestPath letter_isMessuccess:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [self.headerView hiddenTips: ([NSString safe_float:obj[@"mes_num"]] == 0)];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"航班列表";
    self.flightListModel = [[FlightListModel alloc]init];
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
        make.height.mas_equalTo(50 + NAV_BOTTOW_HEIGHT);
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
    [MJRefreshControl beginRefresh:self.flightTableView];
    self.headerView.flightHeaderBlock = ^{
        MailListViewController *mailListVC = [[MailListViewController alloc]init];
        [weakSelf.navigationController pushViewController:mailListVC animated:YES];
    };
}
- (void)getListFlight:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.flightListModel.page + 1),
                            @"limit":@(20),
                            @"sign_date":[NSString safe_string:self.flightFilterModel.sign_date],
                            @"sign_time":@(self.flightFilterModel.signModel.sign_id),
                            @"visa_id":@(self.flightFilterModel.visaModel.visa_id),
                            @"word_logo_id":@(self.flightFilterModel.wordLogoModel.word_logo_id),
                            @"duty_id":@(self.flightFilterModel.dutyModel.duty_id),
                            @"airline_number":[NSString safe_string:self.flightFilterModel.airline_number]
                            };
    [RequestPath flight_getListFlightParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.flightListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.flightTableView];
        [self.flightTableView reloadData];
        if (!self.flightListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.flightTableView];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.flightTableView];
    }];
}
#pragma mark -- event
//个人中心菜单
- (void)leftNavigationBarEvent:(UIButton *)sender {
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];
}

//筛选
- (void)rightBtnNavigationBarEvent:(UIButton *)sender {
    if (sender.selected) {
        [self.filterVC dismiss];
        sender.selected = !sender.selected;
    } else {
        if (![RegNeedInfoModel checkRegData]) {
            [RequestPath user_regNeedInfoView:nil success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
                [self presentFilterVC];
                sender.selected = !sender.selected;
            } failure:^(ErrorType errorType, NSString *mes) {
                [MBProgressHUD showError:mes ToView:self.view];
            }];
        } else {
            [self presentFilterVC];
            sender.selected = !sender.selected;
        }
    }
}
- (void)presentFilterVC {
    if (self.filterVC) {
        self.filterVC = nil;
    }
    WeakSelf;
    self.filterVC = [[FlightFilterViewController alloc]initWithFilterModel:self.flightFilterModel flilterSelectBlock:^(FlightFilterModel *filterModel) {
        weakSelf.flightFilterModel = filterModel;
        [weakSelf rightBtnNavigationBarEvent:self.filterBtn];
        [MJRefreshControl beginRefresh:weakSelf.flightTableView];
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
    return self.flightListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: FlightListTableViewCellID];
    FlightModel *model = self.flightListModel.listArr[indexPath.row];
    [cell reloadViewWithModel:model index:indexPath.row flightMailBlcok:^{
        NSLog(@"点击信封");
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightListDetailViewController *detailVC = [[FlightListDetailViewController alloc]init];
    detailVC.flightModel = self.flightListModel.listArr[indexPath.row];
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
            make.top.equalTo(view).offset(10);
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
