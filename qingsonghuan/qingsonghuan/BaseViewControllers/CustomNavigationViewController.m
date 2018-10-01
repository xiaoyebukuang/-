//
//  CustomNavigationViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "CustomNavigationViewController.h"
@interface CustomNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation CustomNavigationViewController

- (void)viewDidLoad{
    self.delegate = self;
    self.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: SYSTEM_FONT_20,NSForegroundColorAttributeName: [UIColor color_FFFFFF]};
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *hidenControllers = @[@"LoginViewController",
                                  @"MineViewController"];
    if ([hidenControllers containsObject:NSStringFromClass(self.topViewController.class)]) {
        [self setNavigationBarHidden:YES animated:YES];
    } else {
        [self setNavigationBarHidden:NO animated:YES];
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count <= 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
