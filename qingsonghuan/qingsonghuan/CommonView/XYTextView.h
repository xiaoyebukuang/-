//
//  XYTextView.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYTextView;
@protocol XYTextViewDelegate <NSObject>

- (void)xy_textViewDidChange:(NSString *)text;

@end
@interface XYTextView : UITextView

@property (nonatomic, weak) id<XYTextViewDelegate>xy_delegate;

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, assign) NSInteger maxCount;

@end
