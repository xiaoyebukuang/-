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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
        case UITextFieldCity:
        {
            self.numberCount = 5;
            self.keyboardType = UIKeyboardTypeDefault;
            self.borderStyle = UITextBorderStyleRoundedRect;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:self];
        }
            break;
        case UITextFieldLeg:
        {
            self.numberCount = 2;
            self.keyboardType = UIKeyboardTypeDefault;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:self];
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
// 监听文本改变
-(void)textViewEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    //限制输入字符数
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if(toBeString.length > self.numberCount) {
                textField.text = [toBeString substringToIndex:self.numberCount];
            }
        } else {
            //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if(toBeString.length > self.numberCount) {
            textField.text= [toBeString substringToIndex:self.numberCount];
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
        case UITextFieldCard:
        case UITextFieldFlight:
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
