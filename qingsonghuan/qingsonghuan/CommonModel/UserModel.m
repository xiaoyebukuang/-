//
//  UserModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserModel.h"
#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
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
/** 签名 */
- (void)setPhone:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults]setObject:phone forKey:USER_PHONE];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (NSString *)phone{
    NSString* phone = [[NSUserDefaults standardUserDefaults]stringForKey:USER_PHONE];
    return [NSString safe_string:phone];
}
/** 管理员权限 */
- (void)setIdentity:(NSInteger)identity {
    [[NSUserDefaults standardUserDefaults]setInteger:identity forKey:USER_IDENTITY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (NSInteger)identity {
    NSInteger identity = [[NSUserDefaults standardUserDefaults]integerForKey:USER_IDENTITY];
    return identity;
}

- (void)reloadWithDic:(NSDictionary *)dic {
    self.isLogin = YES;
    self.identity = [NSString safe_integer:dic[@"identity"]];
    self.userId =   [NSString safe_string:dic[@"userId"]];
    self.sign =     [NSString safe_string:dic[@"sign"]];
    self.phone  =   [NSString safe_string:dic[@"phone"]];
    NSString *tags = [NSString safe_string:dic[@"tags"]];
    NSArray *tagsArr = [tags componentsSeparatedByString:@","];
    NSSet *setArr = [NSSet setWithArray:tagsArr];
    [JPUSHService setTags:setArr completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
    } seq:1];
    [JPUSHService setAlias:self.userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:1];
    [kApplicationDelegate setRootViewControoler];
}

- (void)signOut {
    self.isLogin = NO;
    self.identity = 1;
    self.userId =   @"";
    self.sign =     @"";
    self.phone =    @"";
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
    } seq:1];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:1];
    [kApplicationDelegate setRootViewControoler];
}
@end
