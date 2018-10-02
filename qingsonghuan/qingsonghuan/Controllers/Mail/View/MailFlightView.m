//
//  MailFlightView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailFlightView.h"

@interface MailFlightView()
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) XYTitleView *titleView;

@property (nonatomic, strong) UIImageView *lineImageV;

@property (nonatomic, strong) XYTitleView *contentView;

@property (nonatomic, strong) UIButton *addFlightBtn;
@end

@implementation MailFlightView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CELL_LEFT_APACE);
        make.top.equalTo(self).offset(35);
    }];
    
    [self addSubview:self.addFlightBtn];
    self.addFlightBtn.hidden = YES;
    [self.addFlightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.width.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.lineImageV];
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.lineImageV.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self).offset(-25);
    }];
}
- (void)setIsEditFlight:(BOOL)isEditFlight {
    _isEditFlight  = isEditFlight;
    self.addFlightBtn.hidden = !isEditFlight;
}
- (void)setFlightModel:(FlightModel *)flightModel {
    if (flightModel) {
        _flightModel = flightModel;
        NSArray *contentArr = @[flightModel.sign_date_str,flightModel.sign_time,flightModel.number_days,flightModel.dutyModel.duty_name,flightModel.wordLogoModel.word_logo_name];
        [self.contentView reloadUIWithTitleArr:contentArr];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.mailFlightViewBlock) {
        self.mailFlightViewBlock();
    }
}
- (void)addFlightBtnEvent:(UIButton *)sender {
    if (self.mailAddFlightViewBlock) {
        self.mailAddFlightViewBlock();
    }
}
#pragma mark -- setup
- (void)setBgColor:(UIColor *)bgColor {
    self.backgroundColor = bgColor;
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_333333]];
    }
    return _titleLabel;
}
- (XYTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[XYTitleView alloc]init];
        [_titleView reloadUIWithTitleArr:@[@"签到日期",@"签到时间",@"航班号",@"职位等级",@"字母标识"]];
    }
    return _titleView;
}
- (UIImageView *)lineImageV {
    if (!_lineImageV) {
        _lineImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flight_line"]];
    }
    return _lineImageV;
}
- (XYTitleView *)contentView {
    if (!_contentView) {
        _contentView = [[XYTitleView alloc]init];        
    }
    return _contentView;
}
- (UIButton *)addFlightBtn {
    if (!_addFlightBtn) {
        _addFlightBtn = [UIButton buttonWithBGImage:@"mail_add_btn"];
        [_addFlightBtn addTarget:self action:@selector(addFlightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addFlightBtn;
}

@end
