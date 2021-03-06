//
//  CommonTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "XYTextView.h"
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
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_offset(30);
        make.width.mas_equalTo(70);
    }];
}
- (void)setIndex:(NSInteger)index {
    if (index%2 == 0) {
        self.backgroundColor = [UIColor color_D5E8F6];
    } else {
        self.backgroundColor = [UIColor color_FFFFFF];
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

//点击框
@property (nonatomic, strong) UIControl *control;
@end

@implementation CommonTableViewCell01
- (void)setupView {
    [super setupView];
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self.contentView);
        make.height.mas_offset(30);
        make.centerY.equalTo(self.title);
    }];
    [self.contentView addSubview:self.control];
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
@property (nonatomic, strong) NSArray *objArr;
@end

@implementation CommonTableViewCell02

- (void)setupView {
    [super setupView];
    [self.contentView addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.top.bottom.equalTo(self.contentView);
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
            if ([tempModel.sign_id isEqualToString:((SignModel *)temp).sign_id]) {
                select = YES;
            }
        } else if ([temp isKindOfClass:[VisaModel class]]) {
            str = ((VisaModel *)temp).visa_name;
            VisaModel *tempModel = (VisaModel *)model;
            if ([tempModel.visa_id isEqualToString:((VisaModel *)temp).visa_id]) {
                select = YES;
            }
        } else if ([temp isKindOfClass:[WordLogoModel class]]) {
            str = ((WordLogoModel *)temp).word_logo_name;
            WordLogoModel *tempModel = (WordLogoModel *)model;
            if ([tempModel.word_logo_id isEqualToString:((WordLogoModel *)temp).word_logo_id]) {
                select = YES;
            }
        } else if ([temp isKindOfClass:[DutyModel class]]) {
            str = ((DutyModel *)temp).duty_name;
            DutyModel *tempModel = (DutyModel *)model;
            if ([tempModel.duty_id isEqualToString:((DutyModel *)temp).duty_id]) {
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

@interface CommonTableViewCell03()<XYTextFieldDelegate>

//出差天数
@property (nonatomic, strong) UIButton *workDayBtn;
//出差天数回调
@property (nonatomic, copy) DaysClickBlock daysClickBlock;
@end

@implementation CommonTableViewCell03
- (void)setupView {
    [super setupView];
    [self.contentView addSubview:self.textField];
    self.textField.xyDelegate = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self.contentView);
        make.height.mas_offset(30);
    }];
    [self.contentView addSubview:self.workDayBtn];
    [self.workDayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.title);
        make.centerY.equalTo(self.contentView);
    }];
}
- (void)reloadViewTitle:(NSString *)text
                content:(NSString *)content
                   days:(NSString *)days
         daysClickBlock:(DaysClickBlock)daysClickBlock
       commonClickBlock:(CommonClickBlock)commonClickBlock {
    self.daysClickBlock = daysClickBlock;
    self.clickBlcok = commonClickBlock;
    self.title.text = text;
    self.textField.text = content;
    if (![NSString isEmpty:days]) {
        [self.workDayBtn setTitle:days forState:UIControlStateNormal];
        [self.workDayBtn setTitleColor:[UIColor color_333333] forState:UIControlStateNormal];
    }
}
- (void)setDays:(NSString *)days {
    [self.workDayBtn setTitle:days forState:UIControlStateNormal];
    [self.workDayBtn setTitleColor:[UIColor color_333333] forState:UIControlStateNormal];
}
#pragma mark -- event
- (void)workDayBtnEvent:(UIButton *)sender {
    if (self.daysClickBlock) {
        self.daysClickBlock();
    }
}
#pragma mark -- XYTextFieldDelegate
- (void)textChange:(NSString *)text {
    if (self.clickBlcok) {
        self.clickBlcok(text);
    }
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
        [_workDayBtn addTarget:self action:@selector(workDayBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _workDayBtn;
}
@end


static NSInteger const CITY_BTN_TAG = 213;

@interface CommonTableViewCell04()

@property (nonatomic, strong) UIButton *addCity;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) NSMutableArray *contentArr;

@end

@implementation CommonTableViewCell04
- (void)setupView {
    [super setupView];
    self.contentArr = [[NSMutableArray alloc]init];
    [self.contentView addSubview:self.addCity];
    [self.addCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.title);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right);
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH - 2*CELL_LEFT_APACE - 100);
        make.top.equalTo(self.title);
        make.height.mas_offset(30);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}
- (void)reloadViewTitle:(NSString *)text
                content:(NSArray *)contentArr
       commonClickBlock:(CommonClickBlock)commonClickBlock {
    self.title.text = @"航段信息:";
    self.clickBlcok = commonClickBlock;
    [self.contentArr removeAllObjects];
    [self.contentArr addObjectsFromArray:contentArr];
    for (UIView *temp in self.bgView.subviews) {
        [temp removeFromSuperview];
    }
    if (contentArr.count == 0) {
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(30);
        }];
    } else {
        [self setupBtn];
    }
    
}
- (void)setupBtn {
    CGFloat width = MAIN_SCREEN_WIDTH - 2*CELL_LEFT_APACE - 100;
    CGFloat x_sum = 0;
    CGFloat y_sum = 0;
    CGFloat x_space = 20;
    CGFloat y_space = 10;
    CGFloat btn_height = 30;
    for (int i = 0; i < self.contentArr.count; i ++) {
        NSString *text = self.contentArr[i];
        
        if (i != 0) {
            UIImageView *arrowImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"filter_city_arrow"]];
            arrowImageV.contentMode = UIViewContentModeCenter;
            [self.bgView addSubview:arrowImageV];
            
            if (x_sum + x_space > width) {
                x_sum = 0;
                y_sum = y_sum + btn_height + y_space;
            }
            arrowImageV.frame = CGRectMake(x_sum, y_sum, x_space, btn_height);
            x_sum = x_sum + x_space;
        }
        UIButton *titleBtn = [UIButton buttonWithBGImage:@"filte_city_bg" title:text font:SYSTEM_FONT_13 textColor:[UIColor color_2ECB87]];
        titleBtn.tag = CITY_BTN_TAG + i;
        [titleBtn addTarget:self action:@selector(deleteCityEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:titleBtn];
        CGFloat btn_width = 40;
        if (text.length > 2) {
            btn_width += (text.length - 2)*15;
        }
        if (x_sum + btn_width > width) {
            x_sum = 0;
            y_sum = y_sum + btn_height + y_space;
        }
        titleBtn.frame = CGRectMake(x_sum, y_sum, btn_width, btn_height);
        x_sum = x_sum + btn_width;
        
        UIButton *deletebtn = [UIButton buttonWithBGImage:@"filter_city_delete"];
        [titleBtn addSubview:deletebtn];
        [deletebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(titleBtn).multipliedBy(2.0);
            make.centerY.equalTo(titleBtn).multipliedBy(0.01);
            make.width.height.mas_equalTo(15);
        }];
    }
    y_sum = y_sum + btn_height;
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(y_sum);
    }];
}
#pragma mark -- event
- (void)addCityEvent:(UIButton *)sender {
    [UIAlertViewTool showFieldTitle:@"城市或机场" placeHolder:@"请输入城市或机场名称" titlesArr:@[@"取消",@"确定"] alertBlock:^(NSString *mes, NSInteger index) {
        if (index == 1) {
            if ([NSString isEmpty:mes]) {
                [MBProgressHUD showError:@"请输入城市名称"];
                return;
            }
            [self.contentArr addObject:mes];
            if (self.clickBlcok) {
                self.clickBlcok(self.contentArr);
            }
        }
    }];
}
- (void)deleteCityEvent:(UIButton *)sender {
    NSUInteger index = sender.tag - CITY_BTN_TAG;
    [self.contentArr removeObjectAtIndex:index];
    if (self.clickBlcok) {
        self.clickBlcok(self.contentArr);
    }
}
#pragma mark -- setup
- (UIButton *)addCity {
    if (!_addCity) {
        _addCity = [UIButton buttonWithImage:@"filte_add_city"];
        [_addCity addTarget:self action:@selector(addCityEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCity;
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}
@end

@interface CommonTableViewCell05()<XYTextViewDelegate>

@property (nonatomic, strong) XYTextView *textView;

@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation CommonTableViewCell05
- (void)setupView {
    [super setupView];
    self.title.text = @"";
    [self.contentView addSubview:self.textView];
    self.textView.xy_delegate = self;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.title);
        make.left.equalTo(self.title.mas_right);
        make.height.mas_offset(100);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self.title);
        make.width.mas_equalTo(50);
    }];
}
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    self.textView.maxCount = maxCount;
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.textView.text.length,(long)self.maxCount];
}
- (void)setHiddenNumber:(BOOL)hiddenNumber {
    _hiddenNumber = hiddenNumber;
    self.numberLabel.hidden = hiddenNumber;
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CELL_LEFT_APACE - (hiddenNumber ? 0 : 50));
    }];
    if (hiddenNumber) {
        self.maxCount = NSIntegerMax;
    }
}
- (void)reloadViewTitle:(NSString *)text
                content:(NSString *)content
       commonClickBlock:(CommonClickBlock)commonClickBlock {
    self.title.text = text;
    self.textView.text = content;
    self.clickBlcok = commonClickBlock;
}
#pragma mark -- XYTextViewDelegate
- (void)xy_textViewDidChange:(NSString *)text {
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)text.length,(long)self.maxCount];
    if (self.clickBlcok) {
        self.clickBlcok(text);
    }
}
- (XYTextView *)textView {
    if (!_textView) {
        _textView = [[XYTextView alloc]init];
        _textView.placeHolder = @"请输入内容";
        _textView.textColor = [UIColor color_333333];
    }
    return _textView;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_999999]];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}
@end
