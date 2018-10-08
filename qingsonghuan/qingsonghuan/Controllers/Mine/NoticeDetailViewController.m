//
//  NoticeDetailViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController ()

@property (nonatomic, strong) UIImageView *noticeImageV;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.noticeImageV];
    [self.noticeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.view).offset(CELL_LEFT_APACE);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeImageV.mas_right).offset(10);
        make.top.equalTo(self.noticeImageV);
    }];
    
    [self.view addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.noticeImageV);
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.noticeImageV.mas_bottom).offset(40);
    }];
    
    self.titleLabel.text = self.noticeModel.title;
    self.dateLabel.text = self.noticeModel.timeStr;
    self.contentLabel.text = self.noticeModel.content;
}

#pragma mark -- setup
- (UIImageView *)noticeImageV {
    if (!_noticeImageV) {
        _noticeImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_notice_list"]];
    }
    return _noticeImageV;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _titleLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_999999]];
    }
    return _dateLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_333333]];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
