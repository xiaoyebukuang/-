//
//  RegisterModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterModel.h"
@implementation RegisterModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.phone = [NSString safe_string:dic[@"phone"]];
        SexModel *sexModel = [[SexModel alloc]init];
        NSInteger sex = [NSString safe_integer:dic[@"sex"]];
        if (sex == 0) {
            sexModel.sex_id = @"0";
            sexModel.sex_name = @"男";
        } else {
            sexModel.sex_id = @"1";
            sexModel.sex_name = @"女";
        }
        self.work_number = [NSString safe_string:dic[@"work_number"]];
        if ([dic[@"airline"] isKindOfClass:[NSDictionary class]]) {
            self.airlineModel = [[AirlineModel alloc]initWithDic:dic[@"airline"]];
        }
        if ([dic[@"subsidiary"] isKindOfClass:[NSDictionary class]]) {
            self.subsidiaryModel = [[SubsidiaryModel alloc]initWithDic:dic[@"subsidiary"]];
        }
        if ([dic[@"duty"] isKindOfClass:[NSDictionary class]]) {
            self.dutyModel = [[DutyModel alloc]initWithDic:dic[@"duty"]];
        }
        if ([dic[@"visa"] isKindOfClass:[NSDictionary class]]) {
            self.visaModel = [[VisaModel alloc]initWithDic:dic[@"visa"]];
        }
        //user_id    [string]    是    用户id    展开
//        //密码
//        @property (nonatomic, copy) NSString *password;
//        //确认密码
//        @property (nonatomic, copy) NSString *password_confirm;
//        //手机验证码
//        @property (nonatomic, copy) NSString *code;
//        //验证码Model
//        @property (nonatomic, strong) SendCodeModel *sendCodeModel;
    }
    return self;
}
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
