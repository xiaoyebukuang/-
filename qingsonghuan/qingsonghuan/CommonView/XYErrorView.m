//
//  XYErrorView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYErrorView.h"

@interface XYErrorView ()

@property (nonatomic, strong) UIButton *refreshBtn;

@property (nonatomic ,copy) ErrorRefreshBlock refreshBlock;

@end

@implementation XYErrorView

- (instancetype)initWithBlock:(ErrorRefreshBlock)refreshBlock {
    self = [super init];
    if (self) {
        self.refreshBlock = refreshBlock;
        [self addSubview:self.refreshBtn];
        [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}
#pragma mark -- event
- (void)refreshBtnEvent:(UIButton *)btn {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

#pragma mark -- setup
- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithTitle:@"点击刷新" font:SYSTEM_FONT_17 titleColor:[UIColor color_000000:1]];
        [_refreshBtn addTarget:self action:@selector(refreshBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

@end
