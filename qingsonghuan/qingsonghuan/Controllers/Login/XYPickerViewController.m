//
//  XYPickerViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPickerViewController.h"

@interface XYPickerViewController ()
/**
 选中编号
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 标题view
 */
@property (nonatomic, strong) UIView *titleView;

/**
 选择器
 */
@property (nonatomic, strong) UIPickerView* pickerView;
@end

@implementation XYPickerViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        self.modalPresentationStyle = UIModalPresentationCustom;
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCustom;
    [self setupView];
}
- (void)setupView {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pickerView];
//    self.pickerView.delegate = self;
//    self.pickerView.dataSource = self;
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(216);
    }];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.pickerView.mas_top);
    }];
}
#pragma mark -- event
//确定按钮事件
- (void)sureBtnEvent:(UIButton *)sender {
    
}
//取消按钮事件
- (void)cancelBtnEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- setup
- (UIView *)titleView {
    if (!_titleView) {
        UIView *view = [[UIView alloc]init];
        //确定按钮
        UIButton *sureBtn = [UIButton buttonWithTitle:@"确定" font:SYSTEM_FONT_15 titleColor:[UIColor color_DCDCDC]];
        [sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(-15);
        }];
        //取消按钮
        UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" font:SYSTEM_FONT_15 titleColor:[UIColor color_DCDCDC]];
        [cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(15);
        }];
        XYLineView *line = [[XYLineView alloc]init];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(view);
        }];
        _titleView = view;
    }
    return _titleView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.backgroundColor = [UIColor color_FFFFFF];
    }
    return _pickerView;
}

@end
