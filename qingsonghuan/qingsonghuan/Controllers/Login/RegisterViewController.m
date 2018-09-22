//
//  RegisterViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterViewController.h"
#import "XYPickerViewController.h"
static CGFloat const LOGIN_SPACE_SIZE = 10.0;


/**
 注册
 */
@interface RegisterViewController ()
/**
 航空公司
 */
@property (nonatomic, strong) XYTextFieldView *companyView;

/**
 所属地区
 */
@property (nonatomic, strong) XYTextFieldView *areaView;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.companyView];
    [self.companyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view).offset(LOGIN_SPACE_SIZE);
    }];
    
    [self.view addSubview:self.areaView];
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.companyView);
        make.top.equalTo(self.companyView.mas_bottom).offset(LOGIN_SPACE_SIZE);
    }];
    
    
    __weak __typeof(self)weakSelf = self;
    self.companyView.selectBlock = ^{
        NSLog(@"请选择航空公司名称");
        XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
        [weakSelf presentViewController:pickerVC animated:YES completion:nil];
    };
    self.areaView.selectBlock = ^{
        NSLog(@"请选择所属地区");
    };
}
#pragma mark -- setup
- (XYTextFieldView *)companyView {
    if (!_companyView) {
        _companyView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_tel" arrowImageV:@"login_tel" placeHolder:@"请选择航空公司名称"];
    }
    return _companyView;
}
- (XYTextFieldView *)areaView {
    if (!_areaView) {
        _areaView = [[XYTextFieldView alloc]initWithSelectType:UITextFieldNormal logoImageV:@"login_tel" arrowImageV:@"login_tel" placeHolder:@"请选择所属地区"];
    }
    return _areaView;
}



@end
