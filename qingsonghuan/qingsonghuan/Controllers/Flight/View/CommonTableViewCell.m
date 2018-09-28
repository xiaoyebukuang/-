//
//  CommonTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "RegNeedInfoModel.h"
@interface CommonTableViewCell()
@property (nonatomic, strong) UILabel *title;
@end
@implementation CommonTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CELL_LEFT_APACE);
        make.top.equalTo(self).offset(10);
        make.height.mas_offset(30);
        make.width.mas_equalTo(70);
    }];
    self.title.text = @"航班号:";
}
- (void)setIndex:(NSInteger)index {
    if (index%2 == 0) {
        self.backgroundColor = [UIColor color_FFFFFF];
    } else {
        self.backgroundColor = [UIColor color_D5E8F6];
    }
}
#pragma mark -- setup
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_666666]];
    }
    return _title;
}
@end

@interface CommonTableViewCell01()<XYTextFieldDelegate>

//回调
@property (nonatomic, copy) CommonClickBlock clickBlcok;
//点击框
@property (nonatomic, strong) UIControl *control;
@end

@implementation CommonTableViewCell01
- (void)setupView {
    [super setupView];
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self);
        make.height.mas_offset(30);
        make.centerY.equalTo(self.title);
    }];
    [self addSubview:self.control];
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.textField);
    }];
}
#pragma mark -- event
- (void)controlEvent:(UIControl *)control {
    if (self.clickBlcok) {
        self.clickBlcok(nil);
    }
}
- (void)reloadViewWithText:(NSString *)text
               placeHolder:(NSString *)placeHolder
                   content:(NSString *)content
                   enabled:(BOOL)enable
             textFieldType:(UITextFieldType)textFieldType
          commonClickBlock:(CommonClickBlock)clickBlcok {
    self.title.text = text;
    self.textField.text = content;
    self.textField.placeholder = placeHolder;
    self.textField.filedType = textFieldType;
    self.clickBlcok = clickBlcok;
    self.textField.enabled = enable;
    self.control.hidden = enable;
    if (enable) {
        self.textField.xyDelegate = self;
    }
}
#pragma mark -- XYTextFieldDelegate
- (void)textChange:(NSString *)text {
    if (self.clickBlcok) {
        self.clickBlcok(text);
    }
}
#pragma Mark -- setup
- (XYTextField *)textField {
    if (!_textField) {
        _textField = [[XYTextField alloc]initWithType:UITextFieldNormal placeHolder:nil];
        _textField.enabled = NO;
    }
    return _textField;
}
- (UIControl *)control {
    if (!_control) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}
@end


static NSInteger const COMMON_BTN_TAG = 329;

@interface CommonTableViewCell02()
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, copy) CommonClickBlock clickBlcok;
@property (nonatomic, strong) NSArray *objArr;
@end

@implementation CommonTableViewCell02

- (void)setupView {
    [super setupView];
    [self addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.top.bottom.equalTo(self);
    }];
}
- (void)reloadViewWithText:(NSString *)text
                   content:(NSArray *)contentArr
               selectModel:(id)model
          commonClickBlock:(CommonClickBlock)clickBlcok {
    self.title.text = text;
    self.clickBlcok = clickBlcok;
    self.objArr = contentArr;
    
    for (UIView *view in self.btnView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat width = MAIN_SCREEN_WIDTH - 100;
    CGFloat x_sum = 0;
    CGFloat y_sum = 10;
    CGFloat x_space = 15;
    CGFloat y_space = 10;
    CGFloat btn_height = 30;
    for (int i = 0; i < contentArr.count; i ++) {
        BOOL select = NO;
        id temp = contentArr[i];
        NSString *str;
        if ([temp isKindOfClass:[SignModel class]]) {
            str = ((SignModel *)temp).sign_name;
            SignModel *tempModel = (SignModel *)model;
            if (tempModel.signId == ((SignModel *)temp).signId) {
                select = YES;
            }
        } else if ([temp isKindOfClass:[VisaModel class]]) {
            str = ((VisaModel *)temp).visa_name;
            VisaModel *tempModel = (VisaModel *)model;
            if (tempModel.visaId == ((VisaModel *)temp).visaId) {
                select = YES;
            }
        } else if ([temp isKindOfClass:[WordLogoModel class]]) {
            str = ((WordLogoModel *)temp).mark;
            WordLogoModel *tempModel = (WordLogoModel *)model;
            if (tempModel.wordLogoID == ((WordLogoModel *)temp).wordLogoID) {
                select = YES;
            }
        } else if ([temp isKindOfClass:[DutiesModel class]]) {
            str = ((DutiesModel *)temp).job_title;
            DutiesModel *tempModel = (DutiesModel *)model;
            if (tempModel.dutiesId == ((DutiesModel *)temp).dutiesId) {
                select = YES;
            }
        }
        UIButton *btn = [UIButton buttonWithNormalBGImage:@"filter_normal" selectBGImage:@"filter_select" title:str font:SYSTEM_FONT_15 normalColor:[UIColor color_666666] selectColor:[UIColor color_2ECB87]];
        btn.tag = COMMON_BTN_TAG + i;
        btn.selected = select;
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:btn];
        CGFloat btn_width = 60;
        if (str.length > 2) {
            btn_width += (str.length - 2)*15;
        }
        if (x_sum + btn_width + x_space > width) {
            x_sum = 0;
            y_sum = y_sum + btn_height + y_space;
        }
        btn.frame = CGRectMake(x_sum, y_sum, btn_width, btn_height);
        x_sum = x_sum + btn_width + x_space;
    }
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(y_sum + btn_height + y_space);
    }];
    
}
#pragma mark -- event
- (void)btnEvent:(UIButton *)sender {
    BOOL select = sender.selected;
    if (select) {
        //之前选中现在取消选中
        self.clickBlcok(nil);
    } else {
        //之前未选中现在选中
        self.clickBlcok(self.objArr[sender.tag - COMMON_BTN_TAG]);
    }
    for (UIButton *btn in self.btnView.subviews) {
        btn.selected = NO;
    }
    sender.selected = !select;
}
#pragma mark -- setup
- (UIView *)btnView {
    if (!_btnView) {
        _btnView = [[UIView alloc]init];
    }
    return _btnView;
}
@end

@interface CommonTableViewCell03()

@property (nonatomic, strong) XYTextField *textField;
//出差天数
@property (nonatomic, strong) UIButton *workDayBtn;

@end

@implementation CommonTableViewCell03
- (void)setupView {
    [super setupView];
    [self addSubview:self.textField];
    self.textField.backgroundColor = [UIColor redColor];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self);
        make.height.mas_offset(30);
    }];
    [self addSubview:self.workDayBtn];
    [self.workDayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.title);
        make.centerY.equalTo (self);
    }];
}
#pragma mark -- setup
- (XYTextField *)textField {
    if (!_textField) {
        _textField = [[XYTextField alloc]initWithType:UITextFieldFlight placeHolder:FLIGHT_AIR_NUMBER];
    }
    return _textField;
}
- (UIButton *)workDayBtn {
    if (!_workDayBtn) {
        _workDayBtn = [UIButton buttonWithTitle:@"出差天数" font:SYSTEM_FONT_15 titleColor:[UIColor color_999999] backgroundImage:@"filter_submit_day"];
    }
    return _workDayBtn;
}
@end







@implementation CommonTableViewCell04
@end
