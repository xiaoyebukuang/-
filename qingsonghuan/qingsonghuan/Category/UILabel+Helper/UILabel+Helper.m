//
//  UILabel+Helper.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor {
    self = [super init];
    if(self) {
        self.text = text;
        self.font = font;
        self.textColor = textColor;
    }
    return self;
}
@end
