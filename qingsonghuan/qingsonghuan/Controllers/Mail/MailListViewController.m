//
//  MailListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailListViewController.h"
#import "MailListTableViewCell.h"
#import "MailListModel.h"
#import "MJRefreshControl.h"

static NSString * const MailListTableViewCellID = @"MailListTableViewCellID";

@interface MailListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mailListTableV;

@property (nonatomic, assign) BOOL isRequest;

@property (nonatomic, strong) MailListModel *mailListModel;
@end

@implementation MailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"站内信";
    self.mailListModel = [[MailListModel alloc]init];
    [self setupUI];
    [self setupData];
}
- (void)setupUI {
    [self.view addSubview:self.mailListTableV];
    [self.mailListTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)setupData {
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.mailListTableV headerBlock:^{
        [weakSelf getListFlight:YES];
    } footerBlock:^{
        [weakSelf getListFlight:NO];
    }];
    [MJRefreshControl beginRefresh:self.mailListTableV];
}
#pragma mark -- request
- (void)getListFlight:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.mailListModel.page + 1),
                            @"limit":@(20)
                            };
    [RequestPath letter_mesListParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.mailListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.mailListTableV];
        [self.mailListTableV reloadData];
        if (!self.mailListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.mailListTableV];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.mailListTableV];
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mailListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: MailListTableViewCellID];
    [cell reloadDataWithMailModel:self.mailListModel.listArr[indexPath.row]];
    return cell;
}
#pragma mark -- setup

- (UITableView *)mailListTableV{
    if (!_mailListTableV) {
        _mailListTableV = [[UITableView alloc] init];
        _mailListTableV.delegate = self;
        _mailListTableV.dataSource = self;
        _mailListTableV.rowHeight = 70;
        _mailListTableV.showsVerticalScrollIndicator = NO;
        _mailListTableV.showsHorizontalScrollIndicator = NO;
        _mailListTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mailListTableV registerClass:[MailListTableViewCell class] forCellReuseIdentifier:MailListTableViewCellID];
    }
    return _mailListTableV;
}

@end
