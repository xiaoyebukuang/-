//
//  UserModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/**
 获取单例

 @return 返回单例
 */
+ (UserModel *)sharedInstance;


/**
 刷新登录信息

 @param dic 登录dic
 */
- (void)reloadWithDic:(NSDictionary *)dic;

/** 是否登录 */
@property (nonatomic, assign) BOOL isLogin;
/** 用户id */
@property (nonatomic, copy) NSString *userId;
/** 签名 */
@property (nonatomic, copy) NSString *sign;
/** 电话 */
@property (nonatomic, copy) NSString *phone;
/** 管理员权限 */
@property (nonatomic, assign) NSInteger identity;

- (void)signOut;
@end
