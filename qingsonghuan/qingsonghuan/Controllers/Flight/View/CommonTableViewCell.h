//
//  CommonTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonClickBlock)(id obj);

@interface CommonTableViewCell : UITableViewCell
//回调
@property (nonatomic, copy) CommonClickBlock clickBlcok;
//index
@property (nonatomic, assign) NSInteger index;
@end


@interface CommonTableViewCell01 : CommonTableViewCell
//输入框
@property (nonatomic, strong) XYTextField *textField;

/**
 刷新视图
 
 @param text 左边标题
 @param placeHolder 默认提示
 @param content 内容
 @param enable 输入框是否可用
 @param textFieldType 输入框类型
 @param clickBlcok 回调
 
 
 */
- (void)reloadViewWithText:(NSString *)text
               placeHolder:(NSString *)placeHolder
                   content:(NSString *)content
                   enabled:(BOOL)enable
             textFieldType:(UITextFieldType)textFieldType
          commonClickBlock:(CommonClickBlock)clickBlcok;

@end


@interface CommonTableViewCell02 : CommonTableViewCell
/**
 刷新视图

 @param text 坐标标题
 @param contentArr 按钮数组
 @param clickBlcok 回调
 */
- (void)reloadViewWithText:(NSString *)text
                   content:(NSArray *)contentArr
               selectModel:(id)model
          commonClickBlock:(CommonClickBlock)clickBlcok;
@end

typedef void(^DaysClickBlock)(void);

@interface CommonTableViewCell03 : CommonTableViewCell

@property (nonatomic, strong) XYTextField *textField;

@property (nonatomic, copy) NSString *days;

/**
 刷新
 
 @param content 内容填充
 @param days 出差天数
 @param daysClickBlock 点击出差天数回调
 @param commonClickBlock 输入框回调
 */
- (void)reloadViewContent:(NSString *)content
                     days:(NSString *)days
           daysClickBlock:(DaysClickBlock)daysClickBlock
         commonClickBlock:(CommonClickBlock)commonClickBlock;

@end

@interface CommonTableViewCell04 : CommonTableViewCell


/**
 刷新

 @param contentArr 城市数组
 @param commonClickBlock 回调
 */
- (void)reloadViewContent:(NSArray *)contentArr
         commonClickBlock:(CommonClickBlock)commonClickBlock;

@end

@interface CommonTableViewCell05 : CommonTableViewCell

@end
