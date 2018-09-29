//
//  MailListModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MailModel;
@interface MailListModel : NSObject
//当前页
@property (nonatomic, assign) NSInteger page;
//总页数
@property (nonatomic, assign) NSInteger countPage;
//总条数
@property (nonatomic, assign) NSInteger countNum;
//是否还有1有0没有
@property (nonatomic, assign) BOOL isContinue;
//数组
@property (nonatomic, strong) NSMutableArray <MailModel *> *listArr;

- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh;

@end

@interface MailModel : NSObject
//站内信id
@property (nonatomic, copy) NSString *letter_id;
//发送人id
@property (nonatomic, copy) NSString *send_uid;
//内容
@property (nonatomic, copy) NSString *content;
//是否已读 ( 1已读 0未读 )
@property (nonatomic, assign) BOOL is_read;
//发送时间 ( 时间戳 )
@property (nonatomic, assign) NSInteger add_time;
//发送时间
@property (nonatomic, copy) NSString *date;
//发送人登机证号
@property (nonatomic, copy) NSString *work_number;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
