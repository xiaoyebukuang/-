//
//  ManagerCommonModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ManagerCommonModel.h"

@implementation ManagerCommonModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.airline_id =   [NSString safe_string:dic[@"airline_id"]];
        self.airline_name = [NSString safe_string:dic[@"airline_name"]];
        self.child = [[NSMutableArray alloc]init];
        if ([dic[@"child"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *subDic in dic[@"child"]) {
                ManagerCommonChildModel *model = [[ManagerCommonChildModel alloc]initWithDic:subDic];
                [self.child addObject:model];
            }
        }
    }
    return self;
}

@end
@implementation ManagerCommonChildModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.count =            [NSString safe_string:dic[@"count"]];
        self.subsidiary_name =  [NSString safe_string:dic[@"subsidiary_name"]];
    }
    return self;
}

@end
