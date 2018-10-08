//
//  NoticeTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeListModel.h"
@interface NoticeTableViewCell : UITableViewCell
- (void)reloadDataWithNoticeModel:(NoticeModel *)noticeModel;
@end
