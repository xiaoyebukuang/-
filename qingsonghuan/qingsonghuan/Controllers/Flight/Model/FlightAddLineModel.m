//
//  FlightAddLineModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightAddLineModel.h"

@implementation FlightAddLineModel


- (NSString *)checkAddLine {
    NSString *des;
    if ([NSString isEmpty:self.date]) {
        des = @"请选择签到日期";
    } else if ([NSString isEmpty:self.sign_time]) {
        des = @"请选择签到时间";
    } else if ([NSString isEmpty:self.airline_number]) {
        des = @"请选择航班号";
    } else if (self.daysModel == nil) {
        des = @"请选择出差天数";
    } else if (self.leg_info.count == 0) {
        des = @"请输入航段信息";
    } else if (self.visaModel == nil) {
        des = @"请选择签证信息";
    } else if (self.wordLogoModel == nil) {
        des = @"请选择字母标识";
    } else if (self.dutyModel == nil) {
        des = @"请选择职位等级";
    }
    return des;
}

@end
