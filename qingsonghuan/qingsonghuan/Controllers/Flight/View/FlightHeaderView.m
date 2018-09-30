//
//  FlightHeaderView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightHeaderView.h"

@interface FlightHeaderView()

@property (nonatomic, strong) UIImageView *logo;

@property (nonatomic, strong) UIImageView *detail;

@property (nonatomic, strong) XYTitleView *titleView;

@property (nonatomic, strong) UIButton *mailBtn;
//红点提示
@property (nonatomic, strong) UIImageView *tips;

@property (nonatomic, strong) UILabel *mailTitle;

@property (nonatomic, strong) UIImageView *lineImageV;

@end

@implementation FlightHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView {
    [self addSubview:self.logo];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(30);
    }];
    [self addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.mas_bottom).offset(15);
        make.centerX.equalTo(self.logo);
    }];
    
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    
    
    [self addSubview:self.mailBtn];
    [self.mailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self.logo);
    }];
    
    [self.mailBtn addSubview:self.tips];
    self.tips.hidden = YES;
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mailBtn).multipliedBy(2.0);
        make.centerY.equalTo(self.mailBtn).multipliedBy(0.01);
    }];
    
    [self addSubview:self.mailTitle];
    [self.mailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mailBtn);
        make.centerY.equalTo(self.detail);
    }];
    
    [self addSubview:self.lineImageV];
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
    }];
}
- (void)hiddenTips:(BOOL)hidden {
    self.tips.hidden = hidden;
}
#pragma mark -- event
//站内信
- (void)mailBtnEvent:(UIButton *)sender {
    if (self.flightHeaderBlock) {
        self.flightHeaderBlock();
    }
}
#pragma mark -- setup
- (UIImageView *)logo {
    if (!_logo) {
        _logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_logo"]];
    }
    return _logo;
}
- (UIImageView *)detail {
    if (!_detail) {
        _detail = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_logo_des"]];
    }
    return _detail;
}
- (XYTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[XYTitleView alloc]init];
        [_titleView reloadUIWithTitleArr:@[@"签到日期",@"签到时间",@"航班号",@"职位等级",@"字母标识",@"站内信"]];
    }
    return _titleView;
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
- (UILabel *)mailTitle {
    if (!_mailTitle) {
        _mailTitle = [[UILabel alloc]initWithText:@"站内信" font:SYSTEM_FONT_15 textColor:[UIColor color_2ECB87]];
    }
    return _mailTitle;
}
- (UIImageView *)lineImageV {
    if (!_lineImageV) {
        _lineImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_line"]];
    }
    return _lineImageV;
}
@end
