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

@end
