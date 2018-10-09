//
//  MainReecordTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/1.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MainReecordTableViewCell.h"

@interface MainReecordTableViewCell()

@property (nonatomic, strong) UIView *bgView;
//签到日期
@property (nonatomic, strong) UILabel *date;
//航班号
@property (nonatomic, strong) UILabel *airlineNumber;
//字母标识
@property (nonatomic, strong) UILabel *wordLogo;
//航段信息
@property (nonatomic, strong) UILabel *legInfo;


//签到时间
@property (nonatomic, strong) UILabel *time;
//签证类型
@property (nonatomic, strong) UILabel *visa;
//职务等级
@property (nonatomic, strong) UILabel *duty;


@property (nonatomic, copy) MainReecordEditBlock editBlock;
@property (nonatomic, copy) MainReecordDeleteBlock deleteBlock;


@end
@implementation MainReecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    CGFloat cell_heght_space = 10.0;
    
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CELL_LEFT_APACE);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
    }];
    //签证日期
    UILabel *dateLabel = [[UILabel alloc]initWithText:@"签证日期:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.bgView).offset(CELL_LEFT_APACE);
        make.width.mas_equalTo(70);
    }];
    [self.bgView addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.centerY.equalTo(dateLabel);
    }];
    //航班号
    UILabel *airlineNumberLabel = [[UILabel alloc]initWithText:@"航班号:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:airlineNumberLabel];
    [airlineNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(dateLabel);
        make.top.equalTo(dateLabel.mas_bottom).offset(cell_heght_space);
    }];
    [self.bgView addSubview:self.airlineNumber];
    [self.airlineNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.date);
        make.centerY.equalTo(airlineNumberLabel);
    }];
    
    //字母标识
    UILabel *wordLogoLabel = [[UILabel alloc]initWithText:@"字母标识:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:wordLogoLabel];
    [wordLogoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(dateLabel);
        make.top.equalTo(airlineNumberLabel.mas_bottom).offset(cell_heght_space);
    }];
    [self.bgView addSubview:self.wordLogo];
    [self.wordLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.date);
        make.centerY.equalTo(wordLogoLabel);
    }];
    
    //航段信息
    UILabel *legInfoLabel = [[UILabel alloc]initWithText:@"航段信息:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:legInfoLabel];
    [legInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(dateLabel);
        make.top.equalTo(wordLogoLabel.mas_bottom).offset(cell_heght_space);
    }];
    
    [self.bgView addSubview:self.legInfo];
    [self.legInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.date);
        make.centerY.equalTo(legInfoLabel);
    }];
    
    //签证时间
    UILabel *timeLabel = [[UILabel alloc]initWithText:@"签证时间:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_centerX);
        make.width.top.equalTo(dateLabel);
        make.centerY.equalTo(dateLabel);
    }];
    [self.bgView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_right);
        make.centerY.equalTo(timeLabel);
    }];
    
    //签证类型
    UILabel *visaLabel = [[UILabel alloc]initWithText:@"签证类型:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:visaLabel];
    [visaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(timeLabel);
        make.centerY.equalTo(airlineNumberLabel);
    }];
    [self.bgView addSubview:self.visa];
    [self.visa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.time);
        make.centerY.equalTo(visaLabel);
    }];
    //职务等级
    UILabel *dutyLabel = [[UILabel alloc]initWithText:@"职务等级:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:dutyLabel];
    [dutyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(timeLabel);
        make.centerY.equalTo(wordLogoLabel);
    }];
    [self.bgView addSubview:self.duty];
    [self.duty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.time);
        make.centerY.equalTo(dutyLabel);
    }];
    
    
    XYLineView *line01 = [[XYLineView alloc]init];
    [self.bgView addSubview:line01];
    [line01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.bgView);
        make.top.equalTo(legInfoLabel.mas_bottom).offset(CELL_LEFT_APACE);
        make.height.mas_equalTo(0.5);
    }];
    
    XYLineView *line02 = [[XYLineView alloc]init];
    [self.bgView addSubview:line02];
    [line02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(line01.mas_bottom);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.bgView);
    }];
    
    UIButton *edit = [UIButton buttonWithTitle:@"编辑" font:SYSTEM_FONT_15 titleColor:[UIColor color_33B1FE]];
    [edit addTarget:self action:@selector(editBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:edit];
    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.bgView);
        make.top.equalTo(line02);
        make.right.equalTo(line02.mas_left);
    }];
    
    UIButton *cancle = [UIButton buttonWithTitle:@"删除" font:SYSTEM_FONT_15 titleColor:[UIColor color_33B1FE]];
    [cancle addTarget:self action:@selector(deleteBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:cancle];
    [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.bgView);
        make.top.equalTo(line02);
        make.left.equalTo(line02.mas_right);
    }];
}
- (void)editBtnEvent:(UIButton *)sender {
    if (self.editBlock) {
        self.editBlock();
    }
}
- (void)deleteBtnEvent:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}
- (void)reloadUIWithMolde:(FlightModel *)model mainReecordEditBlock:(MainReecordEditBlock)editBlock mainReecordDeleteBlock:(MainReecordDeleteBlock)deleteBlock {
    
    self.date.text = model.sign_date_str;
    self.airlineNumber.text = model.number_days;
    self.wordLogo.text = model.wordLogoModel.word_logo_name;
    self.legInfo.text = model.leg_info_str;
    
    self.time.text = model.sign_time;
    self.visa.text = model.visaModel.visa_name;
    self.duty.text = model.dutyModel.duty_name;
    
    self.editBlock = editBlock;
    self.deleteBlock = deleteBlock;
}
#pragma mark -- setup
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor color_FFFFFF];
        _bgView.layer.shadowColor = [UIColor color_99D3F8].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,5);
        _bgView.layer.shadowOpacity = 0.5;
        _bgView.layer.shadowRadius = 12;
        _bgView.layer.cornerRadius = 20;
    }
    return _bgView;
}
//签到日期
- (UILabel *)date {
    if (!_date) {
        _date = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _date;
}
//航班号
- (UILabel *)airlineNumber {
    if (!_airlineNumber) {
        _airlineNumber = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _airlineNumber;
}
//字母标识
- (UILabel *)wordLogo {
    if (!_wordLogo) {
        _wordLogo = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _wordLogo;
}
//航段信息
- (UILabel *)legInfo {
    if (!_legInfo) {
        _legInfo = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _legInfo;
}

//签到时间
- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _time;
}
//签到类型
- (UILabel *)visa {
    if (!_visa) {
        _visa = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _visa;
}
//职务等级
- (UILabel *)duty {
    if (!_duty) {
        _duty = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _duty;
}

@end
