//
//  FlightListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListViewController.h"

@interface FlightListViewController ()

@end

@implementation FlightListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"航班列表";
    [self setNavigationBar];
    
    
}
- (void)setNavigationBar {
    UIButton *leftBtn = [UIButton buttonWithImage:@"flight_menu"];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, leftButtonItem];
    
}

#pragma mark -- event
//个人中心菜单
- (void)leftNavigationBarEvent:(UIButton *)sender {
    
}
@end
