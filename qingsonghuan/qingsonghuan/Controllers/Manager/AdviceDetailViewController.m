//
//  AdviceDetailViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AdviceDetailViewController.h"

@interface AdviceDetailViewController ()

@property (nonatomic, strong) UILabel *phone;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *content;

@end

@implementation AdviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.phone];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.view).offset(CELL_LEFT_APACE);
    }];
    
    [self.view addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self.phone);
    }];
    
    [self.view addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.right.equalTo(self.view).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.phone.mas_bottom).offset(CELL_LEFT_APACE);
    }];
}
#pragma mark -- setup
- (UILabel *)phone {
    if (!_phone) {
        _phone = [[UILabel alloc]initWithText:self.adviceModel.phone font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _phone;
}
- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc]initWithText:self.adviceModel.timeStr font:SYSTEM_FONT_13 textColor:[UIColor color_999999]];
    }
    return _time;
}
- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc]initWithText:self.adviceModel.advice_info font:SYSTEM_FONT_15 textColor:[UIColor color_333333]];
        _content.numberOfLines = 0;
    }
    return _content;
}

@end
