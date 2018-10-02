//
//  RegisterTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterTableViewCell.h"
static CGFloat const LOGIN_WIDTH_SIZE = 50.0;

@interface RegisterTableViewCell()<XYTextFieldDelegate>
//logo
@property (nonatomic, strong) UIImageView *logoImageV;
//输入框
@property (nonatomic, strong) XYTextField *textField;

@property (nonatomic, strong) XYLineView *lineV;

@property (nonatomic, copy) RegisterTVBlock registerBlcok;
//点击选择
@property (nonatomic, strong) UIControl *control;
//右侧图标
@property (nonatomic, strong) UIButton *arrowBtn;
//定时器
@property (nonatomic, strong) UIButton *timeBtn;
@end

@implementation RegisterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(self);
        make.left.equalTo(self).offset(CELL_LEFT_APACE);
        make.width.mas_equalTo(LOGIN_WIDTH_SIZE);
    }];
    
    [self addSubview:self.textField];
    self.textField.xyDelegate = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageV.mas_right);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.centerY.equalTo(self);
        make.height.mas_offset(30);
    }];
    
    [self addSubview:self.control];
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.textField);
    }];
    
    [self addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.right.equalTo(self.textField);
        make.width.equalTo(self.logoImageV);
    }];
    
    [self addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.logoImageV);
        make.right.equalTo(self.textField);
        make.height.mas_equalTo(0.5);
    }];
}
#pragma mark -- event
//验证码
- (void)timeBtnEvent:(UIButton *)sender {
    //点击发送验证码
}
//选择框
- (void)controlEvent:(UIControl *)sender {
    if (self.registerBlcok) {
        self.registerBlcok(nil);
    }
}
//右侧图标
- (void)arrowBtnEvent:(UIControl *)sender {
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = sender.selected;
}
- (void)reloadData:(NSString *)content logo:(NSString *)logo placeholder:(NSString *)placeholder textFieldType:(UITextFieldType)fieldType registerTVBlock:(RegisterTVBlock)registerBlock {
    self.textField.text = content;
    self.logoImageV.image = [UIImage imageNamed:logo];
    self.textField.placeholder = placeholder;
    self.textField.filedType = fieldType;
    self.registerBlcok = registerBlock;
}
- (void)setContent:(NSString *)content {
    _content = content;
    self.textField.text = content;
}

#pragma mark -- XYTextFieldDelegate
//输入框修改
- (void)textChange:(NSString *)text {
    if (self.registerBlcok) {
        self.registerBlcok(text);
    }
}
#pragma mark -- setup
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]init];
        _logoImageV.contentMode = UIViewContentModeCenter;
    }
    return _logoImageV;
}
- (XYTextField *)textField {
    if (!_textField) {
        _textField = [[XYTextField alloc]init];
    }
    return _textField;
}
- (XYLineView *)lineV {
    if (!_lineV) {
        _lineV = [[XYLineView alloc]init];
    }
    return _lineV;
}
- (UIControl *)control {
    if (!_control) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}
- (UIButton *)arrowBtn {
    if (!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn addTarget:self action:@selector(arrowBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}
- (UIButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithTitle:@"发送验证码" font:SYSTEM_FONT_15 normalColor:[UIColor color_FFFFFF] disabledColor:[UIColor color_FFFFFF] normalBackgroundImage:@"login_time_normal" disabledBackgroundImage:@"login_time_disabled"];
        [_timeBtn addTarget:self action:@selector(timeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeBtn;
}
@end

@implementation RegisterTableViewCell01
- (void)reloadData:(NSString *)content logo:(NSString *)logo placeholder:(NSString *)placeholder textFieldType:(UITextFieldType)fieldType registerTVBlock:(RegisterTVBlock)registerBlock {
    [super reloadData:content logo:logo placeholder:placeholder textFieldType:fieldType registerTVBlock:registerBlock];
    self.control.hidden = YES;
    self.textField.enabled = YES;
    self.arrowBtn.hidden = YES;
}
@end

@implementation RegisterTableViewCell02
- (void)reloadData:(NSString *)content logo:(NSString *)logo placeholder:(NSString *)placeholder textFieldType:(UITextFieldType)fieldType registerTVBlock:(RegisterTVBlock)registerBlock {
    [super reloadData:content logo:logo placeholder:placeholder textFieldType:fieldType registerTVBlock:registerBlock];
    self.control.hidden = NO;
    self.textField.enabled = NO;
    self.arrowBtn.hidden = NO;
    self.arrowBtn.enabled = NO;
    [self.arrowBtn setImage:[UIImage imageNamed:@"login_select_arrow"] forState:UIControlStateNormal];
}
@end
@implementation RegisterTableViewCell03
- (void)setArrowSlect:(BOOL)arrowSlect {
    _arrowSlect = arrowSlect;
    self.textField.secureTextEntry = arrowSlect;
    self.arrowBtn.selected = arrowSlect;
}
- (void)reloadData:(NSString *)content logo:(NSString *)logo placeholder:(NSString *)placeholder textFieldType:(UITextFieldType)fieldType registerTVBlock:(RegisterTVBlock)registerBlock {
    [super reloadData:content logo:logo placeholder:placeholder textFieldType:fieldType registerTVBlock:registerBlock];
    self.control.hidden = YES;
    self.textField.enabled = YES;
    self.arrowBtn.hidden = NO;
    self.arrowBtn.enabled = YES;
    [self.arrowBtn setImage:[UIImage imageNamed:@"login_eye_open"] forState:UIControlStateNormal];
    [self.arrowBtn setImage:[UIImage imageNamed:@"login_eye_close"] forState:UIControlStateSelected];
}
@end

@interface RegisterTableViewCell04()
//定时器
@property (nonatomic, strong) dispatch_source_t timer;
//倒计时
@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation RegisterTableViewCell04
- (void)reloadData:(NSString *)content logo:(NSString *)logo placeholder:(NSString *)placeholder textFieldType:(UITextFieldType)fieldType registerTVBlock:(RegisterTVBlock)registerBlock {
    [super reloadData:content logo:logo placeholder:placeholder textFieldType:fieldType registerTVBlock:registerBlock];
    self.control.hidden = YES;
    self.textField.enabled = YES;
    self.arrowBtn.hidden = YES;
    [self addSubview:self.timeBtn];
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self.textField);
        make.height.mas_equalTo(35);
        make.width.mas_offset(120);
    }];
}
//验证码
- (void)timeBtnEvent:(UIButton *)sender {
    //点击发送验证码
    [super timeBtnEvent:sender];
    if (self.registerTimeBlock) {
        self.registerTimeBlock();
    }
}
- (void)startTimer {
    if (!_timer) {
        self.timeCount = 10;
        //定时器开始执行的延时时间
        NSTimeInterval delayTime = 1.0f;
        //定时器间隔时间
        NSTimeInterval timeInterval = 1.0f;
        //创建子线程队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //使用之前创建的队列来创建计时器
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //设置延时执行时间，delayTime为要延时的秒数
        dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
        //设置计时器
        dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeCount --;
            });
        });
        // 启动计时器
        dispatch_resume(_timer);
    }
}
@end
