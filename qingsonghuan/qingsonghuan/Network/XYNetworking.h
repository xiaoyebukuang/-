//
//  XYNetworking.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/24.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ErrorType) {
    ErrorTypeNoNetwork,         //没有网络
    ErrorTypeReqestNone,        //没有数据
    ErrorTypeRequestFailed      //请求失败
};

@interface XYNetworking : NSObject

/**
 post请求(url)
 
 @param urlString 请求地址
 @param success 成功
 @param failure 失败
 */
+ (void)postWithUrlString:(NSString *)urlString
                  success:(void (^)(id, NSInteger, NSString *))success
                  failure:(void (^)(ErrorType, NSString *))failure;

/**
 post请求(url+参数)

 @param urlString 请求地址
 @param parameters 请求参数
 @param success 成功
 @param failure 失败
 */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                  success:(void (^)(id, NSInteger, NSString *))success
                  failure:(void (^)(ErrorType, NSString *))failure;


/**
 post请求（url+参数+清除）
 
 @param urlString 请求地址
 @param parameters 请求参数
 @param cancle 是否清除请求
 @param success 成功
 @param failure 失败
 */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
                  success:(void (^)(id, NSInteger, NSString *))success
                  failure:(void (^)(ErrorType, NSString *))failure;


/**
 清除所有请求
 */
+ (void)cancelAllTask;
@end
