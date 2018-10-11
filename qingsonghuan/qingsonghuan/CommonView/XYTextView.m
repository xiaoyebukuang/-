//
//  XYTextView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYTextView.h"

@interface XYTextView()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation XYTextView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = SYSTEM_FONT_15;
        self.textColor = [UIColor color_333333];
        self.delegate = self;
        [self addSubview:self.placeHolderLabel];
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(2);
            make.top.equalTo(self).offset(7);
        }];
    }
    return self;
}
- (void)setText:(NSString *)text {
    [super setText:text];
    self.placeHolderLabel.hidden = ![NSString isEmpty:text];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.placeHolderLabel.text = placeHolder;
}
#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if ([self.xy_delegate respondsToSelector:@selector(xy_textViewDidChange:)]) {
        [self.xy_delegate xy_textViewDidChange:textView.text];
    }
    self.placeHolderLabel.hidden = ![NSString isEmpty:textView.text];
    //限制输入字符数
    NSString *toBeString = textView.text;
    NSString *lang = [textView.textInputMode primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if(toBeString.length > self.maxCount) {
                textView.text = [toBeString substringToIndex:self.maxCount];
            }
        } else {
            //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if(toBeString.length > self.maxCount) {
            textView.text= [toBeString substringToIndex:self.maxCount];
        }
    }
}
- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_999999]];
    }
    return _placeHolderLabel;
}

@end
