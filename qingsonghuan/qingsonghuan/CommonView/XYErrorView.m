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

@property (nonatomic, strong) UIImageView *errorImageV;

@property (nonatomic, strong) UILabel *errorLabel;

@property (nonatomic ,copy) ErrorRefreshBlock refreshBlock;

@end

@implementation XYErrorView

- (instancetype)initWithBlock:(ErrorRefreshBlock)refreshBlock {
    self = [super init];
    if (self) {
        self.refreshBlock = refreshBlock;
        [self addSubview:self.errorImageV];
        [self.errorImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(100);
        }];
        
        [self addSubview:self.errorLabel];
        [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.errorImageV.mas_bottom).offset(40);
        }];
        
        [self addSubview:self.refreshBtn];
        [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.errorLabel.mas_bottom).offset(30);
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
        _refreshBtn = [UIButton buttonWithBGImage:@"error_btn_bg" title:@"刷新页面" font:SYSTEM_FONT_15 textColor:[UIColor color_FFFFFF]];
        [_refreshBtn addTarget:self action:@selector(refreshBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}
- (UIImageView *)errorImageV {
    if (!_errorImageV) {
        _errorImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error_logo"]];
    }
    return _errorImageV;
}
- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc]initWithText:@"加载失败，页面丢失" font:SYSTEM_FONT_15 textColor:[UIColor color_ABABAB]];
    }
    return _errorLabel;
}

@end
