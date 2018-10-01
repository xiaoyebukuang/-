
//
//  NSDate+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)
+ (NSString *)getFormatType:(FormatType)type {
    switch (type) {
        case FormatDefault:
            return @"yyyy-MM-dd HH:mm:ss";
            break;
        case FormatyyyyMdHmsS:
            return @"yyyy-MM-dd HH:mm:ss.SSS";
            break;
        case FormatyyyyMdHm:
            return @"yyyy-MM-dd HH:mm";
            break;
        case FormatyyMdHm:
            return @"yy-MM-dd HH:mm";
            break;
        case FormatyyyyMd:
            return @"yyyy-MM-dd";
            break;
        case FormatyyyyM:
            return @"yyyy-MM";
            break;
        case FormatyyMd:
            return @"yy-MM-dd";
            break;
        case FormatMdHms:
            return @"MM-dd HH:mm:ss";
            break;
        case FormatMdHm:
            return @"MM-dd HH:mm";
            break;
        case FormatMd:
            return @"MM-dd";
            break;
        case FormatHms:
            return @"HH:mm:ss";
            break;
        case FormatHm:
            return @"HH:mm";
            break;
        case FormatYYYYMdHmsS:
            return @"yyyyMMddHHmmssSSS";
            break;
        case FormatYYYYMdHms:
            return @"yyyyMMddHHmmss";
            break;
        case FormatYYYYMd:
            return @"yyyyMMdd";
            break;
    }
}
//将今天转化为指定格式的日期String
+ (NSString *)getTodayDateStringFormatType:(FormatType)type {
    return [self getDateString:[NSDate date] formatType:type];
}

//将时间转化为指定格式的日期String
+ (NSString *)getDateString:(NSDate *)date formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return  [dateFormatter stringFromDate:date];
}
//将字符串转化为指定格式的时间
+ (NSDate *)getDate:(NSString *)dateStr formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return [dateFormatter dateFromString:dateStr];
}
//获取时间戳
+ (NSTimeInterval)getDateStample:(NSDate *)data {
    return [data timeIntervalSince1970];
}
//获取时间戳
+ (NSTimeInterval)getDateStample:(NSString *)dateStr formatType:(FormatType)type {
    return [self getDateStample:[self getDate:dateStr formatType:type]];
}
//将时间戳转化为指定的字符串
+ (NSString *)getDateStringWithDateStaple:(NSTimeInterval)time formatType:(FormatType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [self getDateString:date formatType:type];
}

@end
