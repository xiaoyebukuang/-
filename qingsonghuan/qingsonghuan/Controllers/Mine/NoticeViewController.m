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
#import "NoticeListModel.h"
#import "MJRefreshControl.h"
static NSString * const NoticeTableViewCellID = @"NoticeTableViewCellID";

@interface NoticeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *noticeTableV;
@property (nonatomic, strong) NoticeListModel *noticeListModel;
//是否请求中
@property (nonatomic, assign) BOOL isRequest;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noticeListModel = [[NoticeListModel alloc]init];
    self.title = @"公告";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.noticeTableV];
    [self.noticeTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.noticeTableV headerBlock:^{
        [weakSelf announcementGetListParamRequest:YES];
    } footerBlock:^{
        [weakSelf announcementGetListParamRequest:NO];
    }];
    [MJRefreshControl beginRefresh:self.noticeTableV];
}
- (void)announcementGetListParamRequest:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.noticeListModel.page + 1),
                            @"limit":@(20),
                            @"user_id":[UserModel sharedInstance].userId
                            };
    [RequestPath announcement_getListParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.noticeListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.noticeTableV];
        [self.noticeTableV reloadData];
        if (!self.noticeListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.noticeTableV];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.noticeTableV];
    }];
    
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NoticeTableViewCellID];
    [cell reloadDataWithNoticeModel:self.noticeListModel.listArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeDetailViewController *noticeDetailVC = [[NoticeDetailViewController alloc]init];
    noticeDetailVC.noticeModel = self.noticeListModel.listArr[indexPath.row];
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
