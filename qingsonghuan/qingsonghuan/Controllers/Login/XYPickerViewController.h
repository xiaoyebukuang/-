//
//  XYPickerViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PickerBlock)(id);

@interface XYPickerViewController : BaseViewController


/**
 刷新选择器

 @param list 选择列表
 @param model 选中的model
 @param pickerBlock 回调
 */

- (void)reloadViewWithArr:(NSArray *)list selectModel:(id)model pickerBlock:(PickerBlock)pickerBlock;

@end
