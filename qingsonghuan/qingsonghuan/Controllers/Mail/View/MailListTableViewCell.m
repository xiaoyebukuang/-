//
//  MailListTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailListTableViewCell.h"

@interface MailListTableViewCell()

@property (nonatomic, strong) UIImageView *mailLogo;

@property (nonatomic, strong) UIImageView *arrawLogo;

@property (nonatomic, strong) UILabel *workNumber;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) XYLineView *lineV;


@end

@implementation MailListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor color_FFFFFF];
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self addSubview:self.mailLogo];
    [self.mailLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(CELL_LEFT_APACE);
    }];
    
    [self addSubview:self.arrawLogo];
    [self.arrawLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
    }];
    
    [self addSubview:self.workNumber];
    [self.workNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(0.5);
        make.left.equalTo(self.mailLogo.mas_right).offset(20);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.workNumber);
        make.right.equalTo(self.arrawLogo.mas_left).offset(-10);
    }];
    
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1.5);
        make.left.equalTo(self.workNumber);
        make.right.equalTo(self.timeLabel);
    }];
    [self addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)reloadDataWithMailModel:(MailModel *)mailModel {
    NSString *mailImageStr = mailModel.is_read ? @"mail_read" : @"mail_unread";
    self.mailLogo.image = [UIImage imageNamed:mailImageStr];
    self.workNumber.text = mailModel.work_number;
//    self.timeLabel.text = mailModel.date;
//    self.messageLabel.text = mailModel.content;
    
}
#pragma mark -- serup
- (UIImageView *)mailLogo {
    if (!_mailLogo) {
        _mailLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail_read"]];
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
        _workNumber = [[UILabel alloc]initWithText:@"09123" font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _workNumber;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithText:@"12-21" font:SYSTEM_FONT_13 textColor:[UIColor color_333333]];
    }
    return _timeLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithText:@"你知道欧昂方is能给你大四的蒂萨费乃是独食难肥inin打撒带你飞is奶" font:SYSTEM_FONT_13 textColor:[UIColor color_333333]];
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
