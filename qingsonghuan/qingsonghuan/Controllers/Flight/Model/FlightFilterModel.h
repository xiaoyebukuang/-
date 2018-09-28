//
//  FlightFilterModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegNeedInfoModel.h"
@interface FlightFilterModel : NSObject

//签到日期
@property (nonatomic, copy) NSString *sign_date;
//航班号
@property (nonatomic, copy) NSString *airLine;
//签到时段
@property (nonatomic, strong) SignModel *signModel;
//签证类型
@property (nonatomic, strong) VisaModel *visaModel;
//字母标识
@property (nonatomic, strong) WordLogoModel *wordLogoModel;
//职务等级
@property (nonatomic, strong) DutyModel *dutyModel;

- (instancetype)initWithModel:(FlightFilterModel *)filterModel;

@end
