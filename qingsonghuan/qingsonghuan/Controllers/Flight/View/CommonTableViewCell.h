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


@interface CommonTableViewCell03 : CommonTableViewCell



@end

@interface CommonTableViewCell04 : CommonTableViewCell

@end
