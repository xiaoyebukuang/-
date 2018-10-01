//
//  NSDate+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, FormatType) {
    FormatDefault,          //yyyy-MM-dd HH:mm:ss
    FormatyyyyMdHmsS,       //yyyy-MM-dd HH:mm:ss.SSS
    FormatyyyyMdHm,         //yyyy-MM-dd HH:mm
    FormatyyMdHm,           //yy-MM-dd HH:mm
    FormatyyyyMd,           //yyyy-MM-dd
    FormatyyyyM,            //yyyy-MM
    FormatyyMd,             //yy-MM-dd
    FormatMdHms,            //MM-dd HH:mm:ss
    FormatMdHm,             //MM-dd HH:mm
    FormatMd,               //MM-dd
    FormatHms,              //HH:mm:ss
    FormatHm,               //HH:mm
    FormatYYYYMdHmsS,       //yyyyMMddHHmmssSSS
    FormatYYYYMdHms,        //yyyyMMddHHmmss
    FormatYYYYMd,           //yyyyMMdd
};
@interface NSDate (Helper)


/**
 将今天转化为指定格式的日期String
 @param type 格式
 @return 返回时间String
 */
+ (NSString *)getTodayDateStringFormatType:(FormatType)type;

/**
 将时间转化为指定格式的日期String
 @param date 时间
 @param type 时间类型
 @return 时间字符串
 */
+ (NSString *)getDateString:(NSDate *)date formatType:(FormatType)type;

/**
 将字符串转化为指定格式的时间
 @param dateStr 时间字符串
 @param type 时间类型
 @return 返回转换时间
 */
+ (NSDate *)getDate:(NSString *)dateStr formatType:(FormatType)type;

/**
 获取时间戳
 
 @param date 时间毫秒
 @return 返回时间戳
 */
+ (NSTimeInterval)getDateStample:(NSDate *)date;

/**
 获取时间戳
 
 @param dateStr 时间字符串
 @param type 时间类型
 @return 返回时间戳
 */
+ (NSTimeInterval)getDateStample:(NSString *)dateStr formatType:(FormatType)type;

/**
 将时间戳转化为指定的字符串

 @param time 时间戳
 @param type 类型
 @return 返回时间戳的字符串
 */
+ (NSString *)getDateStringWithDateStaple:(NSTimeInterval)time formatType:(FormatType)type;

@end
