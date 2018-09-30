//
//  MailReadModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightListModel.h"
@interface MailReadModel : NSObject
//发送人登机证号
@property (nonatomic, copy) NSString *work_number;
//内容
@property (nonatomic, copy) NSString *content;
//发送时间 ( 时间戳 )
@property (nonatomic, assign) NSInteger add_time;
//发送时间
@property (nonatomic, copy) NSString *add_time_str;
//发件人Model
@property (nonatomic, strong)FlightModel *sendModel;
//收件人Model
@property (nonatomic, strong)FlightModel *receiveModel;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
