//
//  RegisterViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterViewController.h"
#import "XYPickerViewController.h"
static CGFloat const LOGIN_SPACE_SIZE = 0.0;

/**
 注册
 */
@interface RegisterViewController ()

/**
 手机号码
 */
@property (nonatomic, strong) XYTextFieldView *telView;

/**
 航空公司
 */
@property (nonatomic, strong) XYTextFieldView *companyView;

/**
 所属地区
 */
@property (nonatomic, strong) XYTextFieldView *areaView;

/**
 职务等级
 */
@property (nonatomic, strong) XYTextFieldView *postView;

/**
 签证类型
 */
@property (nonatomic, strong) XYTextFieldView *visaView;

/**
 登记证号
 */
@property (nonatomic, strong) XYTextFieldView *cardView;

/**
 性别
 */
@property (nonatomic, strong) XYTextFieldView *sexView;

/**
 密码
 */
@property (nonatomic, strong) XYTextFieldView *pwView;

/**
 确认密码
 */
@property (nonatomic, strong) XYTextFieldView *againPwView;

/**
 验证码
 */
@property (nonatomic, strong) XYTextFieldView *codeView;

/**
 注册
 */
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.telView];
    [self.telView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.companyView];
    [self.companyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.telView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.areaView];
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.companyView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.postView];
    [self.postView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.areaView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.visaView];
    [self.visaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.postView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.visaView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.sexView];
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.cardView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.pwView];
    [self.pwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.sexView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.againPwView];
    [self.againPwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.pwView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.againPwView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_offset(50);
        make.top.equalTo(self.codeView.mas_bottom).offset(10);
    }];
    
    __weak __typeof(self)weakSelf = self;
    self.companyView.selectBlock = ^{
        [weakSelf.view endEditing:YES];
        NSLog(@"请选择航空公司名称");
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:@[@"北京",@"上海",@"南京",@"杭州"] selectModel:@"杭州" pickerBlock:^(id model) {
            NSLog(@"%@",model);
            weakSelf.companyView.text = model;
        }];
        [weakSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    self.areaView.selectBlock = ^{
        [weakSelf.view endEditing:YES];
        NSLog(@"请选择所属地区");
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:@[@"北京",@"上海",@"南京",@"杭州"] selectModel:@"杭州" pickerBlock:^(id model) {
            NSLog(@"%@",model);
            weakSelf.areaView.text = model;
        }];
        [weakSelf presentViewController:pickerVC animated:YES completion:nil];
    };
}
#pragma mark -- event
- (void)registerBtnEvent:(UIButton *)sender {
    
}



#pragma mark -- setup
- (XYTextFieldView *)telView {
    if (!_telView) {
        _telView = [[XYTextFieldView alloc]initWithLeftType:UITextFieldTel logoImageV:@"login_tel" placeHolder:LOGIN_TEL_PLACEHOLDER];
    }
    return _telView;
}
- (XYTextFieldView *)companyView {
    if (!_companyView) {
        _companyView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_company" arrowImageV:@"login_select_arrow" placeHolder:LOGIN_COMPANY_PLACEHOLDER];
    }
    return _companyView;
}
- (XYTextFieldView *)areaView {
    if (!_areaView) {
        _areaView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_area" arrowImageV:@"login_select_arrow" placeHolder:LOGIN_AREA_PLACEHOLDER];
    }
    return _areaView;
}
- (XYTextFieldView *)postView {
    if (!_postView) {
        _postView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_post" arrowImageV:@"login_select_arrow" placeHolder:LOGIN_POST_PLACEHOLDER];
    }
    return _postView;
}
- (XYTextFieldView *)visaView {
    if (!_visaView) {
        _visaView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_visa" arrowImageV:@"login_select_arrow" placeHolder:LOGIN_VISA_PLACEHOLDER];
    }
    return _visaView;
}

- (XYTextFieldView *)cardView {
    if (!_cardView) {
        _cardView = [[XYTextFieldView alloc]initWithLeftType:UITextFieldTel logoImageV:@"login_card" placeHolder:LOGIN_CARD_PLACEHOLDER];
    }
    return _cardView;
}

- (XYTextFieldView *)sexView {
    if (!_sexView) {
        _sexView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_sex" arrowImageV:@"login_select_arrow" placeHolder:LOGIN_SEX_PLACEHOLDER];
    }
    return _sexView;
}

- (XYTextFieldView *)pwView {
    if (!_pwView) {
        _pwView = [[XYTextFieldView alloc]initWithLeftRightType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_eye_close" placeHolder:LOGIN_PSW_PLACEHOLDER];
    }
    return _pwView;
}

- (XYTextFieldView *)againPwView {
    if (!_againPwView) {
        _againPwView = [[XYTextFieldView alloc]initWithLeftRightType:UITextFieldPassword logoImageV:@"login_psw" arrowImageVNormal:@"login_eye_open" arrowImageVSelect:@"login_eye_close" placeHolder:LOGIN_AGAIN_PSW_PLACEHOLDER];
    }
    return _againPwView;
}
- (XYTextFieldView *)codeView {
    if (!_codeView) {
        _codeView = [[XYTextFieldView alloc]initWithCodeType:UITextFieldCode logoImageV:@"login_code" placeHolder:LOGIN_CODE_PLACEHOLDER];
    }
    return _codeView;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithTitle:@"注 册" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [_registerBtn addTarget:self action:@selector(registerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}



@end
