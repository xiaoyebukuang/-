//
//  BaseViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"
#import "XYErrorView.h"
@interface BaseViewController ()

@property (nonatomic, strong) UIView *errorView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_FFFFFF];
}
- (void)showErrorView:(void (^)(void))refreshBlock {
    if (self.errorView) {
        [self.errorView removeFromSuperview];
        self.errorView = nil;
    }
    WeakSelf;
    self.errorView = [[XYErrorView alloc]initWithBlock:^{
        [weakSelf.errorView removeFromSuperview];
        weakSelf.errorView = nil;
        refreshBlock();
    }];
    self.errorView.backgroundColor = [UIColor color_FFFFFF];
    [self.view addSubview:self.errorView];
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)dealloc {
    NSLog(@"release-------%@",[self class]);
}
@end
