//
//  AdviceListModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AdviceListModel.h"

@implementation AdviceListModel
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
                AdviceModel *model = [[AdviceModel alloc]initWithDic:(NSDictionary *)temp];
                [self.listArr addObject:model];
            }
        }
    }
}
@end

@implementation AdviceModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.advice_id =     [NSString safe_string:dic[@"id"]];
        self.advice_info =   [NSString safe_string:dic[@"advice_info"]];
        self.phone =         [NSString safe_string:dic[@"phone"]];
        self.time =         [NSString safe_integer:dic[@"time"]];
        self.timeStr = [NSDate getDateStringWithDateStaple:self.time formatType:FormatyyyyMdHm];
    }
    return self;
}

@end
