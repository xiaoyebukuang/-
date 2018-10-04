//
//  AdviceListModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdviceListModel : NSObject
//当前页
@property (nonatomic, assign) NSInteger page;
//总页数
@property (nonatomic, assign) NSInteger countPage;
//总条数
@property (nonatomic, assign) NSInteger countNum;
//是否还有1有0没有
@property (nonatomic, assign) BOOL isContinue;
//数组
@property (nonatomic, strong) NSMutableArray *listArr;

- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh;

@end

@interface AdviceModel : NSObject

//意见id
@property (nonatomic, copy) NSString *advice_id;
//意见内容
@property (nonatomic, copy) NSString *advice_info;
//电话
@property (nonatomic, copy) NSString *phone;
//发送时间 ( 时间戳 )
@property (nonatomic, assign) NSInteger time;
//发送时间
@property (nonatomic, copy) NSString *timeStr;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
