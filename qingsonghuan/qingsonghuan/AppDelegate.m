//
//  AppDelegate.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/17.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomNavigationViewController.h"
#import "LoginViewController.h"
#import "FlightListViewController.h"
#import "GuidePageViewController.h"
/** 公告 */
#import "NoticeListModel.h"
#import "NoticeDetailViewController.h"
/** 站内信 */
#import "MailListModel.h"
#import "MailReadViewController.h"
//三方键盘
#import <IQKeyboardManager.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //开启三方键盘关闭设置为NO, 默认值为NO.
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setRootViewControoler];
    [self.window makeKeyAndVisible];
    //分享
    [self setShare];
    //推送
    [self setPushWithOptions:launchOptions];
    //版本更新
    [self dataGetcfg];
    return YES;
}
/** 版本更新 */
- (void)dataGetcfg {
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [RequestPath data_getcfgParam:@{@"version":currentVersion} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        BOOL status = [NSString safe_bool:obj[@"status"]];
        if (!status) {
            [UIAlertViewTool showTitle:@"提示" message:@"请前去App Store 更新" titlesArr:@[@"确定"] alertBlock:^(NSString *mes, NSInteger index) {
                exit(1);
            }];
        }
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
- (void)setRootViewControoler {
    //保存的版本号
    NSString *onAVersion = [[NSUserDefaults standardUserDefaults] stringForKey:VERSION_NUMBER];
    //当前的版本号
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    if (![onAVersion isEqualToString:currentVersion]) {
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:VERSION_NUMBER];
        [[NSUserDefaults standardUserDefaults]synchronize];
        GuidePageViewController *guidePVC = [[GuidePageViewController alloc]init];
        self.window.rootViewController = guidePVC;
    } else if ([UserModel sharedInstance].isLogin) {
        FlightListViewController *flightLVC = [[FlightListViewController alloc]init];
        CustomNavigationViewController *nvc = [[CustomNavigationViewController alloc]initWithRootViewController:flightLVC];
        self.window.rootViewController = nvc;
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        CustomNavigationViewController *nvc = [[CustomNavigationViewController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nvc;
    }
}
- (void)setShare {
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = @"3c5d49272c65ca82245f7bcc";
    config.WeChatAppId = @"wx09a3fbca2cb1a0ac";
    config.WeChatAppSecret = @"544013c869141a48c6d1f31a5569f76f";;
    [JSHAREService setupWithConfig:config];
    [JSHAREService setDebug:YES];
}
- (void)setPushWithOptions:(NSDictionary *)launchOptions {
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"3c5d49272c65ca82245f7bcc"
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
}

#pragma mark -- 接受通知
- (void)getNotificationWithDic:(NSDictionary *)dic isShowAlert:(BOOL)isShow{
    NSData *jsonData = [[NSString safe_string:dic[@"key"]] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if ([tempDic[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *subDic = tempDic[@"data"];
        if ([subDic[@"alert"] isKindOfClass:[NSDictionary class]]) {
            NSInteger type = [NSString safe_integer:subDic[@"type"]];
            switch (type) {
                case 1:
                {
                    //站内信
                    MailModel *mailModel = [[MailModel alloc]initWithDic:subDic[@"alert"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MAIL_SEND object:nil];
                    if (isShow) {
                        [UIAlertViewTool showTitle:@"站内信" message:mailModel.content alertBlock:^(NSString *mes, NSInteger index) {
                            if (index == 1) {
                                MailReadViewController *mailReadVC = [[MailReadViewController alloc]init];
                                mailReadVC.letter_id = mailModel.letter_id;
                                CustomNavigationViewController *nv = (CustomNavigationViewController *)self.window.rootViewController;
                                [nv pushViewController:mailReadVC animated:YES];
                            }
                        }];
                    } else {
                        MailReadViewController *mailReadVC = [[MailReadViewController alloc]init];
                        mailReadVC.letter_id = mailModel.letter_id;
                        CustomNavigationViewController *nv = (CustomNavigationViewController *)self.window.rootViewController;
                        [nv pushViewController:mailReadVC animated:YES];
                    }
                }
                    break;
                case 2:
                {
                    //公告
                    NoticeModel *noticeModel = [[NoticeModel alloc]initWithDic:subDic[@"alert"]];
                    if (isShow) {
                        [UIAlertViewTool showTitle:noticeModel.title message:noticeModel.content alertBlock:^(NSString *mes, NSInteger index) {
                            if (index == 1) {
                                NoticeDetailViewController *noticeDetailVC = [[NoticeDetailViewController alloc]init];
                                noticeDetailVC.noticeModel = noticeModel;
                                CustomNavigationViewController *nv = (CustomNavigationViewController *)self.window.rootViewController;
                                [nv pushViewController:noticeDetailVC animated:YES];
                            }
                        }];
                    } else {
                        NoticeDetailViewController *noticeDetailVC = [[NoticeDetailViewController alloc]init];
                        noticeDetailVC.noticeModel = noticeModel;
                        CustomNavigationViewController *nv = (CustomNavigationViewController *)self.window.rootViewController;
                        [nv pushViewController:noticeDetailVC animated:YES];
                    }
                }
                    break;
                default:
                    break;
            }
        }
    }
}

/** 注册 APNs 成功并上报 DeviceToken */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
/** 实现注册 APNs 失败接口（可选）*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support 1111111
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self getNotificationWithDic:userInfo isShowAlert:YES];
    }
//    completionHandler(UNNotificationPresentationOptionAlert);
    // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Supportr 2222222
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self getNotificationWithDic:userInfo isShowAlert:NO];
    }
    completionHandler();  // 系统要求执行这个方法
}
//iOS7以上
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [self getNotificationWithDic:userInfo isShowAlert:YES];
    completionHandler(UIBackgroundFetchResultNewData);
}
//推送数目标签
- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 1;
    application.applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
}
/** 目前适用所有 iOS 系统 分享统计 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [JSHAREService handleOpenUrl:url];
    return YES;
}




@end
