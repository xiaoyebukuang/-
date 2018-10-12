//
//  RegisterModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendCodeModel.h"
@interface RegisterModel : NSObject
//电话
@property (nonatomic, copy) NSString *phone;
//航空公司
@property (nonatomic, strong) AirlineModel *airlineModel;
//航空子公司
@property (nonatomic, strong) SubsidiaryModel *subsidiaryModel;
//职务等级
@property (nonatomic, strong) DutyModel *dutyModel;
//登机证号
@property (nonatomic, copy) NSString *work_number;
//性别
@property (nonatomic, strong) SexModel *sexModel;
//密码
@property (nonatomic, copy) NSString *password;
//确认密码
@property (nonatomic, copy) NSString *password_confirm;
//手机验证码
@property (nonatomic, copy) NSString *code;
//验证码Model
@property (nonatomic, strong) SendCodeModel *sendCodeModel;


- (instancetype)initWithDic:(NSDictionary *)dic;

- (NSString *)checkReg;
- (NSString *)checkFroget;
- (NSString *)checkLogin;

@end
