//
//  SendCodeModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendCodeModel : NSObject

//发送的手机号
@property (nonatomic, copy) NSString *phone;
//标识符 ( 提交数据时传给服务端 )
@property (nonatomic, copy) NSString *iden;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
