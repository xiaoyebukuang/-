//
//  XYPickerDateViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPickerDateViewController.h"
#import "XYPickerHeaderView.h"
@interface XYPickerDateViewController ()
/**
 标题view
 */
@property (nonatomic, strong) XYPickerHeaderView *titleView;

//日期选择器
@property (nonatomic, strong) UIDatePicker *datePicker;

//回调
@property (nonatomic, copy) PickerDateBlock pickerDateBlock;

@end

@implementation XYPickerDateViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor color_99D3F8_3];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self reloadData];
}
- (void)setupView {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.datePicker];

    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(216);
    }];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.datePicker.mas_top);
    }];
}
- (void)reloadViewWithPickerDateBlock:(PickerDateBlock)pickerDateBlock {
    self.pickerDateBlock = pickerDateBlock;
}
- (void)setPickerMode:(UIDatePickerMode)pickerMode {
    _pickerMode = pickerMode;
    self.datePicker.datePickerMode = pickerMode;
    if (pickerMode == UIDatePickerModeDate) {
        self.datePicker.minimumDate = [NSDate date];
    }
}
#pragma mark -- event
- (void)reloadData {
    WeakSelf;
    [self.titleView setSureBlock:^{
        if (weakSelf.pickerDateBlock) {
            weakSelf.pickerDateBlock(weakSelf.datePicker.date);
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } cancleBlock:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- setup
- (XYPickerHeaderView *)titleView {
    if (!_titleView) {
        _titleView = [[XYPickerHeaderView alloc]init];
    }
    return _titleView;
}
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.backgroundColor = [UIColor color_FFFFFF];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}


@end
