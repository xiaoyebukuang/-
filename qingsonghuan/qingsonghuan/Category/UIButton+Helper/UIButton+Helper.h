//
//  UIButton+Helper.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)

/**
 创建button（标题）

 @param title 标题
 @param font  标题大小
 @param titleColor 标题颜色
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                           font:(UIFont *)font
                     titleColor:(UIColor *)titleColor;


/**
 创建button（标题+背景图片）

 @param title 标题
 @param font 标题大小
 @param titleColor 标题颜色
 @param backgroundImage 背景图片
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                         font:(UIFont *)font
                   titleColor:(UIColor *)titleColor
              backgroundImage:(NSString *)backgroundImage;


/**
 创建button（图片）

 @param image 图片
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image;

/**
 创建button（图片+标题）

 @param image 图片
 @param title 标题
 @param selectTitle 选中标题
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                        title:(NSString *)title
                  selectTitel:(NSString *)selectTitle;


/**
 创建button（定时器）

 @param title 定时器标题
 @param font 字体带下
 @param normalColor 正常颜色
 @param disabledColor 禁用颜色
 @param normalBackgroundImage 正常背景图片
 @param disabledBackgroundImage 禁用背景图片
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                         font:(UIFont *)font
                  normalColor:(UIColor *)normalColor
                disabledColor:(UIColor *)disabledColor
        normalBackgroundImage:(NSString *)normalBackgroundImage
      disabledBackgroundImage:(NSString *)disabledBackgroundImage;


@end
