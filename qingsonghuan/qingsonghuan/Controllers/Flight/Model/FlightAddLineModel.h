//
//  FlightAddLineModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegNeedInfoModel.h"
@interface FlightAddLineModel : NSObject
//签到日期
@property (nonatomic, copy) NSString *date;
//签到日期时间戳
@property (nonatomic, assign) NSInteger sign_date;
//签到时间
@property (nonatomic, copy) NSString *sign_time;
//航班号
@property (nonatomic, copy) NSString *airline_number;
//航段信息
@property (nonatomic, copy) NSString *leg_info;
//签证信息
@property (nonatomic, strong) VisaModel *visaModel;
//字母标识
@property (nonatomic, strong) WordLogoModel *wordLogoModel;
//职位等级
@property (nonatomic, strong) DutyModel *dutyModel;
//留言
@property (nonatomic, copy) NSString *message;
//出差天数
@property (nonatomic, strong) DaysModel *daysModel;

@end
