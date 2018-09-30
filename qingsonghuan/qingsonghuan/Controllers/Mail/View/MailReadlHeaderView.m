//
//  MailReadlHeaderView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailReadlHeaderView.h"

@interface MailReadlHeaderView()

@property (nonatomic, strong) UIImageView *numberLogo;

@property (nonatomic, strong) UILabel *workNumberLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) XYLineView *lineView;
@end

@implementation MailReadlHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.numberLogo];
    [self.numberLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CELL_LEFT_APACE);
        make.top.equalTo(self).offset(CELL_LEFT_APACE);
    }];
    
    [self addSubview:self.workNumberLabel];
    [self.workNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLogo.mas_right).offset(10);
        make.top.equalTo(self.numberLogo);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.workNumberLabel);
        make.bottom.equalTo(self.numberLogo);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.centerX.equalTo(self);
        make.top.equalTo(self.numberLogo.mas_bottom).offset(40);
        make.bottom.equalTo(self).offset(-40);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)setReadModel:(MailReadModel *)readModel {
    self.workNumberLabel.text = readModel.work_number;
    self.dateLabel.text = readModel.add_time_str;
    self.contentLabel.text = readModel.content;
}

#pragma mark -- setup
- (UIImageView *)numberLogo {
    if (!_numberLogo) {
        _numberLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail_number"]];
    }
    return _numberLogo;
}
- (UILabel *)workNumberLabel {
    if (!_workNumberLabel) {
        _workNumberLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _workNumberLabel;
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
- (XYLineView *)lineView {
    if (!_lineView) {
        _lineView = [[XYLineView alloc]init];
    }
    return _lineView;
}
@end
