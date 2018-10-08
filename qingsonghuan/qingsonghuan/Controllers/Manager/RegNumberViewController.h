//
//  RegNumberViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"


typedef NS_ENUM(NSInteger, ManagerType) {
    ManagerTypeUser,         //注册人数统计
    ManagerTypeFlight,       //航班上传统计
    ManagerTypeLetter        //站内信统计
};

@interface RegNumberViewController : BaseMultiViewController

@property (nonatomic, assign) ManagerType type;

@end
