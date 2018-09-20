//
//  XYTextField.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UITextFieldType) {
    UITextFieldTel,             //电话，限制数字，11位
    UITextFieldPassword         //密码，限制数字，字母，10位
};

@interface XYTextField : UITextField
/**
 设置类型的UITextFile
 
 @param filedType 类型
 @return UITextFile
 */
- (instancetype)initWithType:(UITextFieldType)filedType;

/**
 设置类型和默认提示的UITextFile
 
 @param filedType 类型
 @param placeHolder 默认提示
 @return 返回UITextFile
 */
- (instancetype)initWithType:(UITextFieldType)filedType placeHolder:(NSString *)placeHolder;

@end
