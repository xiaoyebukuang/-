//
//  FlightListModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListModel.h"

@implementation FlightListModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.page = 0;
        self.countNum = 0;
        self.countPage = 0;
        self.isContinue = NO;
        self.listArr = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh {
    self.page = [NSString safe_integer:dic[@"page"]];
    self.countNum = [NSString safe_integer:dic[@"countNum"]];
    self.countPage = [NSString safe_integer:dic[@"countPage"]];
    self.isContinue = [NSString safe_integer:dic[@"isContinue"]];
    if (refresh) {
        [self.listArr removeAllObjects];
    }
    if ([dic[@"list"] isKindOfClass:[NSArray class]]) {
        for (id temp in dic[@"list"]) {
            if ([temp isKindOfClass:[NSDictionary class]]) {
                FlightModel *model = [[FlightModel alloc]initWithDic:(NSDictionary *)temp];
                [self.listArr addObject:model];
            }
        }
    }
}
@end

@implementation FlightModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.flight_id      = [NSString safe_string:dic[@"flight_id"]];
        self.sign_date      = [NSString safe_integer:dic[@"sign_date"]];
        self.date           = [NSDate getDateStringWithDateStaple:self.sign_date formatType:FormatMd];
        self.sign_time      = [NSString safe_string:dic[@"sign_time"]];
        self.airline_number = [NSString safe_string:dic[@"airline_number"]];
        if ([dic[@"leg_info"] isKindOfClass:[NSArray class]]) {
            self.leg_info   = [NSArray arrayWithArray:dic[@"leg_info"]];
        }
        self.wordLogoModel  = [[WordLogoModel alloc]initWithDic:dic[@"word_logo"]];
        self.message        = [NSString safe_string:dic[@"message"]];
        self.daysModel      = [[DaysModel alloc]initWithDic:dic[@"days"]];
        self.user_id        = [NSString safe_string:dic[@"user_id"]];
        self.visaModel      = [[VisaModel alloc]initWithDic:dic[@"visa"]];
        self.dutyModel      = [[DutyModel alloc]initWithDic:dic[@"duty"]];
        self.phone          = [NSString safe_string:dic[@"phone"]];
        NSString *days = @"";
        if (self.daysModel.days_id != 1) {
            days = [NSString stringWithFormat:@"(%@)",self.daysModel.days_name];
        }
        self.number_days = [NSString stringWithFormat:@"%@%@",self.airline_number,days];
    }
    return self;
}
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
