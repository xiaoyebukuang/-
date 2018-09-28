//
//  UIColor+Helper.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/20.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

+ (UIColor *)color_DCDCDC {
    UIColor *color = UIColorFromRGB(0xDCDCDC);
    return color;
}
+ (UIColor *)color_ABABAB {
    UIColor *color = UIColorFromRGB(0xABABAB);
    return color;
}
+ (UIColor *)color_FFFFFF {
    UIColor *color = UIColorFromRGB(0xFFFFFF);
    return color;
}
+ (UIColor *)color_99D3F8 {
    UIColor *color = UIColorFromRGB(0x99D3F8);
    return color;
}
+ (UIColor *)color_99D3F8_3 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.3);
    return color;
}
+ (UIColor *)color_C7C7C7 {
    UIColor *color = UIColorFromRGB(0xC7C7C7);
    return color;
}

+ (UIColor *)color_333333 {
    UIColor *color = UIColorFromRGB(0x333333);
    return color;
}
+ (UIColor *)color_000000:(CGFloat)a {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,a);
    return color;
}
+ (UIColor *)color_2ECB87 {
    UIColor *color = UIColorFromRGB(0x2ECB87);
    return color;
}
+ (UIColor *)color_666666 {
    UIColor *color = UIColorFromRGB(0x666666);
    return color;
}
+ (UIColor *)color_F7F8F9 {
    UIColor *color = UIColorFromRGB(0xF7F8F9);
    return color;
}
+ (UIColor *)color_D5E8F6 {
    UIColor *color = UIColorFromRGB(0xD5E8F6);
    return color;
}
+ (UIColor *)color_84BBDE {
    UIColor *color = UIColorFromRGB(0x84BBDE);
    return color;
}
@end
