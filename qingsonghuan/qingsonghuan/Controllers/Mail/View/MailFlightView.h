//
//  MailFlightView.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightListModel.h"
typedef void(^MailFlightViewBlock)(void);

typedef void(^MailAddFlightViewBlock)(void);

@interface MailFlightView : UIView

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong)FlightModel *flightModel;

@property (nonatomic, copy) MailFlightViewBlock mailFlightViewBlock;

@property (nonatomic, copy) MailAddFlightViewBlock mailAddFlightViewBlock;

@property (nonatomic, assign) BOOL isEditFlight;

@end
