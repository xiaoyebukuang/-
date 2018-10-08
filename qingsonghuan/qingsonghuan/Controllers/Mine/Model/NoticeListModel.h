//
//  NoticeListModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeListModel : NSObject
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


@interface NoticeModel : NSObject

//意见id
@property (nonatomic, copy) NSString *announcement_id;
//标题
@property (nonatomic, copy) NSString *title;
//内容
@property (nonatomic, copy) NSString *content;
//发送时间 ( 时间戳 )
@property (nonatomic, assign) NSInteger time;
//发送时间
@property (nonatomic, copy) NSString *timeStr;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
