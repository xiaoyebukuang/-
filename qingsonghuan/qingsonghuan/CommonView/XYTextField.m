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
    UITextFieldViewSelect           //左侧图标+右侧图标（不可点击）+选择
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
 分割线
 */
@property (nonatomic, strong) XYLineView *lineV;

@end

@implementation XYTextFieldView

- (instancetype)initWithType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewLeft logoImageV:logoStr arrowImageVNormal:nil arrowImageVSelect:nil placeHolder:placeHolder type:filedType];
    }
    return self;
}
- (instancetype)initWithType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr arrowImageVNormal:(NSString *)normalArrowStr arrowImageVSelect:(NSString *)selectArrowStr placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewLeftRight logoImageV:logoStr arrowImageVNormal:normalArrowStr arrowImageVSelect:selectArrowStr placeHolder:placeHolder type:filedType];
    }
    return self;
}
- (instancetype)initWithType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr arrowImageV:(NSString *)arrowStr  placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        [self setupViewWithViewType:UITextFieldViewSelect logoImageV:logoStr arrowImageVNormal:arrowStr arrowImageVSelect:arrowStr placeHolder:placeHolder type:filedType];
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
        make.top.bottom.equalTo(self);
    }];

    [self addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    switch (fieldVeiwType) {
        case UITextFieldViewLeft:
        {
            self.arrowBtn.hidden = YES;
        }
            break;
        case UITextFieldViewSelect:
        {
            self.arrowBtn.enabled = NO;
            self.textField.enabled = NO;
        }
            break;
        default:
            break;
    }
}
#pragma mark -- event
- (void)arrowBtnEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = sender.selected;
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
    self.textColor = [UIColor redColor];
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
