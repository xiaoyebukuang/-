//
//  XYTextField.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//
#import "XYTextField.h"

static CGFloat const LOGIN_WIDTH_SIZE = 50.0;

typedef NS_ENUM(NSInteger, UITextFieldViewType) {
    UITextFieldViewLeft,            //左侧图标+填充
    UITextFieldViewLeftRight,       //左侧图标+右侧图标（可点击）+填充
    UITextFieldViewSelect,          //左侧图标+右侧图标（不可点击）+选择
    UITextFieldViewCode             //左侧图标+右侧验证码+填充
};


@interface XYTextFieldView()
/**
 logo图标
 */
@property (nonatomic, strong) UIImageView *logoImageV;
/**
 尾标
 */
@property (nonatomic, strong) UIButton *arrowBtn;
/**
 输入框
 */
@property (nonatomic, strong) XYTextField *textField;

/**
 定时器
 */
@property (nonatomic, strong) UIButton *timeBtn;

/**
 分割线
 */
@property (nonatomic, strong) XYLineView *lineV;

/**
 定时器
 */
@property (nonatomic, strong) dispatch_source_t timer;

/**
 倒计时
 */
@property (nonatomic, assign) NSInteger timeCount;

/**
 选择框
 */
@property (nonatomic, strong) UIControl *control;

@end

@implementation XYTextFieldView

- (instancetype)initWithLeftType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewLeft logoImageV:logoStr arrowImageVNormal:nil arrowImageVSelect:nil placeHolder:placeHolder type:filedType];
    }
    return self;
}
- (instancetype)initWithLeftRightType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr arrowImageVNormal:(NSString *)normalArrowStr arrowImageVSelect:(NSString *)selectArrowStr placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewLeftRight logoImageV:logoStr arrowImageVNormal:normalArrowStr arrowImageVSelect:selectArrowStr placeHolder:placeHolder type:filedType];
    }
    return self;
}
- (instancetype)initWithSelectType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr arrowImageV:(NSString *)arrowStr  placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewSelect logoImageV:logoStr arrowImageVNormal:arrowStr arrowImageVSelect:arrowStr placeHolder:placeHolder type:filedType];
    }
    return self;
}
- (instancetype)initWithCodeType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewCode logoImageV:logoStr arrowImageVNormal:nil arrowImageVSelect:nil placeHolder:placeHolder type:filedType];
    }
    return self;
}

- (void)setupViewWithViewType:(UITextFieldViewType)fieldVeiwType logoImageV:(NSString *)logoStr arrowImageVNormal:(NSString *)normalArrowStr arrowImageVSelect:(NSString *)selectArrowStr placeHolder:(NSString *)placeHolder type:(UITextFieldType)filedType{
    [self addSubview:self.logoImageV];
    self.logoImageV.image = [UIImage imageNamed:logoStr];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.left.equalTo(self);
        make.width.mas_equalTo(LOGIN_WIDTH_SIZE);
    }];
    
    [self addSubview:self.arrowBtn];
    [self.arrowBtn setImage:[UIImage imageNamed:normalArrowStr] forState:UIControlStateNormal];
    [self.arrowBtn setImage:[UIImage imageNamed:selectArrowStr] forState:UIControlStateSelected];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.right.equalTo(self);
        make.width.equalTo(self.logoImageV);
    }];
    
    self.textField = [[XYTextField alloc]initWithType:filedType placeHolder:placeHolder];
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageV.mas_right);
        make.right.equalTo(self.arrowBtn.mas_left);
        make.centerY.equalTo(self);
    }];

    [self addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    switch (fieldVeiwType) {
        case UITextFieldViewLeft:
        {
            //只有左侧图标
            self.arrowBtn.hidden = YES;
        }
            break;
        case UITextFieldViewSelect:
        {
            //选择框
            self.arrowBtn.enabled = NO;
            self.textField.enabled = NO;
            [self addSubview:self.control];
            [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.textField);
            }];
        }
            break;
        case UITextFieldViewCode:
        {
            //验证码
            [self.arrowBtn removeFromSuperview];
            [self addSubview:self.timeBtn];
            [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.right.equalTo(self);
                make.height.mas_equalTo(35);
                make.width.mas_offset(120);
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- event
//选择回调
- (void)controlEvent:(UIControl *)sender {
    if (self.selectBlock) {
        self.selectBlock();
    }
}
//右侧图标点击
- (void)arrowBtnEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = sender.selected;
}
//定时器
- (void)timeBtnEvent:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock();
    }
}
- (void)startTimer {
    if (!_timer) {
        self.timeCount = 10;
        //定时器开始执行的延时时间
        NSTimeInterval delayTime = 1.0f;
        //定时器间隔时间
        NSTimeInterval timeInterval = 1.0f;
        //创建子线程队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //使用之前创建的队列来创建计时器
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //设置延时执行时间，delayTime为要延时的秒数
        dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
        //设置计时器
        dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeCount --;
            });
        });
        // 启动计时器
        dispatch_resume(_timer);
    }
}
- (void)setTimeCount:(NSInteger)timeCount {
    if (timeCount == 0) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        self.timeBtn.enabled = YES;
    } else {
        _timeCount = timeCount;
        self.timeBtn.enabled = NO;
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%lds后重新发送",_timeCount] forState:UIControlStateDisabled];
    }
}
- (void)dealloc {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

#pragma mrak -- setup
- (NSString *)text {
    return self.textField.text;
}
- (void)setText:(NSString *)text {
    self.textField.text = text;
}
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]init];
        _logoImageV.contentMode = UIViewContentModeCenter;
    }
    return _logoImageV;
}
- (UIButton *)arrowBtn {
    if (!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn addTarget:self action:@selector(arrowBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}

- (UIControl *)control {
    if (!_control) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}

- (UIButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithTitle:@"发送验证码" font:SYSTEM_FONT_15 normalColor:[UIColor color_FFFFFF] disabledColor:[UIColor color_FFFFFF] normalBackgroundImage:@"login_time_normal" disabledBackgroundImage:@"login_time_disabled"];
        [_timeBtn addTarget:self action:@selector(timeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeBtn;
}

- (XYLineView *)lineV {
    if (!_lineV) {
        _lineV = [[XYLineView alloc]init];
    }
    return _lineV;
}
@end





@interface XYTextField() <UITextFieldDelegate>
/**
 类型
 */
@property (nonatomic, assign) UITextFieldType filedType;
/**
 最大限制个数
 */
@property (nonatomic, assign) int numberCount;

@end

@implementation XYTextField
- (instancetype)initWithType:(UITextFieldType)filedType placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        self.filedType = filedType;
        [self setupView: placeHolder];
    }
    return self;
}

- (void)setupView:(NSString *)placeHolder {
    self.delegate = self;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.font = SYSTEM_FONT_15;
    self.textColor = [UIColor color_333333];
    [self setValue:[UIColor color_ABABAB] forKeyPath:@"_placeholderLabel.textColor"];
    [self addTarget:self action:@selector(changeFieldValue:) forControlEvents:UIControlEventEditingChanged];
    if (placeHolder) {
        self.placeholder = placeHolder;
    }
    switch (self.filedType) {
        case UITextFieldTel:
        {
            self.numberCount = 11;
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.borderStyle = UITextBorderStyleNone;
        }
            break;
        case UITextFieldPassword:
        {
            self.numberCount = 10;
            self.keyboardType = UIKeyboardTypeASCIICapable;            
            self.borderStyle = UITextBorderStyleNone;
        }
            break;
        case UITextFieldCode:
        {
            self.numberCount = 6;
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.borderStyle = UITextBorderStyleNone;
        }
            break;
        default:
            break;
    }
}

- (void)changeFieldValue:(UITextField *)field {
    if (self.filedType == UITextFieldTel || self.filedType == UITextFieldPassword) {
        if (field.text.length > self.numberCount) {
            field.text = [field.text substringToIndex:self.numberCount];
        }
    }
}

#pragma makr -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (self.filedType) {
            case UITextFieldTel:
            case UITextFieldCode:
        {
            NSUInteger length = string.length;
            for (int loopIndex = 0; loopIndex < length; loopIndex ++) {
                unichar ca = [string characterAtIndex:loopIndex];
                if (ca < 48) return NO;
                if (ca > 57) return NO;
            }
            NSUInteger proposeLength = textField.text.length - range.length + string.length;
            if (proposeLength > self.numberCount) {
                return NO;
            }
        }
            break;
        case UITextFieldPassword:
        {
            NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            for (int loopIndex = 0; loopIndex < length; loopIndex ++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 48) return NO;
                if (character > 57 && character < 65) return NO;
                if (character > 90 && character < 97) return NO;
                if (character > 122) return NO;
            }
            NSUInteger proposeLength = textField.text.length - range.length + string.length;
            if (proposeLength > self.numberCount) {
                return NO;
            }
        }
            break;
        default:
            break;
    }
    return YES;
}


@end
