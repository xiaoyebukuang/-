//
//  XYAlertViewTool.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYAlertViewTool.h"

@implementation XYAlertViewTool

+ (void)showFieldView:(void (^)(NSString *))alertBlock {
    
}

+ (UIView *)customView {
    UIView *custom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 130)];
    UILabel *label = [[UILabel alloc]initWithText:@"城市名称" font:SYSTEM_FONT_17 textColor:[UIColor color_666666]];
    [custom addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(custom);
        make.top.equalTo(custom).offset(20);
    }];
    
    XYTextField *textField = [[XYTextField alloc]initWithType:UITextFieldCity placeHolder:@"请输入城市名称"];
    [custom addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(custom);
        make.top.equalTo(label.mas_bottom).offset(25);
        make.height.mas_equalTo(30);
    }];
    return custom;
}

@end
