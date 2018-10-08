//
//  NoticeTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NoticeTableViewCell.h"

@interface NoticeTableViewCell()


@property (nonatomic, strong) UIImageView *noticeLogo;

@property (nonatomic, strong) UIImageView *arrawLogo;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) XYLineView *lineV;

@end


@implementation NoticeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor color_FFFFFF];
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self.contentView addSubview:self.noticeLogo];
    [self.noticeLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(CELL_LEFT_APACE);
    }];
    
    [self.contentView addSubview:self.arrawLogo];
    [self.arrawLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.noticeLogo.mas_right).offset(20);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.arrawLogo.mas_left).offset(-10);
    }];
    
    [self.contentView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.titleLabel);
        make.width.mas_offset(MAIN_SCREEN_WIDTH - 140);
    }];
    [self.contentView addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)reloadDataWithNoticeModel:(NoticeModel *)noticeModel {
    self.titleLabel.text = noticeModel.title;
    self.messageLabel.text = noticeModel.content;
    self.timeLabel.text = noticeModel.timeStr;
}
#pragma mark -- serup
- (UIImageView *)noticeLogo {
    if (!_noticeLogo) {
        _noticeLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_notice_list"]];
    }
    return _noticeLogo;
}
- (UIImageView *)arrawLogo {
    if (!_arrawLogo) {
        _arrawLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail_arraw"]];
    }
    return _arrawLogo;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _titleLabel;
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
