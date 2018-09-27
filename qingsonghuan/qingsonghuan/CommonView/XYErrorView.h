//
//  XYErrorView.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ErrorRefreshBlock)(void);

@interface XYErrorView : UIView

- (instancetype)initWithBlock:(ErrorRefreshBlock)refreshBlock;


@end
