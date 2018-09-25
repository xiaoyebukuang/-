//
//  RequestPath.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RequestPath.h"

@implementation RequestPath
//注册页信息 ( 航空公司,子公司,职务,签证 )
+ (void)user_regNeedInfoSuccess:(void (^)(id obj, NSInteger code, NSString *mes))success
                        failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_USER_REGNEEDINFO success:success failure:failure];
}
// 验证码接口
+ (void)user_sendCodeParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_USER_SENDCODE parameters:param success:success failure:failure];
}
//注册
+ (void)user_registerParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_USER_REGISTER parameters:param success:success failure:failure];
}
//找回密码
+ (void)user_retrieveParam:(NSDictionary *)param
                   success:(void (^)(id obj, NSInteger code, NSString *mes))success
                   failure:(void (^)(ErrorType errorType, NSString *mes))failure {
    [XYNetworking postWithUrlString:API_USER_RETRIEVE parameters:param success:success failure:failure];
}
@end
