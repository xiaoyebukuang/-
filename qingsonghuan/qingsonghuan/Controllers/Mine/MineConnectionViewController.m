//
//  MineConnectionViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MineConnectionViewController.h"
#import "XYTextView.h"
@interface MineConnectionViewController ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) XYTextView *textView;

@property (nonatomic, strong) UIView *telView;

@property (nonatomic, strong) XYTextField *textField;

@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation MineConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor color_f7f8fa];
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.right.equalTo(self.view).offset(-CELL_LEFT_APACE);
        make.height.mas_equalTo(220);
    }];
    
    [self.view addSubview:self.telView];
    [self.telView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).offset(CELL_LEFT_APACE);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)submitBtnEvent:(UIButton *)sender {
    NSString *des;
    if ([NSString isEmpty:self.textView.text]) {
        des = @"请填写您的宝贵意见";
    } else if (![NSString validatePhoneNumber:self.textField.text]) {
        des = @"您的电话格式不正确";
    }
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    //发送请求
    [RequestPath advice_addAdviceView:self.view param:@{@"phone":self.textField.text,@"advice_info":self.textView.text} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"发送成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
    
}
#pragma mark -- setup
- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor color_FFFFFF];
        [view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
            make.top.equalTo(view).offset(10);
            make.right.equalTo(view).offset(-10);
            make.bottom.equalTo(view).offset(-10);
        }];
        _contentView = view;
    }
    return _contentView;
}
- (XYTextView *)textView {
    if (!_textView) {
        _textView = [[XYTextView alloc]init];
        _textView.placeHolder = @"请您留下您的宝贵意见，我们将努力改进!";
    }
    return _textView;
}
- (UIView *)telView {
    if (!_telView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor color_FFFFFF];
        [view addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
            make.right.equalTo(view).offset(-10);
            make.centerY.equalTo(view);
            make.height.mas_equalTo(30);
        }];
        _telView = view;
    }
    return _telView;
}

- (XYTextField *)textField {
    if (!_textField) {
        _textField = [[XYTextField alloc]initWithType:UITextFieldTel placeHolder:@"请留下手机号码，以便我们回复您！"];
        _textField.text = [UserModel sharedInstance].phone;
    }
    return _textField;
}
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithBGImage:@"mail_submit_btn" title:@"发 送" font:SYSTEM_FONT_17 textColor:[UIColor color_FFFFFF]];
        [_submitBtn addTarget:self action:@selector(submitBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
