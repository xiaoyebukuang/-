//
//  AdviceTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdviceListModel.h"
@interface AdviceTableViewCell : UITableViewCell
- (void)reloadDataWithMailModel:(AdviceModel *)adviceModel;
@end
