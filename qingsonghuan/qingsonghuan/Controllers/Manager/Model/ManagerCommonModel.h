//
//  ManagerCommonModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerCommonModel : NSObject
//航空公司id
@property (nonatomic, copy) NSString *airline_id;
//航空公司名称
@property (nonatomic, copy) NSString *airline_name;
//子数组
@property (nonatomic, strong) NSMutableArray *child;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface ManagerCommonChildModel : NSObject
//总数
@property (nonatomic, copy) NSString *count;
//分公司名称
@property (nonatomic, copy) NSString *subsidiary_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
