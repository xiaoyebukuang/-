//
//  XYTextField.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//
#import "XYTextField.h"
@interface XYTextField() <UITextFieldDelegate>
/**
 最大限制个数
 */
@property (nonatomic, assign) int numberCount;

@end

@implementation XYTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithType:(UITextFieldType)filedType placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        if (placeHolder) {
            self.placeholder = placeHolder;
        }
        [self setupView];
        self.filedType = filedType;
    }
    return self;
}
- (void)setFiledType:(UITextFieldType)filedType {
    _filedType = filedType;
    switch (self.filedType) {
        case UITextFieldTel:
        {
            self.numberCount = 11;
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case UITextFieldPassword:
        {
            self.numberCount = 10;
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
        case UITextFieldCode:
        {
            self.numberCount = 6;
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case UITextFieldCard:
        {
            self.numberCount = 7;
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
        case UITextFieldFlight:
        {
            self.numberCount = 4;
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case UITextFieldCity:
        {
            self.numberCount = 5;
            self.keyboardType = UIKeyboardTypeDefault;
            self.borderStyle = UITextBorderStyleRoundedRect;
        }
            break;
        default:
            break;
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    [self setValue:[UIColor color_999999] forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setupView{
    self.delegate = self;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.font = SYSTEM_FONT_15;
    self.borderStyle = UITextBorderStyleNone;
    self.textColor = [UIColor color_333333];
    [self setValue:[UIColor color_999999] forKeyPath:@"_placeholderLabel.textColor"];
    [self addTarget:self action:@selector(changeFieldValue:) forControlEvents:UIControlEventEditingChanged];
}

- (void)changeFieldValue:(UITextField *)field {
    if (self.filedType == UITextFieldPassword || self.filedType == UITextFieldCard) {
        if (field.text.length > self.numberCount) {
            field.text = [field.text substringToIndex:self.numberCount];
        }
    }
    if ([self.xyDelegate respondsToSelector:@selector(textChange:)]) {
        [self.xyDelegate textChange:field.text];
    }
}

#pragma makr -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (self.filedType) {
            case UITextFieldTel:
            case UITextFieldCode:
            case UITextFieldFlight:
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
        case UITextFieldCard:
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
        case UITextFieldCity:
        {
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
