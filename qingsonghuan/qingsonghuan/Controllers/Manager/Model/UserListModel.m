//
//  UserListModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserListModel.h"

@implementation UserListModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.page = 0;
        self.countNum = 0;
        self.countPage = 0;
        self.isContinue = NO;
        self.listArr = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh {
    self.page = [NSString safe_integer:dic[@"page"]];
    self.countNum = [NSString safe_integer:dic[@"countNum"]];
    self.countPage = [NSString safe_integer:dic[@"countPage"]];
    self.isContinue = [NSString safe_integer:dic[@"isContinue"]];
    if (refresh) {
        [self.listArr removeAllObjects];
    }
    if ([dic[@"list"] isKindOfClass:[NSArray class]]) {
        for (id temp in dic[@"list"]) {
            if ([temp isKindOfClass:[NSDictionary class]]) {
                ManagerUserModel *model = [[ManagerUserModel alloc]initWithDic:(NSDictionary *)temp];
                [self.listArr addObject:model];
            }
        }
    }
}
@end
@implementation ManagerUserModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.user_id =          [NSString safe_string:dic[@"user_id"]];
        self.work_number =      [NSString safe_string:dic[@"work_number"]];
        self.sex =              [NSString safe_string:dic[@"sex"]];
        self.airline_name =     [NSString safe_string:dic[@"airline_name"]];
        self.subsidiary_name =  [NSString safe_string:dic[@"subsidiary_name"]];
        self.duty_name =        [NSString safe_string:dic[@"duty_name"]];
        self.visa_name =        [NSString safe_string:dic[@"visa_name"]];
    }
    return self;
}
@end
