//
//  UserListScreenViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/9.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"
#import "UserListScreenModel.h"
typedef void(^UserListScreenBlock)(UserListScreenModel *userListScreenModel);

@interface UserListScreenViewController : BaseMultiViewController

- (instancetype)initWithUserListScreenModel:(UserListScreenModel *)userListScreenModel userListScreenBlock:(UserListScreenBlock)userListScreenBlock;

- (void)show;

- (void)dismiss;
@end

