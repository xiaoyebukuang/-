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
        if ([dic isKindOfClass:[NSArray class]]) {
            self.leg_info       = dic[@"leg_info"];
        }
        self.wordLogoModel  = [[WordLogoModel alloc]initWithDic:dic[@"word_logo"]];
        self.message        = [NSString safe_string:dic[@"message"]];
        self.daysModel      = [[DaysModel alloc]initWithDic:dic[@"days"]];
        self.user_id        = [NSString safe_string:dic[@"user_id"]];
        self.visaModel      = [[VisaModel alloc]initWithDic:dic[@"visa"]];
        self.dutyModel      = [[DutyModel alloc]initWithDic:dic[@"duty"]];
        self.user_id        = [NSString safe_string:dic[@"phone"]];
        NSString *days = @"";
        if (self.daysModel.days_id != 1) {
            days = [NSString stringWithFormat:@"(%@)",self.daysModel.days_name];
        }
        self.number_days = [NSString stringWithFormat:@"%@%@",self.airline_number,days];
    }
    return self;
}

@end
