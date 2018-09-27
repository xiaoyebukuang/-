//
//  XYPickerHeaderView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPickerHeaderView.h"

@interface XYPickerHeaderView()

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIButton *cancleBtn;

@property (nonatomic, copy) PickerHeaderBlock sureBlock;

@property (nonatomic, copy) PickerHeaderBlock cancleBlock;

@end

@implementation XYPickerHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor color_99D3F8];
        //确定按钮
        [self addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-15);
        }];
        //取消按钮
        [self addSubview:self.cancleBtn];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        XYLineView *line = [[XYLineView alloc]init];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}
- (void)setSureBlock:(PickerHeaderBlock)sureBlock cancleBlock:(PickerHeaderBlock)cancleBlock {
    self.sureBlock = sureBlock;
    self.cancleBlock = cancleBlock;
}
//确定按钮事件
- (void)sureBtnEvent:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock();
    }
}
//取消按钮事件
- (void)cancelBtnEvent:(UIButton *)sender {
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}
#pragma mark -- setup
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithTitle:@"确定" font:SYSTEM_FONT_15 titleColor:[UIColor color_FFFFFF]];
        [_sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithTitle:@"取消" font:SYSTEM_FONT_15 titleColor:[UIColor color_FFFFFF]];
        [_cancleBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

@end
