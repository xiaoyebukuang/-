//
//  FlightFilterModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightFilterModel.h"

@implementation FlightFilterModel

- (instancetype)initWithModel:(FlightFilterModel *)filterModel {
    self = [super init];
    if (self) {
        self.sign_date = filterModel.sign_date;
        self.airline_number = filterModel.airline_number;
        self.signModel = filterModel.signModel;
        self.visaModel = filterModel.visaModel;
        self.wordLogoModel = filterModel.wordLogoModel;
        self.dutyModel = filterModel.dutyModel;
        self.first_leg = filterModel.first_leg;
    }
    return self;
}
- (void)setSign_date:(NSDate *)sign_date {
    self.sign_date_str = [NSDate getDateString:sign_date formatType:FormatyyyyMd];
    _sign_date = [NSDate getDate:self.sign_date_str formatType:FormatyyyyMd];
    self.sign_date_stample = [NSDate getDateStample:_sign_date];
}
@end
