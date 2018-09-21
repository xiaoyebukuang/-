//
//  ForgetViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ForgetViewController.h"

/**
 忘记密码——找回密码
 */
@interface ForgetViewController ()
/**
 电话号码
 */
@property (nonatomic, strong) XYTextFieldView *telTFieldView;
/**
 密码
 */
@property (nonatomic, strong) XYTextFieldView *pwTFieldView;
/**
 确认密码
 */
@property (nonatomic, strong) XYTextFieldView *againPwTFieldView;
/**
 验证码
 */
@property (nonatomic, strong) XYTextFieldView *codeTFieldView;

/**
 重置密码
 */
@property (nonatomic, strong) UIButton *resetBtn;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.telTFieldView];
    [self.telTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view).offset(30);
    }];
    [self.view addSubview:self.pwTFieldView];
    [self.pwTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.telTFieldView);
        make.top.equalTo(self.telTFieldView.mas_bottom).offset(10);
    }];
    
    [self.view addSubview:self.againPwTFieldView];
    [self.againPwTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.telTFieldView);
        make.top.equalTo(self.pwTFieldView.mas_bottom).offset(10);
    }];
    
    [self.view addSubview:self.codeTFieldView];
    [self.codeTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.telTFieldView);
        make.top.equalTo(self.againPwTFieldView.mas_bottom).offset(10);
    }];
    
    [self.view addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_offset(50);
        make.top.equalTo(self.codeTFieldView.mas_bottom).offset(60);
    }];
}
#pragma mark -- event
- (void)resetBtnEvent:(UIButton *)sender {
    
}

#pragma mark -- setup
- (XYTextFieldView *)telTFieldView {
    if (!_telTFieldView) {
        _telTFieldView = [[XYTextFieldView alloc]initWithLeftType:UITextFieldTel logoImageV:@"login_tel" placeHolder:@"请输入电话号码"];
    }
    return _telTFieldView;
}

- (XYTextFieldView *)pwTFieldView {
    if (!_pwTFieldView) {
        _pwTFieldView = [[XYTextFieldView alloc]initWithLeftRightType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_psw" placeHolder:@"请输入密码"];
    }
    return _pwTFieldView;
}

- (XYTextFieldView *)againPwTFieldView {
    if (!_againPwTFieldView) {
        _againPwTFieldView = [[XYTextFieldView alloc]initWithLeftRightType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_psw" placeHolder:@"请再次输入密码"];
    }
    return _againPwTFieldView;
}
- (XYTextFieldView *)codeTFieldView {
    if (!_codeTFieldView) {
        _codeTFieldView = [[XYTextFieldView alloc]initWithCodeType:UITextFieldCode logoImageV:@"login_psw" placeHolder:@"请输入验证码"];
    }
    return _codeTFieldView;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithTitle:@"确认重置" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [_resetBtn addTarget:self action:@selector(resetBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

@end
