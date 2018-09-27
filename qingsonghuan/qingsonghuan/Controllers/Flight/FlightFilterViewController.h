//
//  FlightFilterViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"
#import "FlightFilterModel.h"
typedef void(^DismissBlock)(void);

typedef void(^FlilterSelectBlock)(FlightFilterModel *filterModel);

@interface FlightFilterViewController : BaseViewController

- (instancetype)initWithFilterModel:(FlightFilterModel *)filterModel flilterSelectBlock:(FlilterSelectBlock)flilterSelectBlock;

- (void)show;

- (void)dismiss:(DismissBlock)block;

@end
