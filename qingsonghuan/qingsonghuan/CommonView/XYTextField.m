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
 类型
 */
@property (nonatomic, assign) UITextFieldType filedType;

/**
 最大限制个数
 */
@property (nonatomic, assign) int numberCount;



@end
@implementation XYTextField

- (instancetype)initWithType:(UITextFieldType)filedType {
    self = [self initWithType:filedType placeHolder:nil];
    return self;
}

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
    [self addTarget:self action:@selector(changeFieldValue:) forControlEvents:UIControlEventEditingChanged];
    if (placeHolder) {
        self.placeholder = placeHolder;
    }
    switch (self.filedType) {
        case UITextFieldTel:
        {
            self.placeholder = @"请输入手机号码";
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
