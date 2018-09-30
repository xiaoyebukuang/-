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
    
    self.workNumberLabel.text = @"1245";
    self.dateLabel.text = @"2018-12-31 12:00";
    self.contentLabel.text = @"毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。";
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
