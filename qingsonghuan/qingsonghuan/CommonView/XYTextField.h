//
//  XYTextField.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UITextFieldType) {
    UITextFieldNormal,          //常规输入
    UITextFieldTel,             //电话，限制数字，11位
    UITextFieldPassword,        //密码，限制数字，字母，10位
    UITextFieldCode,            //验证码，限制数字，6位
    UITextFieldCard,            //登机证号，限制字符+数字 2个字符+5个数字
    UITextFieldFlight,          //航班号，限制数字，3-4个数字
    UITextFieldCity             //城市名称，5个字符
};

@protocol XYTextFieldDelegate <NSObject>

- (void)textChange:(NSString *)text;

@end


@interface XYTextField : UITextField

@property(nonatomic, weak) id<XYTextFieldDelegate> xyDelegate;
/**
 类型
 */
@property (nonatomic, assign) UITextFieldType filedType;

/**
 设置类型和默认提示的XYTextField
 
 @param filedType 类型
 @param placeHolder 默认提示
 @return 返回XYTextField
 */
- (instancetype)initWithType:(UITextFieldType)filedType placeHolder:(NSString *)placeHolder;



@end
