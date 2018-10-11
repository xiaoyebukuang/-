//
//  FlightFilterModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FlightFilterModel : NSObject

//时间
@property (nonatomic, strong) NSDate *sign_date;
//签到日期str (2018-11-12)
@property (nonatomic, copy) NSString *sign_date_str;
//时间戳
@property (nonatomic, assign) NSInteger sign_date_stample;
//航班号码
@property (nonatomic, copy) NSString *airline_number;
//签到时段
@property (nonatomic, strong) SignModel *signModel;
//签证类型
@property (nonatomic, strong) VisaModel *visaModel;
//字母标识
@property (nonatomic, strong) WordLogoModel *wordLogoModel;
//职务等级
@property (nonatomic, strong) DutyModel *dutyModel;
//始发航班
@property (nonatomic, copy)NSString *first_leg;

- (instancetype)initWithModel:(FlightFilterModel *)filterModel;

@end
