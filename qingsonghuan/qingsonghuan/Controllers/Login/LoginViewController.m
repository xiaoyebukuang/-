//
//  LoginViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
/**
 登录
 */
@interface LoginViewController ()

/**
 电话号码
 */
@property (nonatomic, strong) XYTextFieldView *telTFieldView;

/**
 密码
 */
@property (nonatomic, strong) XYTextFieldView *pwTFieldView;

/**
 登录
 */
@property (nonatomic, strong) UIButton *loginBtn;

/**
 账号注册
 */
@property (nonatomic, strong) UIButton *registerBtn;

/**
 忘记密码
 */
@property (nonatomic, strong) UIButton *forgetBtn;


/**
 切割线
 */
@property (nonatomic, strong) UIView *sView;

/**
 app描述
 */
@property (nonatomic, strong) UILabel *desLabel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self.view addSubview:self.telTFieldView];
    [self.telTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view).offset(320);
    }];
    [self.view addSubview:self.pwTFieldView];
    [self.pwTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.telTFieldView);
        make.top.equalTo(self.telTFieldView.mas_bottom).offset(10);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_offset(50);
        make.top.equalTo(self.pwTFieldView.mas_bottom).offset(60);
    }];
    
    [self.view addSubview:self.sView];
    [self.sView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.sView);
        make.width.mas_equalTo(80);
        make.right.equalTo(self.sView.mas_left);
    }];

    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.height.equalTo(self.registerBtn);
        make.left.equalTo(self.sView.mas_right);
    }];
}
#pragma mark -- event
//登录
- (void)loginBtnEvent:(UIButton *)sender {
    
}
//注册
- (void)registerBtnEvent:(UIButton *)sender {
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//忘记密码
- (void)forgetBtnEvent:(UIButton *)sender {
    
}

#pragma mark -- setup

- (XYTextFieldView *)telTFieldView {
    if (!_telTFieldView) {
        _telTFieldView = [[XYTextFieldView alloc]initWithType:UITextFieldTel logoImageV:@"login_tel" placeHolder:@"请输入电话号码"];
    }
    return _telTFieldView;
}

- (XYTextFieldView *)pwTFieldView {
    if (!_pwTFieldView) {
        _pwTFieldView = [[XYTextFieldView alloc]initWithType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_psw" placeHolder:@"请输入密码"];
    }
    return _pwTFieldView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = SYSTEM_FONT_15;
        [_loginBtn setTitleColor:[UIColor color_FFFFFF] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.backgroundColor = [UIColor redColor];
    }
    return _loginBtn;
}
- (UIView *)sView {
    if (!_sView) {
        _sView = [[UIView alloc]init];
        _sView.backgroundColor = [UIColor color_ABABAB];
    }
    return _sView;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"账号注册>" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = SYSTEM_FONT_15;
        [_registerBtn addTarget:self action:@selector(registerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtn setTitleColor:[UIColor color_ABABAB] forState:UIControlStateNormal];
    }
    return _registerBtn;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码>" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = SYSTEM_FONT_15;
        [_forgetBtn addTarget:self action:@selector(forgetBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_forgetBtn setTitleColor:[UIColor color_ABABAB] forState:UIControlStateNormal];
    }
    return _forgetBtn;
}


@end
