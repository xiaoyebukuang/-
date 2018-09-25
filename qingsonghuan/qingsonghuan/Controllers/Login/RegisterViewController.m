//
//  RegisterViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterViewController.h"
#import "XYPickerViewController.h"

#import "RegNeedInfoModel.h"
#import "SendCodeModel.h"
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


//数据源
//航空公司
@property (nonatomic, strong) AirlineModel *airlineModel;
//分子公司
@property (nonatomic, strong) SubsidiaryModel *subsidiaryModel;
//职位等级
@property (nonatomic, strong) DutiesModel *dutiesModel;
//签证类型
@property (nonatomic, strong) VisaModel *visaModel;
//性别
@property (nonatomic, strong) SexModel *sexModel;
//验证码Model
@property (nonatomic, strong) SendCodeModel *sendCodeModel;


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
    if (![RegNeedInfoModel checkRegData]) {
        [self requestData];
    } else {
        [self reloadView];
    }
}
- (void)requestData {
    [MBProgressHUD showToView:self.view];
    [RequestPath user_regNeedInfoSuccess:^(id obj, NSInteger code, NSString *mes) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [[RegNeedInfoModel sharedInstance]reloadWithDic:obj];
        }
        [self reloadView];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:self.view];
    }];
}
- (void)reloadView {
    RegNeedInfoModel *regModle = [RegNeedInfoModel sharedInstance];
    __weak __typeof(self)weakSelf = self;
    self.companyView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view endEditing:YES];
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:regModle.airlineModelArr pickerBlock:^(id model) {
            strongSelf.airlineModel = (AirlineModel *)model;
            strongSelf.subsidiaryModel = nil;
            strongSelf.areaView.text = nil;
            strongSelf.companyView.text = strongSelf.airlineModel.company_name;
        }];
        [strongSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    self.areaView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view endEditing:YES];
        if (strongSelf.airlineModel == nil) {
            [MBProgressHUD showError:@"请选择航空公司"];
            return;
        }
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:strongSelf.airlineModel.subsidiaryArr pickerBlock:^(id model) {
            strongSelf.subsidiaryModel = (SubsidiaryModel *)model;
            strongSelf.areaView.text = strongSelf.subsidiaryModel.city;
        }];
        [strongSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    
    self.postView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view endEditing:YES];
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:regModle.dutiesModelArr pickerBlock:^(id model) {
            strongSelf.dutiesModel = (DutiesModel *)model;
            strongSelf.postView.text = strongSelf.dutiesModel.job_title;
        }];
        [strongSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    
    self.visaView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view endEditing:YES];
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:regModle.visaModelArr pickerBlock:^(id model) {
            strongSelf.visaModel = (VisaModel *)model;
            strongSelf.visaView.text = strongSelf.visaModel.visa_name;
        }];
        [strongSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    
    self.sexView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view endEditing:YES];
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [pickerVC reloadViewWithArr:regModle.sexModelArr pickerBlock:^(id model) {
            strongSelf.sexModel = (SexModel *)model;
            strongSelf.sexView.text = strongSelf.sexModel.sex_name;
        }];
        [strongSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    
    self.codeView.selectBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view endEditing:YES];
        if ([NSString validatePhoneNumber:strongSelf.telView.text]) {
            [MBProgressHUD showToView:strongSelf.view];
            [RequestPath user_sendCodeParam:@{@"phone":strongSelf.telView.text} success:^(id obj, NSInteger code, NSString *mes) {
                [MBProgressHUD hideHUDForView:strongSelf.view];
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [strongSelf.codeView startTimer];
                    strongSelf.sendCodeModel = [[SendCodeModel alloc]initWithDic:(NSDictionary *)obj];
                }
            } failure:^(ErrorType errorType, NSString *mes) {
                [MBProgressHUD showError:mes ToView:strongSelf.view];
            }];
        } else {
            [MBProgressHUD showError:@"请填写完整的手机号" ToView:strongSelf.view];
        }
    };
}

#pragma mark -- event
//注册
- (void)registerBtnEvent:(UIButton *)sender {
    NSString *des;
    if (![NSString validatePhoneNumber:self.telView.text]) {
        des = @"请填写完整的手机号";
    } else if (self.airlineModel == nil){
        des = @"请选择航空公司";
    } else if (self.subsidiaryModel == nil) {
        des = @"请选择所属分子公司";
    } else if (self.dutiesModel == nil) {
        des = @"请选择职务等级";
    } else if (self.visaModel == nil) {
        des = @"请选择签证类型";
    } else if ([NSString isEmpty:self.cardView.text]) {
        des = @"请输入登记证号";
    } else if (self.sexModel == nil) {
        des = @"请选择性别";
    } else if ([NSString isEmpty: self.pwView.text]) {
        des = @"请输入密码";
    } else if ([NSString isEmpty: self.againPwView.text]) {
        des = @"请再次输入密码";
    } else if (![self.pwView.text isEqualToString:self.againPwView.text]) {
        des = @"密码和确认密码输入不一致";
    } else if ([NSString isEmpty: self.codeView.text]) {
        des = @"请输入验证码";
    }
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    [MBProgressHUD showToView:self.view];
    NSDictionary *param = @{@"phone":self.telView.text,
                            @"airline_id":@(self.airlineModel.airlineId),
                            @"subsidiary_id":@(self.subsidiaryModel.subsidiaryId),
                            @"duties_id":@(self.dutiesModel.dutiesId),
                            @"visa_id":@(self.visaModel.visaId),
                            @"work_number":self.cardView.text,
                            @"sex":@(self.sexModel.sexId),
                            @"password":self.pwView.text,
                            @"password_confirm":self.againPwView.text,
                            @"code":@"1234",
                            @"iden":[NSString safe_string:self.sendCodeModel.iden]
                            };
    [RequestPath user_registerParam:param success:^(id obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"注册成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
       [MBProgressHUD showError:mes ToView:self.view];
    }];
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
        _cardView = [[XYTextFieldView alloc]initWithLeftType:UITextFieldCard logoImageV:@"login_card" placeHolder:LOGIN_CARD_PLACEHOLDER];
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
