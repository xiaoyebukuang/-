//
//  XYNetworking.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/24.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYNetworking.h"
#import "AFNetworking.h"

static XYNetworking *_networking = nil;
static NSTimeInterval const timeInterval = 20.0;


@interface XYNetworking()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *tasks;


@end


@implementation XYNetworking

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _networking = [[self alloc] init] ;
        _networking.manager = [[AFHTTPSessionManager alloc]init];
        _networking.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/JavaScript",@"text/plain",@"text/html",nil];
        _networking.manager.requestSerializer.timeoutInterval = timeInterval;
        _networking.tasks = [[NSMutableArray alloc]init];
    }) ;
    
    return _networking ;
}


/**
 post请求
 
 @param urlString 请求地址
 @param success 成功
 @param failure 失败
 */
+ (void)postWithUrlString:(NSString *)urlString
                  success:(void (^)(id, NSInteger, NSString *))success
                  failure:(void (^)(ErrorType, NSString *))failure {
    [self postWithUrlString:urlString parameters:nil success:success failure:failure];
}

/**
 post请求
 
 @param urlString 请求地址
 @param parameters 请求参数
 @param success 成功
 @param failure 失败
 */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                  success:(void (^)(id, NSInteger, NSString *))success
                  failure:(void (^)(ErrorType, NSString *))failure {
    [self postWithUrlString:urlString parameters:parameters cancel:YES success:success failure:failure];
}


/**
 post请求
 
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
                  failure:(void (^)(ErrorType, NSString *))failure {
    
    XYNetworking *network = [self shareInstance];
    NSError *error;
    NSMutableURLRequest *request = [network.manager.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:parameters error:&error];
    request = [self setHeaderField:request];
    NSURLSessionDataTask *dataTask = [network.manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"-----------------------------------");
        NSLog(@"responseObject = %@",responseObject);
        NSLog(@"parameters = %@",parameters);
        NSLog(@"urlString = %@",urlString);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"status"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *status = responseObject[@"status"];
                if ([NSString safe_integer:status[@"code"]] == 1) {
                    //请求成功
                    success(responseObject[@"data"],[NSString safe_integer:status[@"code"]],status[@"mes"]);
                } else if ([NSString safe_integer:status[@"code"]] == 6000) {
                    [[UserModel sharedInstance]signOut];
                    [MBProgressHUD showError:status[@"mes"]];
                } else {
                    failure(ErrorTypeRequestFailed, status[@"mes"]);
                }
            } else {
                failure(ErrorTypeRequestFailed, API_REUQEST_FAILED);
            }
        } else {
            failure(ErrorTypeRequestFailed, API_REUQEST_FAILED);
        }
    }];
    [dataTask resume];
    if (cancle) {
        [network.tasks addObject:dataTask];
    }
}

+ (NSMutableURLRequest *)setHeaderField:(NSMutableURLRequest *)request {
    UserModel *model = [UserModel sharedInstance];
    [request setValue:model.userId forHTTPHeaderField:@"USERID"];
    [request setValue:model.sign forHTTPHeaderField:@"SIGN"];
    [request setValue:[NSString stringWithFormat:@"%f",[NSDate getDateStample:[NSDate date]]] forHTTPHeaderField:@"TIME"];
    return request;
}

+ (void)cancelAllTask {
    XYNetworking *network = [self shareInstance];
    for (NSURLSessionDataTask *task in network.tasks) {
        [task cancel];
    }
}

@end
