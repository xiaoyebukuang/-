//
//  NoticeListModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NoticeListModel.h"

@implementation NoticeListModel
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
                NoticeModel *model = [[NoticeModel alloc]initWithDic:(NSDictionary *)temp];
                [self.listArr addObject:model];
            }
        }
    }
}
@end


@implementation NoticeModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.announcement_id =  [NSString safe_string:dic[@"announcement_id"]];
        self.title =            [NSString safe_string:dic[@"title"]];
        self.content =          [NSString safe_string:dic[@"content"]];
        self.time =             [NSString safe_integer:dic[@"time"]];
        self.timeStr =          [NSDate getDateStringWithDateStaple:self.time formatType:FormatyyyyMdHm];
    }
    return self;
}
@end



