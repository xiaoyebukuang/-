//
//  RegisterModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterModel.h"
@implementation RegisterModel

- (NSString *)checkReg {
    NSString *des;
    if (![NSString validatePhoneNumber:self.phone]) {
        des = @"请填写完整的手机号";
    } else if (self.airlineModel == nil){
        des = @"请选择航空公司";
    } else if (self.subsidiaryModel == nil) {
        des = @"请选择所属分子公司";
    } else if (self.dutyModel == nil) {
        des = @"请选择职务等级";
    } else if (self.visaModel == nil) {
        des = @"请选择签证类型";
    } else if ([NSString isEmpty:self.work_number]) {
        des = @"请输入登记证号";
    } else if (self.sexModel == nil) {
        des = @"请选择性别";
    } else if ([NSString isEmpty: self.password]) {
        des = @"请输入密码";
    } else if ([NSString isEmpty: self.password_confirm]) {
        des = @"请再次输入密码";
    } else if (![self.password isEqualToString:self.password_confirm]) {
        des = @"密码和确认密码输入不一致";
    } else if ([NSString isEmpty: self.code]) {
        des = @"请输入验证码";
    }
    return des;
}
- (NSString *)checkFroget {
    NSString *des;
    if (![NSString validatePhoneNumber:self.phone]) {
        des = @"请填写完整的手机号";
    } else if ([NSString isEmpty: self.password]) {
        des = @"请输入密码";
    } else if ([NSString isEmpty: self.password_confirm]) {
        des = @"请再次输入密码";
    } else if (![self.password isEqualToString:self.password_confirm]) {
        des = @"密码和确认密码输入不一致";
    } else if ([NSString isEmpty: self.code]) {
        des = @"请输入验证码";
    }
    return des;
}
- (NSString *)checkLogin {
    NSString *des;
    if (![NSString validatePhoneNumber:self.phone]) {
        des = @"请填写完整的手机号";
    } else if ([NSString isEmpty: self.password]) {
        des = @"请输入密码";
    }
    return des;
}
@end
