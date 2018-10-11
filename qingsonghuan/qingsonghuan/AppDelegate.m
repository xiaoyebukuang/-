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
//三方键盘
#import <IQKeyboardManager.h>
@interface AppDelegate ()

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
    return YES;
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
