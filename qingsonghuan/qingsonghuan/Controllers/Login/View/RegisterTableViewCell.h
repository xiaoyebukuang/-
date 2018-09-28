//
//  RegisterTableViewCell.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RegisterTVBlock)(NSString *obj);

@interface RegisterTableViewCell : UITableViewCell

@property (nonatomic, copy)NSString *content;
/**
 刷新视图
 
 @param content 输入框内容
 @param logo 左边logo
 @param placeholder 提示语句
 @param fieldType 输入框类型
 @param registerBlock 回调
 */
- (void)reloadData:(NSString *)content
              logo:(NSString *)logo
       placeholder:(NSString *)placeholder
     textFieldType:(UITextFieldType)fieldType
   registerTVBlock:(RegisterTVBlock)registerBlock;
@end

@interface RegisterTableViewCell01 : RegisterTableViewCell

@end

@interface RegisterTableViewCell02 : RegisterTableViewCell

@end

@interface RegisterTableViewCell03 : RegisterTableViewCell

@end

typedef void(^RegisterTimeBlock)(void);

@interface RegisterTableViewCell04 : RegisterTableViewCell

@property (nonatomic, copy)RegisterTimeBlock registerTimeBlock;

- (void)startTimer;

@end
