//
//  MailListModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailListModel.h"

@implementation MailListModel
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
                MailModel *model = [[MailModel alloc]initWithDic:(NSDictionary *)temp];
                [self.listArr addObject:model];
            }
        }
    }
}
@end

@implementation MailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.letter_id = [NSString safe_string:dic[@"letter_id"]];
        self.send_uid = [NSString safe_string:dic[@"send_uid"]];
        self.content = [NSString safe_string:dic[@"content"]];
        self.is_read = [NSString safe_bool:dic[@"is_read"]];
        self.add_time = [NSString safe_integer:dic[@"add_time"]];
        self.date = [NSDate getDateStringWithDateStaple:self.add_time formatType:FormatMd];
        self.work_number = [NSString safe_string:dic[@"work_number"]];
    }
    return self;
}

@end
