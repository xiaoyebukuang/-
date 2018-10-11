//
//  FlightHeaderView.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlightHeaderViewBlock)(void);

@interface FlightHeaderView : UIView

@property (nonatomic, copy) FlightHeaderViewBlock flightHeaderBlock;

@property (nonatomic, assign) NSInteger tipNumber;

@end
