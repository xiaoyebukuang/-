//
//  ManagerCommonTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerCommonModel.h"
@interface ManagerCommonTableViewCell : UITableViewCell

- (void)reloadViewWithModel:(ManagerCommonModel *)commonModel;

@end
