//
//  XYPickerViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPickerViewController.h"
#import "XYPickerHeaderView.h"
#import "RegNeedInfoModel.h"
@interface XYPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>


/**
 标题view
 */
@property (nonatomic, strong) XYPickerHeaderView *titleView;

/**
 空白区域取消
 */
@property (nonatomic, strong) UIControl *control;

/**
 选择器
 */
@property (nonatomic, strong) UIPickerView* pickerView;


/**
 数据源
 */
@property (nonatomic, strong) NSArray *list;

/**
 回调
 */
@property (nonatomic, copy) PickerBlock pickerBlock;

/**
 选中编号
 */
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation XYPickerViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.pickerView selectRow:self.selectIndex inComponent:0 animated:NO];
}

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
    [self.view addSubview:self.control];
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
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

- (void)reloadViewWithArr:(NSArray *)list pickerBlock:(PickerBlock)pickerBlock {
    if (list.count > 0) {
        self.selectIndex = 0;
        self.list = list;
        self.pickerBlock = pickerBlock;
    }
}
#pragma mark -- event
- (void)reloadData {
    WeakSelf;
    [self.titleView setSureBlock:^{
        if (weakSelf.pickerBlock) {
            weakSelf.pickerBlock(weakSelf.list[weakSelf.selectIndex]);
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } cancleBlock:^{
        if (weakSelf.pickerBlock) {
            weakSelf.pickerBlock(nil);
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (void)controlEvent:(UIControl *)sender {
    if (self.pickerBlock) {
        self.pickerBlock(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.list.count;
}

#pragma mark -- UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //TODO:获取model中的显示属性
    id model = self.list[row];
    NSString *title = @"";
    if ([model isKindOfClass:[AirlineModel class]]) {
        title = ((AirlineModel *)model).airline_name;
    }
    if ([model isKindOfClass:[SubsidiaryModel class]]) {
        title = ((SubsidiaryModel *)model).subsidiary_name;
    }
    if ([model isKindOfClass:[DutyModel class]]) {
        title = ((DutyModel *)model).duty_name;
    }
    if ([model isKindOfClass:[VisaModel class]]) {
        title = ((VisaModel *)model).visa_name;
    }
    if ([model isKindOfClass:[SexModel class]]) {
        title = ((SexModel *)model).sex_name;
    }
    if ([model isKindOfClass:[WordLogoModel class]]) {
        title = ((WordLogoModel *)model).word_logo_name;
    }
    if ([model isKindOfClass:[DaysModel class]]) {
        title = ((DaysModel *)model).days_name;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithText:title font:SYSTEM_FONT_15 textColor:[UIColor color_333333]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    return titleLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
}


#pragma mark -- setup
- (XYPickerHeaderView *)titleView {
    if (!_titleView) {
        _titleView = [[XYPickerHeaderView alloc]init];
    }
    return _titleView;
}

- (UIControl *)control {
    if (!_control) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.backgroundColor = [UIColor color_FFFFFF];
    }
    return _pickerView;
}


@end
