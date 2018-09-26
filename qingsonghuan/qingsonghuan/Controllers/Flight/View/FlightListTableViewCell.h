//
//  FlightListTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlightMailBlcok)(void);

@interface FlightListTableViewCell : UITableViewCell

- (void)reloadViewWithModel:(NSString *)model index:(NSInteger)index flightMailBlcok:(FlightMailBlcok)flightMailBlcok;

@end
