//
//  MainReecordTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/1.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightListModel.h"
typedef void(^MainReecordEditBlock)(void);

typedef void(^MainReecordDeleteBlock)(void);

@interface MainReecordTableViewCell : UITableViewCell

- (void)reloadUIWithMolde:(FlightModel *)model mainReecordEditBlock:(MainReecordEditBlock)editBlock mainReecordDeleteBlock:(MainReecordDeleteBlock)deleteBlock;

@end
