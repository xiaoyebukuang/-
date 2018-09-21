//
//  BaseMultiViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

@interface BaseMultiViewController ()

@end

@implementation BaseMultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLeftBarBtnItem];
}
- (void)setUpLeftBarBtnItem {
    UIButton *btn = [UIButton buttonWithImage:@"back"];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(backVC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, leftButtonItem];
}
- (void)backVC:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
