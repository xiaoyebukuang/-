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

@interface MailFlightView : UIView

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, copy) NSString *title;

- (void)reloadWithModel:(FlightModel *)flightModel mailFlightViewBlock:(MailFlightViewBlock)mailFlightViewBlock;

@end
