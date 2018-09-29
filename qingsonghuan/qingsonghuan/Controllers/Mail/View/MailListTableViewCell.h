//
//  MailListTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MailListModel.h"

@interface MailListTableViewCell : UITableViewCell

- (void)reloadDataWithMailModel:(MailModel *)mailModel;

@end
