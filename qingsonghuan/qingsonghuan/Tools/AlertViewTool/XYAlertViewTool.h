//
//  XYAlertViewTool.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAlertViewTool : NSObject

+ (void)showFieldView:(void(^)(NSString *content))alertBlock;

@end
