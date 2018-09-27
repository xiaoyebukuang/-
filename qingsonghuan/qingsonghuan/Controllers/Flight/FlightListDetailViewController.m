//
//  FlightListDetailViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListDetailViewController.h"
#import "FlightListDetailTableViewCell.h"

static NSString * const FlightListDetailTableViewCellID = @"FlightListDetailTableViewCellID";
/**
 航班详情
 */
@interface FlightListDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *flightDetailTV;

@property (nonatomic, strong) UIView *footerView;

@end

@implementation FlightListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"航班详情";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    [self.view addSubview:self.flightDetailTV];
    [self.flightDetailTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: FlightListDetailTableViewCellID];
    [cell reloadViewWithIndex:indexPath.row];
    return cell;
}
#pragma mark -- setup
- (UITableView *)flightDetailTV{
    if (!_flightDetailTV) {
        _flightDetailTV = [[UITableView alloc] init];
        _flightDetailTV.delegate = self;
        _flightDetailTV.dataSource = self;
        _flightDetailTV.estimatedRowHeight = 44;
        _flightDetailTV.showsVerticalScrollIndicator = NO;
        _flightDetailTV.showsHorizontalScrollIndicator = NO;
        _flightDetailTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_flightDetailTV registerClass:[FlightListDetailTableViewCell class] forCellReuseIdentifier:FlightListDetailTableViewCellID];
    }
    return _flightDetailTV;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]init];
        UIButton *tel = [UIButton buttonWithBGImage:@"filter_detail_btn_bg" image:@"filter_detail_tel" title:@"拨号" font:SYSTEM_FONT_17 textColor:[UIColor color_FFFFFF]];
        [view addSubview:tel];
        [tel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(view);
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2 - 2);
        }];
        
        UIButton *mail = [UIButton buttonWithBGImage:@"filter_detail_btn_bg" image:@"filter_detail_mail" title:@"站内信" font:SYSTEM_FONT_17 textColor:[UIColor color_FFFFFF]];
        [view addSubview:mail];
        [mail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(view);
            make.width.equalTo(tel);
        }];
        _footerView = view;
    }
    return _footerView;
}

@end
