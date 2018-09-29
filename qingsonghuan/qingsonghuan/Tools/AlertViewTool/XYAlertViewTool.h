//
//  XYAlertViewTool.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^AlertBlock)(NSString *obj, BOOL sure);

@interface XYAlertViewTool : UIView

+ (void)showFieldView:(AlertBlock)alertBlock;


@end
