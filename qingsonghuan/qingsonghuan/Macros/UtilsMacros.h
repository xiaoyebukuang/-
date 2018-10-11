//
//  UtilsMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

/** 系统版本 */
#define IS_IOS_VERSION   floorf([[UIDevice currentDevice].systemVersion floatValue])
#define IS_IOS_5    floorf([[UIDevice currentDevice].systemVersion floatValue]) >=5.0 ? 1 : 0
#define IS_IOS_6    floorf([[UIDevice currentDevice].systemVersion floatValue]) >=6.0 ? 1 : 0
#define IS_IOS_7    floorf([[UIDevice currentDevice].systemVersion floatValue]) >=7.0 ? 1 : 0
#define IS_IOS_8    floorf([[UIDevice currentDevice].systemVersion floatValue]) >=8.0 ? 1 : 0
#define IS_IOS_9    floorf([[UIDevice currentDevice].systemVersion floatValue]) >=9.0 ? 1 : 0
#define IS_IOS_11   floorf([[UIDevice currentDevice].systemVersion floatValue]) >=11.0 ? 1 : 0

/** 获取RGB颜色 */
#define RGBA(r,g,b,a)                 [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)                    RGBA(r,g,b,1.0f)
#define COLOR_RGB_ALPHA(rgbValue,a)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]
#define COLOR_RGB(rgbValue,a)         [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(1.0)]
/**
 * 16进制颜色定义
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



/** 字体 */
#define SYSTEM_BOLD_FONT(FONTSIZE)      [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEM_FONT(FONTSIZE)           [UIFont systemFontOfSize:FONTSIZE]
#define SYSTEM_FONT_13                  [UIFont systemFontOfSize:13]
#define SYSTEM_FONT_15                  [UIFont systemFontOfSize:15]
#define SYSTEM_FONT_17                  [UIFont systemFontOfSize:17]
#define SYSTEM_FONT_20                  [UIFont systemFontOfSize:20]

//登录提示语句
#define LOGIN_TEL_PLACEHOLDER           @"请输入手机号"
#define LOGIN_PSW_PLACEHOLDER           @"请输入密码"
#define LOGIN_AGAIN_PSW_PLACEHOLDER     @"请再次输入密码"
#define LOGIN_CODE_PLACEHOLDER          @"请输入验证码"

#define LOGIN_COMPANY_PLACEHOLDER       @"选择航空公司"
#define LOGIN_AREA_PLACEHOLDER          @"所属分子公司"
#define LOGIN_POST_PLACEHOLDER          @"选择职务等级"
#define LOGIN_VISA_PLACEHOLDER          @"选择签证类型"
#define LOGIN_CARD_PLACEHOLDER          @"输入登机证号"
#define LOGIN_SEX_PLACEHOLDER           @"选择性别"

#define API_REUQEST_FAILED              @"请求失败"

#define FLIGHT_SIGN_DATE                @"请选择签到日期"
#define FLIGHT_SIGN_TIME                @"请选择签到时间"
#define FLIGHT_AIR_NUMBER               @"请输入航班号码"
#define FLIGHT_WORD_SIGN                @"请选择字母标识"
#define FLIGHT_FIRST_LEG                @"如 虹桥 浦东"


//用户信息宏定义
//是否登录
#define USER_IS_LOGIN                   @"isLogin"
//用户id
#define USER_USERID                     @"userId"
//签名
#define USER_SIGN                       @"sign"
//电话
#define USER_PHONE                      @"phone"
//管理员权限
#define USER_IDENTITY                   @"identity"


//保存的版本号
#define VERSION_NUMBER                     @"version_number"


#endif /* UtilsMacros_h */
