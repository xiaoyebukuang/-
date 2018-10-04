//
//  UserListTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"
typedef void(^UserListCancelBlock)(void);

typedef void(^UserListDeleteBlock)(void);

@interface UserListTableViewCell : UITableViewCell

- (void)reloadUIWithMolde:(ManagerUserModel *)model userListCancelBlock:(UserListCancelBlock)cancelBlock userListDeleteBlock:(UserListDeleteBlock)deleteBlock;
@end
