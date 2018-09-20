//
//  LoginViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "LoginViewController.h"

/**
 登录
 */
@interface LoginViewController ()

@property (nonatomic, strong) XYTextField *telTField;

@property (nonatomic, strong) XYTextField *pwTField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    
    [self.view addSubview:self.telTField];
    [self.telTField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view).offset(100);
    }];
    
    [self.view addSubview:self.pwTField];
    [self.pwTField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telTField);
        make.right.mas_equalTo(self.telTField);
        make.height.mas_equalTo(self.telTField);;
        make.top.equalTo(self.telTField.mas_bottom).offset(100);
    }];
    
    
    UIView *_bgImgView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _bgImgView.backgroundColor = [UIColor redColor];
    _bgImgView.layer.cornerRadius = 10;
    _bgImgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bgImgView.layer.shadowOffset = CGSizeMake(5, 5);
    _bgImgView.layer.shadowOpacity = 0.5;
    _bgImgView.layer.shadowRadius = 5;
    [self.view addSubview:_bgImgView];
}


#pragma mark -- setup

- (XYTextField *)telTField {
    if (!_telTField) {
        _telTField = [[XYTextField alloc]initWithType:UITextFieldTel];
    }
    return _telTField;
}

- (XYTextField *)pwTField {
    if (!_pwTField) {
        _pwTField = [[XYTextField alloc]initWithType:UITextFieldPassword placeHolder:@"请输入密码"];
    }
    return _pwTField;
}


@end
