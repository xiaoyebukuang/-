//
//  ForgetViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ForgetViewController.h"
#import "SendCodeModel.h"
#import "XYTextFieldView.h"
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

//验证码Model
@property (nonatomic, strong) SendCodeModel *sendCodeModel;

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
        make.top.equalTo(self.telTFieldView.mas_bottom);
    }];
    
    [self.view addSubview:self.againPwTFieldView];
    [self.againPwTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.telTFieldView);
        make.top.equalTo(self.pwTFieldView.mas_bottom);
    }];
    
    [self.view addSubview:self.codeTFieldView];
    [self.codeTFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.telTFieldView);
        make.top.equalTo(self.againPwTFieldView.mas_bottom);
    }];
    
    [self.view addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_offset(50);
        make.top.equalTo(self.codeTFieldView.mas_bottom).offset(60);
    }];
    __weak __typeof(self)weakSelf = self;
    self.codeTFieldView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [RequestPath user_sendCodeView:strongSelf.view phone:strongSelf.telTFieldView.text success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
            [strongSelf.codeTFieldView startTimer];
            strongSelf.sendCodeModel = [[SendCodeModel alloc]initWithDic:(NSDictionary *)obj];
        } failure:^(ErrorType errorType, NSString *mes) {
            
        }];
    };
}
#pragma mark -- event
- (void)resetBtnEvent:(UIButton *)sender {
    NSString *des;
    if (![NSString validatePhoneNumber:self.telTFieldView.text]) {
        des = @"请填写完整的手机号";
    } else if ([NSString isEmpty: self.pwTFieldView.text]) {
        des = @"请输入密码";
    } else if ([NSString isEmpty: self.againPwTFieldView.text]) {
        des = @"请再次输入密码";
    } else if (![self.pwTFieldView.text isEqualToString:self.againPwTFieldView.text]) {
        des = @"密码和确认密码输入不一致";
    } else if ([NSString isEmpty: self.codeTFieldView.text]) {
        des = @"请输入验证码";
    }
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    [self.view endEditing:YES];
    NSDictionary *parma = @{@"phone":self.telTFieldView.text,
                            @"password":self.pwTFieldView.text,
                            @"password_confirm":self.againPwTFieldView.text,
                            @"code":self.codeTFieldView.text,
                            @"iden":[NSString safe_string:self.sendCodeModel.iden]
                            };
    [MBProgressHUD showToView:self.view];
    [RequestPath user_retrieveParam:parma success:^(id obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"重置密码成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:self.view];
    }];
}

#pragma mark -- setup
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

- (XYTextFieldView *)againPwTFieldView {
    if (!_againPwTFieldView) {
        _againPwTFieldView = [[XYTextFieldView alloc]initWithLeftRightType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_eye_close" placeHolder:LOGIN_AGAIN_PSW_PLACEHOLDER];
    }
    return _againPwTFieldView;
}
- (XYTextFieldView *)codeTFieldView {
    if (!_codeTFieldView) {
        _codeTFieldView = [[XYTextFieldView alloc]initWithCodeType:UITextFieldCode logoImageV:@"login_code" placeHolder:LOGIN_CODE_PLACEHOLDER];
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
