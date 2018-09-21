//
//  UIButton+Helper.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)

+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor {
    return [self buttonWithTitle:title font:font titleColor:titleColor backgroundImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                         font:(UIFont *)font
                   titleColor:(UIColor *)titleColor
              backgroundImage:(NSString *)backgroundImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (backgroundImage) {
        [btn setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    }
    return btn;
}
@end
