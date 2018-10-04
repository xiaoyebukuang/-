//
//  AdviceViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AdviceViewController.h"
#import "AdviceTableViewCell.h"
#import "MJRefreshControl.h"
#import "AdviceListModel.h"
#import "AdviceDetailViewController.h"
static NSString * const AdviceTableViewCellID = @"AdviceTableViewCellID";
@interface AdviceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *adviceTableV;
//是否请求中
@property (nonatomic, assign) BOOL isRequest;

@property (nonatomic, strong) AdviceListModel *adviceListModel;
@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.adviceListModel = [[AdviceListModel alloc]init];
    [self setupUI];
    [self setupData];
}
- (void)setupUI {
    [self.view addSubview:self.adviceTableV];
    [self.adviceTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)setupData {
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.adviceTableV headerBlock:^{
        [weakSelf getAdviceListRequest:YES];
    } footerBlock:^{
        [weakSelf getAdviceListRequest:NO];
    }];
    [MJRefreshControl beginRefresh:self.adviceTableV];
}
- (void)getAdviceListRequest:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.adviceListModel.page + 1),
                            @"limit":@(20),
                            @"phone":[UserModel sharedInstance].phone
                            };
    [RequestPath statistics_getAdviceListParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.adviceListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.adviceTableV];
        [self.adviceTableV reloadData];
        if (!self.adviceListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.adviceTableV];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.adviceTableV];
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.adviceListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AdviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: AdviceTableViewCellID];
    [cell reloadDataWithMailModel:self.adviceListModel.listArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AdviceDetailViewController *detailVC = [[AdviceDetailViewController alloc]init];
    detailVC.adviceModel = self.adviceListModel.listArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark -- setup
- (UITableView *)adviceTableV{
    if (!_adviceTableV) {
        _adviceTableV = [[UITableView alloc] init];
        _adviceTableV.delegate = self;
        _adviceTableV.dataSource = self;
        _adviceTableV.rowHeight = 70;
        _adviceTableV.showsVerticalScrollIndicator = NO;
        _adviceTableV.showsHorizontalScrollIndicator = NO;
        _adviceTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_adviceTableV registerClass:[AdviceTableViewCell class] forCellReuseIdentifier:AdviceTableViewCellID];
    }
    return _adviceTableV;
}


@end
