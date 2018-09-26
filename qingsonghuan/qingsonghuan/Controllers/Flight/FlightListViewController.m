//
//  FlightListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListViewController.h"
#import "FlightListTableViewCell.h"

static NSString * const FlightListTableViewCellID = @"FlightListTableViewCellID";

@interface FlightListViewController ()<UITableViewDelegate, UITableViewDataSource>
//头部view
@property (nonatomic, strong) UIView *headerView;
//红点提示
@property (nonatomic, strong) UIImageView *tips;
//站内信
@property (nonatomic, strong) UIButton *mailBtn;

@property (nonatomic, strong) UITableView *flightTableView;
//尾部view
@property (nonatomic, strong) UIView *footerView;
//上传
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation FlightListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"航班列表";
    [self setNavigationBar];
    [self setupView];
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
- (void)setNavigationBar {
    UIButton *leftBtn = [UIButton buttonWithImage:@"flight_menu"];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UIBarButtonItem *leftNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNagetiveSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[leftNagetiveSpacer, leftButtonItem];
    
    UIButton *rightBtn = [UIButton buttonWithImage:@"flight_search" title:@"筛选" selectTitel:@"取消"];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:self action:@selector(rightBtnNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *rightNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[rightButtonItem, rightNagetiveSpacer];
}

#pragma mark -- event
//个人中心菜单
- (void)leftNavigationBarEvent:(UIButton *)sender {
    NSLog(@"个人中心");
}
//筛选
- (void)rightBtnNavigationBarEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"筛选");
}
//站内信
- (void)mailBtnEvent:(UIButton *)sender {
    NSLog(@"站内信");
}
//我要上传
- (void)submitBtnEvent:(UIButton *)sender {
    NSLog(@"我要上传");
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
#pragma mark -- setup
- (UIView *)headerView {
    if (!_headerView) {
        UIView *head = [[UIView alloc]init];
        head.backgroundColor = [UIColor color_FFFFFF];
        UIImageView *logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_logo"]];
        [head addSubview:logo];
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(head).offset(30);
            make.left.equalTo(head).offset(30);
        }];
        
        UIImageView *detail = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_logo_des"]];
        [head addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logo.mas_bottom).offset(15);
            make.centerX.equalTo(logo);
        }];
        
        UIView *titleView = [[UIView alloc]init];
        [head addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.width.equalTo(head);
            make.height.mas_equalTo(35);
        }];
        
        [head addSubview:self.mailBtn];
        [self.mailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(head).offset(-30);
            make.centerY.equalTo(logo);
        }];
        
        [self.mailBtn addSubview:self.tips];
        [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mailBtn).multipliedBy(2.0);
            make.centerY.equalTo(self.mailBtn).multipliedBy(0.01);
        }];
        
        UILabel *mailTitle = [[UILabel alloc]initWithText:@"站内信" font:SYSTEM_FONT_15 textColor:[UIColor color_2ECB87]];
        [head addSubview:mailTitle];
        [mailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mailBtn);
            make.centerY.equalTo(detail);
        }];
        NSArray *titles = @[@"签到日期",@"签到时间",@"航班号",@"职位等级",@"字母标识",@"站内信"];
        CGFloat width = MAIN_SCREEN_WIDTH/titles.count;
        for (int i = 0; i < titles.count; i ++) {
            UILabel *title = [[UILabel alloc]initWithText:titles[i] font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
            title.textAlignment = NSTextAlignmentCenter;
            [title sizeToFit];
            [titleView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(titleView);
                make.left.equalTo(titleView).offset(i*width);
                make.width.mas_equalTo(width);
            }];
        }
        
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_line"]];
        [head addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(head);
        }];
        _headerView = head;
    }
    return _headerView;
}
- (UIButton *)mailBtn {
    if (!_mailBtn) {
        _mailBtn = [UIButton buttonWithImage:@"flight_mail"];
        [_mailBtn addTarget:self action:@selector(mailBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mailBtn;
}
- (UIImageView *)tips {
    if (!_tips) {
        _tips = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_tips"]];
    }
    return _tips;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor color_99D3F8];
        [view addSubview:self.submitBtn];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(-20);
        }];
        _footerView = view;
    }
    return _footerView;
}
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithTitle:@"+我要上传" font:SYSTEM_FONT_15 titleColor:[UIColor color_FFFFFF] backgroundImage:@"flight_submit"];
        [_submitBtn addTarget:self action:@selector(submitBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
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

@end
