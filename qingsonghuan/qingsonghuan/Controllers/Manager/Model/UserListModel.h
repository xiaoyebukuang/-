//
//  UserListModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserListModel : NSObject
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

@interface ManagerUserModel : NSObject
//用户id
@property (nonatomic, copy) NSString *user_id;
//用户手机号
@property (nonatomic, copy) NSString *phone;
//登机证号
@property (nonatomic, copy) NSString *work_number;
//性别
@property (nonatomic, copy) NSString *sex;
//航空公司
@property (nonatomic, copy) NSString *airline_name;
//分子公司
@property (nonatomic, copy) NSString *subsidiary_name;
//职务等级
@property (nonatomic, copy) NSString *duty_name;
//状态    0正常，1禁用
@property (nonatomic, assign) BOOL status;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

