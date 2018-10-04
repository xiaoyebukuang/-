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

//TODO: APP接口
/**
 1.注册页信息 ( 航空公司,子公司,职务,签证 )
 */
+ (void)user_regNeedInfoView:(UIView *)view
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 2.发送手机验证码
 */
+ (void)user_sendCodeView:(UIView *)view
                    phone:(NSString *)phone
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 3.注册
 */
+ (void)user_registerView:(UIView *)view
                    Param:(NSDictionary *)param
                  success:(void (^)(id obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 4.找回密码
 */
+ (void)user_retrieveView:(UIView *)view
                    Param:(NSDictionary *)param
                  success:(void (^)(id obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 5.登录
 */
+ (void)user_loginView:(UIView *)view
                 param:(NSDictionary *)param
               success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
               failure:(void (^)(ErrorType errorType, NSString *mes))failure;


/**
 6.获取航段列表
 */
+ (void)flight_getListFlightParam:(NSDictionary *)param
                          success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                          failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 7.添加航班信息
 */
+ (void)flight_addlineView:(UIView *)view
                     param:(NSDictionary *)param
                   success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 8.用户站内信列表
 */
+ (void)letter_mesListParam:(NSDictionary *)param
                    success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                    failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 9.站内信删除
 */
+ (void)letter_mesdelView:(UIView *)view
                    param:(NSDictionary *)param
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 10.读站内信
 */
+ (void)letter_messeeView:(UIView *)view
                    param:(NSDictionary *)param
                  success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                  failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 11.当前用户未读信息数量
 */
+ (void)letter_isMessuccess:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                    failure:(void (^)(ErrorType errorType, NSString *mes))failure;


/**
 12.修改航班信息
 */
+ (void)flight_editFlightView:(UIView *)view
                        param:(NSDictionary *)param
                      success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                      failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 13.删除一条航班信息
 */
+ (void)flight_delFlightView:(UIView *)view
                        param:(NSDictionary *)param
                      success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                      failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 14.获取当前用户个人信息
 */
+ (void)user_getUserInfoView:(UIView *)view
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 15.个人信息修改
 */
+ (void)user_editUserInfoView:(UIView *)view
                        param:(NSDictionary *)param
                      success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                      failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 16.发送站内信
 */
+ (void)letter_mesSendView:(UIView *)view
                     param:(NSDictionary *)param
                   success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 17.添加建议
 */
+ (void)advice_addAdviceView:(UIView *)view
                       param:(NSDictionary *)param
                     success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                     failure:(void (^)(ErrorType errorType, NSString *mes))failure;


//TODO: 后台接口
/**
 1.注册人数统计
 */
+ (void)statistics_userStaView:(UIView *)view
                         param:(NSDictionary *)param
                       success:(void (^)(NSArray *obj, NSInteger code, NSString *mes))success
                       failure:(void (^)(ErrorType errorType, NSString *mes))failure;

/**
 2.根据设备统计人数
 */
+ (void)statistics_equipmentStaView:(UIView *)view
                              param:(NSDictionary *)param
                            success:(void (^)(NSArray *obj, NSInteger code, NSString *mes))success
                            failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 3.建议列表
 */
+ (void)statistics_getAdviceListParam:(NSDictionary *)param
                              success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                              failure:(void (^)(ErrorType errorType, NSString *mes))failure;
/**
 4.用户列表
 */
+ (void)statistics_getUserListParam:(NSDictionary *)param
                              success:(void (^)(NSDictionary *obj, NSInteger code, NSString *mes))success
                              failure:(void (^)(ErrorType errorType, NSString *mes))failure;

@end
