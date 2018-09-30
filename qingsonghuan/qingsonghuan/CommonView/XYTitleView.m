//
//  XYTitleView.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYTitleView.h"

@implementation XYTitleView

- (void)reloadUIWithTitleArr:(NSArray *)titleArr {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat width = MAIN_SCREEN_WIDTH/titleArr.count;
    for (int i = 0; i < titleArr.count; i ++) {
        UILabel *title = [[UILabel alloc]initWithText:titleArr[i] font:SYSTEM_FONT_13 textColor:[UIColor color_666666]];
        title.textAlignment = NSTextAlignmentCenter;
        title.adjustsFontSizeToFitWidth = YES;
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(i*width);
            make.width.mas_equalTo(width);
        }];
    }
}

@end
