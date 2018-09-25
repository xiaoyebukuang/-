//
//  SendCodeModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "SendCodeModel.h"

@implementation SendCodeModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.phone = [NSString safe_string:dic[@"phone"]];
        self.iden =  [NSString safe_string:dic[@"iden"]];
    }
    return self;
}
@end
