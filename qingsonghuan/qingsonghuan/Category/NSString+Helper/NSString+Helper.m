//
//  NSString+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

/** 返回安全的字符串 */
+ (NSString *)safe_string:(id)obj {
    if ([obj isEqual:[NSNull null]]||obj == nil) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",obj];
    }
}
/** 保留两个小数 */
+ (NSString *)safe_twoDecimal:(id)obj {
    return [NSString stringWithFormat:@"%.2f",[self safe_float:obj]];
}
/** 保留一个小数 */
+ (NSString *)safe_oneDecimal:(id)obj {
    return [NSString stringWithFormat:@"%.1f",[self safe_float:obj]];
}
/** 返回float型 */
+ (float)safe_float:(id)obj {
    return [NSString safe_string:obj].floatValue;
}
/** 返回intefer型 */
+ (NSInteger)safe_integer:(id)obj {
    return [NSString safe_string:obj].integerValue;
}
/** 验证手机号码及固定电话 */
+ (BOOL)validatePhoneNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *mobile = @"^1[3|4|5|7|8][0-9]\\d{8}";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"(^(0(10|2[0-5789][-]{0,1}|\\d{3}[-]{0,1})\\d{7,8})|(\\d{7,8})$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestPHS evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}
/** 判断字符串是否为空 */
+ (BOOL)isEmpty:(id)obj {
    if (obj == nil) {
        return YES;
    }
    if ([[NSString safe_string:obj] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
@end
