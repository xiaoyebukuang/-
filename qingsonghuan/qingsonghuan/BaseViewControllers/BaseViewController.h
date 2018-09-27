//
//  BaseViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIView+Helper.h"

@interface BaseViewController : UIViewController

- (void)showErrorView:(void (^)(void))refreshBlock;

@end
