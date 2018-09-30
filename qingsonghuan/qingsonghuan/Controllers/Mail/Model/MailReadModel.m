//
//  MailReadModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailReadModel.h"

@implementation MailReadModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.work_number = [NSString safe_string:dic[@"work_number"]];
        self.content = [NSString safe_string:dic[@"content"]];
        self.add_time = [NSString safe_integer:dic[@"add_time"]];
        self.add_time_str = [NSDate getDateStringWithDateStaple:self.add_time formatType:FormatyyyyMdHm];
        self.sendModel = [[FlightModel alloc]initWithDic:dic[@"send"]];
        self.receiveModel = [[FlightModel alloc]initWithDic:dic[@"receive"]];
    }
    return self;
}

@end
