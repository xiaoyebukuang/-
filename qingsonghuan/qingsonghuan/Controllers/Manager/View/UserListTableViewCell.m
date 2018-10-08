//
//  UserListTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserListTableViewCell.h"

@interface UserListTableViewCell()
@property (nonatomic, strong) UIView *bgView;
//手机号
@property (nonatomic, strong) UILabel *phone;
//分子公司
@property (nonatomic, strong) UILabel *subsidiaryName;
//签证
@property (nonatomic, strong) UILabel *visaName;
//性别
@property (nonatomic, strong) UILabel *sex;


//航空公司
@property (nonatomic, strong) UILabel *airlineName;
//职务等级
@property (nonatomic, strong) UILabel *dutyName;
//登机证号
@property (nonatomic, strong) UILabel *workNumber;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, copy) UserListCancelBlock cancelBlock;
@property (nonatomic, copy) UserListDeleteBlock deleteBlock;
@end

@implementation UserListTableViewCell

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
    //手机号
    UILabel *phoneLabel = [[UILabel alloc]initWithText:@"手机号:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.bgView).offset(CELL_LEFT_APACE);
        make.width.mas_equalTo(70);
    }];
    [self.bgView addSubview:self.phone];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right);
        make.centerY.equalTo(phoneLabel);
    }];
    //分子公司
    UILabel *subsidiaryNameLabel = [[UILabel alloc]initWithText:@"分子公司:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:subsidiaryNameLabel];
    [subsidiaryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(phoneLabel);
        make.top.equalTo(phoneLabel.mas_bottom).offset(cell_heght_space);
    }];
    [self.bgView addSubview:self.subsidiaryName];
    [self.subsidiaryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phone);
        make.centerY.equalTo(subsidiaryNameLabel);
    }];
    
    //签证类型
    UILabel *visaNameLabel = [[UILabel alloc]initWithText:@"签证类型:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:visaNameLabel];
    [visaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(phoneLabel);
        make.top.equalTo(subsidiaryNameLabel.mas_bottom).offset(cell_heght_space);
    }];
    [self.bgView addSubview:self.visaName];
    [self.visaName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phone);
        make.centerY.equalTo(visaNameLabel);
    }];
    
    //性别
    UILabel *sexLabel = [[UILabel alloc]initWithText:@"性别:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:sexLabel];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(phoneLabel);
        make.top.equalTo(visaNameLabel.mas_bottom).offset(cell_heght_space);
    }];
    
    [self.bgView addSubview:self.sex];
    [self.sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phone);
        make.centerY.equalTo(sexLabel);
    }];
    
    //航空公司
    UILabel *airlineNameLabel = [[UILabel alloc]initWithText:@"航空公司:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:airlineNameLabel];
    [airlineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_centerX);
        make.width.top.equalTo(phoneLabel);
        make.centerY.equalTo(phoneLabel);
    }];
    [self.bgView addSubview:self.airlineName];
    [self.airlineName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(airlineNameLabel.mas_right);
        make.centerY.equalTo(airlineNameLabel);
    }];
    
    //职务等级
    UILabel *dutyNameLabel = [[UILabel alloc]initWithText:@"职务等级:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:dutyNameLabel];
    [dutyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(airlineNameLabel);
        make.centerY.equalTo(subsidiaryNameLabel);
    }];
    [self.bgView addSubview:self.dutyName];
    [self.dutyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.airlineName);
        make.centerY.equalTo(dutyNameLabel);
    }];
    //登机证号
    UILabel *workNumberLabel = [[UILabel alloc]initWithText:@"登机证号:" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    [self.bgView addSubview:workNumberLabel];
    [workNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(airlineNameLabel);
        make.centerY.equalTo(visaNameLabel);
    }];
    [self.bgView addSubview:self.workNumber];
    [self.workNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.airlineName);
        make.centerY.equalTo(workNumberLabel);
    }];
    
    
    XYLineView *line01 = [[XYLineView alloc]init];
    [self.bgView addSubview:line01];
    [line01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.bgView);
        make.top.equalTo(sexLabel.mas_bottom).offset(CELL_LEFT_APACE);
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
    
    UIButton *delete = [UIButton buttonWithTitle:@"删除" font:SYSTEM_FONT_15 titleColor:[UIColor color_33B1FE]];
    [delete addTarget:self action:@selector(deleteBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:delete];
    [delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.bgView);
        make.top.equalTo(line02);
        make.right.equalTo(line02.mas_left);
    }];
    
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.bgView);
        make.top.equalTo(line02);
        make.left.equalTo(line02.mas_right);
    }];
}
- (void)deleteBtnEvent:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}
- (void)cancelBtnEvent:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (void)reloadUIWithMolde:(ManagerUserModel *)model userListCancelBlock:(UserListCancelBlock)cancelBlock userListDeleteBlock:(UserListDeleteBlock)deleteBlock {
    self.phone.text = model.phone;
    self.workNumber.text = model.work_number;
    self.sex.text = [model.sex isEqualToString:@"1"] ? @"男":@"女";
    self.airlineName.text = model.airline_name;
    self.subsidiaryName.text = model.subsidiary_name;
    self.dutyName.text = model.duty_name;
    self.visaName.text = model.visa_name;
    self.cancelBlock = cancelBlock;
    self.deleteBlock = deleteBlock;
    [self.cancelBtn setTitle:(model.status ? @"已注销":@"注销") forState:UIControlStateNormal];
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
//手机号
- (UILabel *)phone {
    if (!_phone) {
        _phone = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _phone;
}
//分子公司
- (UILabel *)subsidiaryName {
    if (!_subsidiaryName) {
        _subsidiaryName = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _subsidiaryName;
}
//字母标识
- (UILabel *)visaName {
    if (!_visaName) {
        _visaName = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _visaName;
}
//性别
- (UILabel *)sex {
    if (!_sex) {
        _sex = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _sex;
}

//航空公司
- (UILabel *)airlineName {
    if (!_airlineName) {
        _airlineName = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _airlineName;
}
//职务等级
- (UILabel *)dutyName {
    if (!_dutyName) {
        _dutyName = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _dutyName;
}
//登机证号
- (UILabel *)workNumber {
    if (!_workNumber) {
        _workNumber = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
    }
    return _workNumber;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithTitle:@"注销" font:SYSTEM_FONT_15 titleColor:[UIColor color_33B1FE]];
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
