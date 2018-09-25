//
//  RequestPath.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RequestPath.h"

@implementation RequestPath

+ (void)user_regNeedInfoSuccess:(void (^)(id, NSInteger, NSString *))success
                        failure:(void (^)(ErrorType, NSString *))failure {
    [XYNetworking postWithUrlString:API_USER_REGNEEDINFO success:success failure:failure];
}

+ (void)user_sendCodeParam:(NSDictionary *)param
                   success:(void (^)(id, NSInteger, NSString *))success
                   failure:(void (^)(ErrorType, NSString *))failure {
    [XYNetworking postWithUrlString:API_USER_SENDCODE parameters:param success:success failure:failure];
}

+ (void)user_registerParam:(NSDictionary *)param
                   success:(void (^)(id, NSInteger, NSString *))success
                   failure:(void (^)(ErrorType, NSString *))failure {
    [XYNetworking postWithUrlString:API_USER_REGISTER parameters:param success:success failure:failure];
}

@end
