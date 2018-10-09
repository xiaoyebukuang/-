//
//  UserListScreenModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/9.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserListScreenModel.h"

@implementation UserListScreenModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.user_phone = @"";
        self.work_number = @"";
    }
    return self;
}

@end
