//
//  UserListScreenViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/9.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UserListScreenViewController.h"
#import "UserListScreenModel.h"
#import "CommonTableViewCell.h"
static NSString * const CommonTableViewCell01ID = @"CommonTableViewCell01ID";
@interface UserListScreenViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *screenTableV;
//重置&确定view
@property (nonatomic, strong) UIView *footerView;
//重置
@property (nonatomic, strong) UIButton *resetBtn;
//确定
@property (nonatomic, strong) UIButton *sureBtn;
//筛选model
@property (nonatomic, strong) UserListScreenModel *userListScreenModel;
//确定，重置回调
@property (nonatomic, copy) UserListScreenBlock userListScreenBlock;
@end

@implementation UserListScreenViewController
- (instancetype)initWithUserListScreenModel:(UserListScreenModel *)userListScreenModel userListScreenBlock:(UserListScreenBlock)userListScreenBlock {
    self = [super init];
    if (self) {
        self.userListScreenModel = userListScreenModel;
        self.userListScreenBlock = userListScreenBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_99D3F8_3];
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.screenTableV];
    self.screenTableV.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0);
}

#pragma mark -- event
//重置
- (void)resetBtnEvent:(UIButton *)sender {
    self.userListScreenModel.user_phone = @"";
    self.userListScreenModel.work_number = @"";
    if (self.userListScreenBlock) {
        self.userListScreenBlock(self.userListScreenModel);
    }
}
//确定
- (void)sureBtnEvent:(UIButton *)sender {
    if (self.userListScreenBlock) {
        self.userListScreenBlock(self.userListScreenModel);
    }
}
//展示
- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.screenTableV.height = CONTENT_HEIGHT;
    }];
}
//消失
- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.screenTableV.height = 0;
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr = @[@"手机号:",@"登机证号:"];
    NSArray *placeArr = @[@"请输入手机号:",@"请输入登机证号:"];
    NSArray *fieldTypeArr = @[@(UITextFieldTel),@(UITextFieldCard)];
    NSArray *contentArr = @[self.userListScreenModel.user_phone,self.userListScreenModel.work_number];
    WeakSelf;
    CommonTableViewCell01 *cell = [tableView dequeueReusableCellWithIdentifier:CommonTableViewCell01ID];
    [cell reloadViewWithText:titleArr[indexPath.row] placeHolder:placeArr[indexPath.row] content:contentArr[indexPath.row] enabled:YES textFieldType:[NSString safe_integer:fieldTypeArr[indexPath.row]] commonClickBlock:^(id obj) {
        if (indexPath.row == 0) {
            weakSelf.userListScreenModel.user_phone = obj;
        } else {
            weakSelf.userListScreenModel.work_number = obj;
        }
    }];
    cell.index = indexPath.row;
    return cell;
}


#pragma mark -- setup
- (UITableView *)screenTableV {
    if (!_screenTableV) {
        _screenTableV = [[UITableView alloc] init];
        _screenTableV.delegate = self;
        _screenTableV.dataSource = self;
        _screenTableV.showsVerticalScrollIndicator = NO;
        _screenTableV.showsHorizontalScrollIndicator = NO;
        _screenTableV.bounces = NO;
        _screenTableV.estimatedRowHeight = 44;
        _screenTableV.backgroundColor = [UIColor clearColor];
        _screenTableV.tableFooterView = self.footerView;
        _screenTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_screenTableV registerClass:[CommonTableViewCell01 class] forCellReuseIdentifier:CommonTableViewCell01ID];
    }
    return _screenTableV;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 110)];
        view.backgroundColor = [UIColor color_FFFFFF];
        [view addSubview:self.resetBtn];
        [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view).multipliedBy(0.5);
        }];
        
        [view addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view).multipliedBy(1.5);
        }];
        _footerView = view;
    }
    return _footerView;
}
- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithTitle:@"重置" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"filter_btn_bg"];
        [_resetBtn addTarget:self action:@selector(resetBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithTitle:@"确定" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"filter_btn_bg"];
        [_sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
