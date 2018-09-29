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
                  selectTitle:(NSString *)selectTitle
                         font:(UIFont *)font
                   titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectTitle forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
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
+ (UIButton *)buttonWithImage:(NSString *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
+ (UIButton *)buttonWithBGImage:(NSString *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
+ (UIButton *)buttonWithImage:(NSString *)image
                        title:(NSString *)title
                  selectTitel:(NSString *)selectTitle
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectTitle forState:UIControlStateSelected];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    return btn;
}
+ (UIButton *)buttonWithNormalBGImage:(NSString *)normalImage
                        selectBGImage:(NSString *)selectImage
                                title:(NSString *)title
                                 font:(UIFont *)font
                          normalColor:(UIColor *)normalColor
                          selectColor:(UIColor *)selectColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *nImage = [UIImage imageNamed:normalImage];
    nImage = [nImage stretchableImageWithLeftCapWidth:nImage.size.width/2 topCapHeight:nImage.size.height/2];
    [btn setBackgroundImage:nImage forState:UIControlStateNormal];
    
    UIImage *sImage = [UIImage imageNamed:selectImage];
    sImage = [sImage stretchableImageWithLeftCapWidth:nImage.size.width/2 topCapHeight:nImage.size.height/2];
    [btn setBackgroundImage:sImage forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    return btn;
}
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                          title:(NSString *)title
                           font:(UIFont *)font
                      textColor:(UIColor *)textColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *image = [UIImage imageNamed:bgImage];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                          image:(NSString *)image
                          title:(NSString *)title
                           font:(UIFont *)font
                      textColor:(UIColor *)textColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *nImage = [UIImage imageNamed:bgImage];
    nImage = [nImage stretchableImageWithLeftCapWidth:nImage.size.width/2 topCapHeight:nImage.size.height/2];
    [btn setBackgroundImage:nImage forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    btn.titleLabel.font = font;
    return btn;
}
+ (UIButton *)buttonWithTitle:(NSString *)title
                         font:(UIFont *)font
                  normalColor:(UIColor *)normalColor
                disabledColor:(UIColor *)disabledColor
        normalBackgroundImage:(NSString *)normalBackgroundImage
      disabledBackgroundImage:(NSString *)disabledBackgroundImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:disabledColor forState:UIControlStateDisabled];
    [btn setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disabledBackgroundImage] forState:UIControlStateDisabled];
    return btn;
}
@end
