//
//  WebViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"协议与条款";
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:API_USER_AGREEMENT]]];
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}

@end
