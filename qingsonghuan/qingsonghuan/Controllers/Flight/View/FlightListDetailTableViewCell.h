//
//  FlightListDetailTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightListDetailTableViewCell : UITableViewCell
- (void)reloadViewWithIndex:(NSInteger)index title:(NSString *)title content:(NSString *)content;
@end
