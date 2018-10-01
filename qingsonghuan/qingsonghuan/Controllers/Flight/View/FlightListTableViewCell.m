//
//  FlightListTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListTableViewCell.h"

@interface FlightListTableViewCell()

@property (nonatomic, strong) UILabel *date;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *airLine;

@property (nonatomic, strong) UILabel *duties;

@property (nonatomic, strong) UILabel *word;

@property (nonatomic, strong) UIButton *mailBtn;

@property (nonatomic, copy) FlightMailBlcok mialBlock;

@end

@implementation FlightListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    CGFloat width = MAIN_SCREEN_WIDTH/6;
    [self addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(width);
    }];
    [self addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.equalTo(self.date);
        make.left.equalTo(self.date.mas_right);
    }];
    [self addSubview:self.airLine];
    [self.airLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.equalTo(self.date);
        make.left.equalTo(self.time.mas_right);
    }];
    [self addSubview:self.duties];
    [self.duties mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.equalTo(self.date);
        make.left.equalTo(self.airLine.mas_right);
    }];
    [self addSubview:self.word];
    [self.word mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.equalTo(self.date);
        make.left.equalTo(self.duties.mas_right);
    }];
    [self addSubview:self.mailBtn];
    [self.mailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.equalTo(self.date);
        make.left.equalTo(self.word.mas_right);
    }];
}
- (void)reloadViewWithModel:(FlightModel *)model index:(NSInteger)index flightMailBlcok:(FlightMailBlcok)flightMailBlcok{
    self.mialBlock = flightMailBlcok;
    if (index%2 == 0) {
        self.backgroundColor = [UIColor color_FFFFFF];
    } else {
        self.backgroundColor = [UIColor color_F7F8F9];
    }
    self.date.text = model.sign_date_str;
    self.time.text = model.sign_time;
    self.airLine.text = model.number_days;
    self.duties.text = model.dutyModel.duty_name;
    self.word.text = model.wordLogoModel.word_logo_name;
}
- (void)mailBtnEvent:(UIButton *)sender {
    if (self.mialBlock) {
        self.mialBlock();
    }
}

#pragma mark -- setup
- (UILabel *)date {
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.textColor = [UIColor color_666666];
        _date.textAlignment = NSTextAlignmentCenter;
        _date.font =SYSTEM_FONT_13;
        _date.adjustsFontSizeToFitWidth = YES;
    }
    return _date;
}
- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = [UIColor color_666666];
        _time.textAlignment = NSTextAlignmentCenter;
        _time.font =SYSTEM_FONT_13;
        _time.adjustsFontSizeToFitWidth = YES;
    }
    return _time;
}

- (UILabel *)airLine {
    if (!_airLine) {
        _airLine = [[UILabel alloc]init];
        _airLine.textColor = [UIColor color_666666];
        _airLine.textAlignment = NSTextAlignmentCenter;
        _airLine.font =SYSTEM_FONT_13;
        _airLine.adjustsFontSizeToFitWidth = YES;
    }
    return _airLine;
}
- (UILabel *)duties {
    if (!_duties) {
        _duties = [[UILabel alloc]init];
        _duties.textColor = [UIColor color_666666];
        _duties.textAlignment = NSTextAlignmentCenter;
        _duties.font =SYSTEM_FONT_13;
        _duties.adjustsFontSizeToFitWidth = YES;
    }
    return _duties;
}
- (UILabel *)word {
    if (!_word) {
        _word = [[UILabel alloc]init];
        _word.textColor = [UIColor color_666666];
        _word.textAlignment = NSTextAlignmentCenter;
        _word.font =SYSTEM_FONT_13;
        _word.adjustsFontSizeToFitWidth = YES;
    }
    return _word;
}
- (UIButton *)mailBtn {
    if (!_mailBtn) {
        _mailBtn = [UIButton buttonWithImage:@"flight_cell_mail"];
        [_mailBtn addTarget:self action:@selector(mailBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mailBtn;
}

@end
