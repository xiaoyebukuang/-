//
//  MailWriteViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailWriteViewController.h"
#import "XYTextView.h"

@interface MailWriteViewController ()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) XYTextView *textView;
@end

@implementation MailWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写站内信";
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.height.mas_equalTo(220);
    }];
}
#pragma mark -- setup

- (UIView *)headerView {
    if (!_headerView) {
        UIView *view = [[UIView alloc]init];
        [view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(CELL_LEFT_APACE);
            make.top.equalTo(view).offset(CELL_LEFT_APACE);
            make.right.equalTo(view).offset(-CELL_LEFT_APACE);
            make.bottom.equalTo(view).offset(-CELL_LEFT_APACE);
        }];
        XYLineView *lineView = [[XYLineView alloc]init];
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(view);
            make.height.mas_equalTo(1);
        }];
        _headerView= view;
    }
    return _headerView;
}

- (XYTextView *)textView {
    if (!_textView) {
        _textView = [[XYTextView alloc]init];
        _textView.placeHolder = @"请输入内容";
    }
    return _textView;
}
@end
