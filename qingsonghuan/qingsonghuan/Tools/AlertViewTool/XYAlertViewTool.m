//
//  XYAlertViewTool.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYAlertViewTool.h"



@interface XYAlertViewTool()
/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;
/** 输入框 */
@property (nonatomic, strong) XYTextField *textField;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 内容 */
@property (nonatomic, copy) NSString *message;
/** 标题Label */
@property (nonatomic, strong) UILabel *titleLabel;
/** 副标题Label */
@property (nonatomic, strong) UILabel *messageLabel;
/** 左边按钮title */
@property (nonatomic, copy)   NSString *leftButtonTitle;
/** 右边按钮title */
@property (nonatomic, copy)   NSString *rightButtonTitle;
/** 回调 */
@property (nonatomic, copy)   AlertBlock alertBlock;
/** 确定回调 */
@property (nonatomic, copy)   AlertSureBlock alertSureBlock;
/** 取消确定按钮 */
@property (nonatomic, strong) UIView *btnBgView;
@end
@implementation XYAlertViewTool
+ (void)showTitle:(NSString *)title message:(NSString *)message alertSureBlock:(AlertSureBlock)alertSureBlock {
    XYAlertViewTool *tool = [[XYAlertViewTool alloc]initWithTitle:title message:message alertSureBlock:alertSureBlock leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    [tool show];
}
+ (void)showFieldView:(AlertBlock)alertBlock {
    XYAlertViewTool *tool = [[XYAlertViewTool alloc]initWithTitle:@"城市或机场" alertBlock:alertBlock leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    [tool show];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 1;
        }];
        //------- 弹窗主内容 -------//
        [self addSubview:self.contentView];
        self.contentView.frame = CGRectMake((MAIN_SCREEN_WIDTH - 285)/2, (MAIN_SCREEN_HEIGHT - 150)/2, 285, 150);
    }
    return self;
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message alertSureBlock:(AlertSureBlock)alertSureBlock leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle {
    self = [self init];
    if (self) {
        self.title = title;
        self.message = message;
        self.alertSureBlock = alertSureBlock;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        [self setupSureUI];
    }
    return self;
}


- (instancetype)initWithTitle:(NSString *)title alertBlock:(AlertBlock)alertBlock leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle {
    self = [self init];
    if (self) {
        self.alertBlock = alertBlock;
        self.title = title;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        [self setUpUI];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupSureUI {
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = self.title;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(20);
    }];
    
    [self.contentView addSubview:self.btnBgView];
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.messageLabel];
    self.messageLabel.text = self.message;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
}
- (void)setUpUI {
    // 接收键盘显示隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    // 标题
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = self.title;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(20);
    }];
    //输入框
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.contentView).offset(50);
    }];
    [self.contentView addSubview:self.btnBgView];
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
}
#pragma mark -- event
- (void)leftBtnEvent:(UIButton *)sender {
    if (self.alertBlock) {
        self.alertBlock(nil, NO);
    }
    [self dismiss];
}
- (void)rightBtnEvent:(UIButton *)sender {
    if (self.alertBlock) {
        if ([NSString isEmpty:self.textField.text]) {
            [MBProgressHUD showError:@"请输入城市名称"];
            return;
        }
        self.alertBlock(self.textField.text, YES);
    }
    if (self.alertSureBlock) {
        self.alertSureBlock();
    }
    [self dismiss];
}
#pragma mark -- 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow endEditing:YES];
    [keyWindow addSubview:self];
}
#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}
/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndHeight = value.CGRectValue.size.height;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.contentView.top = (MAIN_SCREEN_HEIGHT - keyBoardEndHeight - 150)/2;
    }];
}
/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
-(void)keyboardWillHidden:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.contentView.top = (MAIN_SCREEN_HEIGHT - 150)/2;
    }];
}
#pragma mark -- setup
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 6;
    }
    return _contentView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_666666]];
    }
    return _titleLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_666666]];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
- (XYTextField *)textField {
    if (!_textField) {
        _textField = [[XYTextField alloc]initWithType:UITextFieldCity placeHolder:@"请输入城市名称"];
    }
    return _textField;
}
- (UIView *)btnBgView {
    if (!_btnBgView) {
        UIView *btnView = [[UIView alloc]init];
        
        UIView *line01 = [[XYLineView alloc]init];
        [btnView addSubview:line01];
        [line01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(btnView);
            make.height.mas_equalTo(1);
        }];
        UIView *line02 = [[XYLineView alloc]init];
        [btnView addSubview:line02];
        [line02 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(btnView);
            make.width.mas_equalTo(0.5);
            make.centerX.equalTo(btnView);
        }];
        
        UIButton *cancle = [UIButton buttonWithTitle:self.leftButtonTitle font:SYSTEM_FONT_17 titleColor:[UIColor color_33B1FE]];
        [cancle addTarget:self action:@selector(leftBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:cancle];
        [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(btnView);
            make.right.equalTo(line02.mas_left);
            make.top.equalTo(line01.mas_bottom);
        }];
        UIButton *sure = [UIButton buttonWithTitle:self.rightButtonTitle font:SYSTEM_FONT_17 titleColor:[UIColor color_33B1FE]];
        [sure addTarget:self action:@selector(rightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:sure];
        [sure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(btnView);
            make.top.equalTo(cancle);
            make.left.equalTo(line02.mas_right);
        }];
        _btnBgView = btnView;
    }
    return _btnBgView;
}


@end
