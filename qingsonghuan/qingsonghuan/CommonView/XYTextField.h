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
    UITextFieldCode             //验证码，限制数字，6位
};

typedef void(^SelectBlock)(void);


@interface XYTextFieldView : UIView
/**
 输入框内容
 */
@property (nonatomic, copy) NSString *text;


/**
 选中回调
 */
@property (nonatomic, copy) SelectBlock selectBlock;

/**
设置类型的XYTextFieldView（左侧图标+填充）

 @param filedType UITextFiled类型
 @param logoStr LOGO图片
 @param placeHolder 提示语句
 @return XYTextFieldView
 */
- (instancetype)initWithLeftType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr placeHolder:(NSString *)placeHolder;

/**
 设置类型的XYTextFieldView（左侧图标+右侧图标（可点击）+填充）

 @param filedType UITextFiled类型
 @param logoStr LOGO图片
 @param normalArrowStr 右侧常规图标
 @param selectArrowStr 右侧选中图标
 @param placeHolder 提示语句
 @return XYTextFieldView
 */
- (instancetype)initWithLeftRightType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr arrowImageVNormal:(NSString *)normalArrowStr arrowImageVSelect:(NSString *)selectArrowStr placeHolder:(NSString *)placeHolder;;

/**
 设置类型的XYTextFieldView（左侧图标+右侧图标（不可点击）+选择）

 @param filedType UITextFiled类型
 @param logoStr LOGO图片
 @param arrowStr 右侧图标
 @param placeHolder 提示语句
 @return XYTextFieldView
 */

- (instancetype)initWithSelectType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr arrowImageV:(NSString *)arrowStr  placeHolder:(NSString *)placeHolder;


/**
 设置类型的XYTextFieldView（左侧图标+右侧验证码+填充）

 @param filedType UITextFiled类型
 @param logoStr LOGO图标
 @param placeHolder 提示语句
 @return XYTextFieldView
 */
- (instancetype)initWithCodeType:(UITextFieldType)filedType logoImageV:(NSString *)logoStr placeHolder:(NSString *)placeHolder;




@end




@interface XYTextField : UITextField
/**
 设置类型和默认提示的XYTextField
 
 @param filedType 类型
 @param placeHolder 默认提示
 @return 返回XYTextField
 */
- (instancetype)initWithType:(UITextFieldType)filedType placeHolder:(NSString *)placeHolder;

@end
