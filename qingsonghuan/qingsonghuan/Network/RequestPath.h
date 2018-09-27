//
//  RequestPath.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetworking.h"
@interface RequestPath : NSObject


/**
 注册页信息 ( 航空公司,子公司,职务,签证 )
 */
+ (void)user_regNeedInfoView:(UIView *)view
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 验证码接口
 */
+ (void)user_sendCodeView:(UIView *)view
                    phone:(NSString *)phone
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 注册
 */
+ (void)user_registerParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 找回密码
 */
+ (void)user_retrieveParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 登录
 */
+ (void)user_loginView:(UIView *)view
                 param:(NSDictionary *)param
               success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
               failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 添加航班信息页面 所需下拉框（签证，字母，，职务等级）
 */
+ (void)flight_dropdownView:(UIView *)view
                    success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                    failure:(void (^)(ErrorType errorType, NSString *mes))failure;











@end
