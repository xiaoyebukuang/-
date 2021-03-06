//
//  AdviceTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AdviceTableViewCell.h"

@interface AdviceTableViewCell()

@property (nonatomic, strong) UIImageView *mailLogo;

@property (nonatomic, strong) UIImageView *arrawLogo;

@property (nonatomic, strong) UILabel *workNumber;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) XYLineView *lineV;
@end

@implementation AdviceTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor color_FFFFFF];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self.contentView addSubview:self.mailLogo];
    [self.mailLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(CELL_LEFT_APACE);
    }];
    
    [self.contentView addSubview:self.arrawLogo];
    [self.arrawLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
    }];
    
    [self.contentView addSubview:self.workNumber];
    [self.workNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.mailLogo.mas_right).offset(20);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.workNumber);
        make.right.equalTo(self.arrawLogo.mas_left).offset(-10);
    }];
    
    [self.contentView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.workNumber);
        make.width.mas_offset(MAIN_SCREEN_WIDTH - 140);
    }];
    [self.contentView addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)reloadDataWithMailModel:(AdviceModel *)adviceModel {
    self.workNumber.text = adviceModel.phone;
    self.timeLabel.text = adviceModel.timeStr;
    self.messageLabel.text = adviceModel.advice_info;
}
#pragma mark -- serup
- (UIImageView *)mailLogo {
    if (!_mailLogo) {
        _mailLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"manager_advice"]];
    }
    return _mailLogo;
}
- (UIImageView *)arrawLogo {
    if (!_arrawLogo) {
        _arrawLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail_arraw"]];
    }
    return _arrawLogo;
}
- (UILabel *)workNumber {
    if (!_workNumber) {
        _workNumber = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _workNumber;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_333333]];
    }
    return _timeLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _messageLabel;
}
- (XYLineView *)lineV {
    if (!_lineV) {
        _lineV = [[XYLineView alloc]init];
    }
    return _lineV;
}
@end
