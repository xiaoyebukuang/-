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

- (void)reloadWithDic:(NSDictionary *)dic {
    self.isLogin = YES;
    [kApplicationDelegate setRootViewControoler];
}
@end
