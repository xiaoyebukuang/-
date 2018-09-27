//
//  XYPickerDateViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PickerDateBlock)(NSString *date, BOOL edit);

@interface XYPickerDateViewController : BaseViewController

@property (nonatomic, assign) UIDatePickerMode pickerMode;

- (void)reloadViewWithPickerDateBlock:(PickerDateBlock)pickerDateBlock;

@end
