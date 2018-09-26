//
//  UserModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserModel.h"
#import "AppDelegate.h"
@implementation UserModel
+ (UserModel *)sharedInstance {
    static UserModel *instance;
    UserModel *strongInstance = instance;
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[[self class] alloc] init];
            instance = strongInstance;
        }
    }
    return strongInstance;
}
/** 是否登录 */
- (void)setIsLogin:(BOOL)isLogin {
    [[NSUserDefaults standardUserDefaults]setBool:isLogin forKey:USER_IS_LOGIN];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (BOOL)isLogin {
    BOOL login = [[NSUserDefaults standardUserDefaults]boolForKey:USER_IS_LOGIN];
    return login;
}
/** 用户ID */
- (void)setUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults]setObject:userId forKey:USER_USERID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (NSString *)userId{
    NSString* userId = [[NSUserDefaults standardUserDefaults]stringForKey:USER_USERID];
    return [NSString safe_string:userId];
}
/** 签名 */
- (void)setSign:(NSString *)sign {
    [[NSUserDefaults standardUserDefaults]setObject:sign forKey:USER_SIGN];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (NSString *)sign{
    NSString* sign = [[NSUserDefaults standardUserDefaults]stringForKey:USER_SIGN];
    return [NSString safe_string:sign];
}


- (void)reloadWithDic:(NSDictionary *)dic {
    self.isLogin = YES;
    self.userId =   [NSString safe_string:dic[@"userId"]];
    self.sign =     [NSString safe_string:dic[@"sign"]];
    [kApplicationDelegate setRootViewControoler];
}
@end
