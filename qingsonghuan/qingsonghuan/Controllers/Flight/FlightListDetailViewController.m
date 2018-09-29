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

@property (nonatomic, strong) NSArray *contentArr;

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
- (void)setFlightModel:(FlightModel *)flightModel {
    _flightModel = flightModel;
    NSMutableString *city = [[NSMutableString alloc]init];
    for (int i = 0; i < flightModel.leg_info.count; i ++) {
        NSString *temp = flightModel.leg_info[i];
        if (i == 0) {
            [city appendString:[NSString stringWithFormat:@"%@",temp]];
        } else {
            [city appendString:[NSString stringWithFormat:@"+%@",temp]];
        }
    }
    
    NSString *day = @"";
    if (flightModel.daysModel.days_id != 1) {
        day = [NSString stringWithFormat:@"(%@)",flightModel.daysModel.days_name];
    }
    NSString *daysStr = [NSString stringWithFormat:@"%@%@",flightModel.airline_number,day];
    
    self.contentArr = @[flightModel.date,flightModel.sign_time,daysStr,city,flightModel.visaModel.visa_name,flightModel.wordLogoModel.word_logo_name,flightModel.dutyModel.duty_name,flightModel.message];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr = @[@"签到日期:",@"签到时间:",@"航班号:",@"航段信息:",@"签证信息:",@"字母标识:",@"职务等级:",@"留言信息:"];
    FlightListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: FlightListDetailTableViewCellID];
    [cell reloadViewWithIndex:indexPath.row title:titleArr[indexPath.row] content:self.contentArr[indexPath.row]];
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
