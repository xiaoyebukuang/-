//
//  FlightListModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FlightModel;
@interface FlightListModel : NSObject
//当前页
@property (nonatomic, assign) NSInteger page;
//总页数
@property (nonatomic, assign) NSInteger countPage;
//总条数
@property (nonatomic, assign) NSInteger countNum;
//是否还有1有0没有
@property (nonatomic, assign) BOOL isContinue;
//数组
@property (nonatomic, strong) NSMutableArray <FlightModel *> *listArr;

- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh;

@end

@interface FlightModel: NSObject
//航班id
@property (nonatomic, copy) NSString *flight_id;
//签到日期时间戳
@property (nonatomic, assign) NSInteger sign_date;
//签到日期
@property (nonatomic, copy) NSString *date;
//签到时间12:00:00
@property (nonatomic, copy) NSString *sign_time;
//airline_number
@property (nonatomic, copy) NSString *airline_number;
//航段信息[郑州，上海，南京]
@property (nonatomic, strong) NSArray *leg_info;
//字母标识
@property (nonatomic, strong) WordLogoModel *wordLogoModel;
//留言
@property (nonatomic, copy) NSString *message;
//出差天数
@property (nonatomic, strong) DaysModel *daysModel;
//用户id
@property (nonatomic, copy) NSString *user_id;
//签证
@property (nonatomic, strong) VisaModel *visaModel;
//职务等级
@property (nonatomic, strong) DutyModel *dutyModel;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
