//
//  LoginViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "XYTextFieldView.h"
/**
 登录
 */
@interface LoginViewController ()


/**
 Logo
 */
@property (nonatomic, strong) UIImageView *logoImageV;


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
    self.title = @"注册";
    [self setupView];
}

- (void)setupView {
    
    [self.view addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.telTFieldView];
    [self.telTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.logoImageV.mas_bottom).offset(80);
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
        make.height.mas_equalTo(15);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.right.equalTo(self.sView.mas_left);
    }];

    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.height.equalTo(self.registerBtn);
        make.left.equalTo(self.sView.mas_right);
    }];
    
    [self.view addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark -- event
//登录
- (void)loginBtnEvent:(UIButton *)sender {
    NSString *des;
    if (![NSString validatePhoneNumber:self.telTFieldView.text]) {
        des = @"请填写完整的手机号";
    } else if ([NSString isEmpty: self.pwTFieldView.text]) {
        des = @"请输入密码";
    }
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    [RequestPath user_loginView:self.view param:@{@"phone":self.telTFieldView.text,@"password":self.pwTFieldView.text} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
       [[UserModel sharedInstance] reloadWithDic:obj];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
//注册
- (void)registerBtnEvent:(UIButton *)sender {
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//忘记密码
- (void)forgetBtnEvent:(UIButton *)sender {
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];    
}

#pragma mark -- setup
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]init];
        _logoImageV.image = [UIImage imageNamed:@"logo"];
    }
    return _logoImageV;
}

- (XYTextFieldView *)telTFieldView {
    if (!_telTFieldView) {
        _telTFieldView = [[XYTextFieldView alloc]initWithLeftType:UITextFieldTel logoImageV:@"login_tel" placeHolder:LOGIN_TEL_PLACEHOLDER];
    }
    return _telTFieldView;
}

- (XYTextFieldView *)pwTFieldView {
    if (!_pwTFieldView) {
        _pwTFieldView = [[XYTextFieldView alloc]initWithLeftRightType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_eye_close" placeHolder:LOGIN_PSW_PLACEHOLDER];
    }
    return _pwTFieldView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithTitle:@"登 录" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [_loginBtn addTarget:self action:@selector(loginBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- (UIView *)sView {
    if (!_sView) {
        _sView = [[UIView alloc]init];
        _sView.backgroundColor = [UIColor color_99D3F8];
    }
    return _sView;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithTitle:@"账号注册>" font:SYSTEM_FONT_13 titleColor:[UIColor color_99D3F8]];
        [_registerBtn addTarget:self action:@selector(registerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithTitle:@"忘记密码>" font:SYSTEM_FONT_13 titleColor:[UIColor color_99D3F8]];
        [_forgetBtn addTarget:self action:@selector(forgetBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithText:@"———— 轻松换app ————" font:SYSTEM_FONT_13 textColor:[UIColor color_C7C7C7]];
    }
    return _desLabel;
}

@end
