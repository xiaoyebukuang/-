//
//  XYPickerHeaderView.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerHeaderBlock)(void);

@interface XYPickerHeaderView : UIView

- (void)setSureBlock:(PickerHeaderBlock)sureBlock cancleBlock:(PickerHeaderBlock)cancleBlock;


@end
