//
//  UILabel+Helper.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)
/**
 *  创建Label
 *
 *  @param text      标题
 *  @param font      字体大小
 *  @param textColor 字体颜色
 *
 *  @return UILabel
 */
- (instancetype)initWithText:(NSString *)text
                        font:(UIFont *)font
                   textColor:(UIColor *)textColor;
@end
