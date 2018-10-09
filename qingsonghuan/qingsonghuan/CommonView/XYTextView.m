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
}
- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_999999]];
    }
    return _placeHolderLabel;
}

@end
