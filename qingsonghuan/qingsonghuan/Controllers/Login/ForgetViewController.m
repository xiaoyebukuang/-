//
//  ForgetViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/21.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ForgetViewController.h"
#import "RegisterTableViewCell.h"
#import "RegisterModel.h"

static NSString * const RegisterTableViewCell01ID = @"RegisterTableViewCell01ID";
static NSString * const RegisterTableViewCell03ID = @"RegisterTableViewCell03ID";
static NSString * const RegisterTableViewCell04ID = @"RegisterTableViewCell04ID";

/**
 忘记密码——找回密码
 */
@interface ForgetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *forgetTableV;

@property (nonatomic, strong) UIView *forgetFooterView;

@property (nonatomic, strong) RegisterModel *registerModel;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.registerModel = [[RegisterModel alloc]init];
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.forgetTableV];
    [self.forgetTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark -- event
- (void)resetBtnEvent:(UIButton *)sender {
    NSString *des = [self.registerModel checkFroget];
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    [self.view endEditing:YES];
    NSDictionary *parma = @{@"phone":self.registerModel.phone,
                            @"password":self.registerModel.password,
                            @"password_confirm":self.registerModel.password_confirm,
                            @"code":self.registerModel.code,
                            @"iden":[NSString safe_string:self.registerModel.sendCodeModel.iden]
                            };
    [MBProgressHUD showToView:self.view];
    [RequestPath user_retrieveParam:parma success:^(id obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"重置密码成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        [MBProgressHUD showError:mes ToView:self.view];
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegisterTableViewCell *cell;
    NSArray *placeholderArr = @[LOGIN_TEL_PLACEHOLDER,LOGIN_PSW_PLACEHOLDER,LOGIN_AGAIN_PSW_PLACEHOLDER,LOGIN_CODE_PLACEHOLDER];
    NSArray *logoArr = @[@"login_tel",@"login_psw",@"login_psw",@"login_code"];
    NSArray *tieldTypeArr = @[@(UITextFieldTel),@(UITextFieldPassword),@(UITextFieldPassword),@(UITextFieldCode)];
    NSArray *contentArr = @[[NSString safe_string:self.registerModel.phone],
                            [NSString safe_string:self.registerModel.password],
                            [NSString safe_string:self.registerModel.password_confirm],
                            [NSString safe_string:self.registerModel.code]
                            ];
    NSString *cellID;
    if (indexPath.row == 0) {
        cellID = RegisterTableViewCell01ID;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        cellID = RegisterTableViewCell03ID;
    } else {
        cellID = RegisterTableViewCell04ID;
    }
    cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    WeakSelf;
    [cell reloadData:contentArr[indexPath.row] logo:logoArr[indexPath.row] placeholder:placeholderArr[indexPath.row] textFieldType:[NSString safe_integer:tieldTypeArr[indexPath.row]] registerTVBlock:^(NSString *obj) {
        if (indexPath.row == 0) {
            weakSelf.registerModel.phone = obj;
        } else if (indexPath.row == 1) {
            weakSelf.registerModel.password = obj;
        } else if (indexPath.row == 2) {
            weakSelf.registerModel.password_confirm = obj;
        } else if (indexPath.row == 3) {
            weakSelf.registerModel.code = obj;
        }
    }];
    if (indexPath.row == 3) {
        __weak RegisterTableViewCell04 *weakCell = (RegisterTableViewCell04 *)cell;
        weakCell.registerTimeBlock = ^{
            [RequestPath user_sendCodeView:weakSelf.view phone:weakSelf.registerModel.phone success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
                [weakCell startTimer];
                weakSelf.registerModel.sendCodeModel = [[SendCodeModel alloc]initWithDic:obj];
            } failure:^(ErrorType errorType, NSString *mes) {
                
            }];
        };
    }
    return cell;
}
#pragma mark -- setup
- (UITableView *)forgetTableV {
    if (!_forgetTableV) {
        _forgetTableV = [[UITableView alloc] init];
        _forgetTableV.delegate = self;
        _forgetTableV.dataSource = self;
        _forgetTableV.showsVerticalScrollIndicator = NO;
        _forgetTableV.showsHorizontalScrollIndicator = NO;
        _forgetTableV.bounces = NO;
        _forgetTableV.rowHeight = 50;
        _forgetTableV.tableFooterView = self.forgetFooterView;
        _forgetTableV.backgroundColor = [UIColor clearColor];
        _forgetTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_forgetTableV registerClass:[RegisterTableViewCell01 class] forCellReuseIdentifier:RegisterTableViewCell01ID];
        [_forgetTableV registerClass:[RegisterTableViewCell03 class] forCellReuseIdentifier:RegisterTableViewCell03ID];
        [_forgetTableV registerClass:[RegisterTableViewCell04 class] forCellReuseIdentifier:RegisterTableViewCell04ID];
    }
    return _forgetTableV;
}
- (UIView *)forgetFooterView {
    if (!_forgetFooterView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 110)];
        view.backgroundColor = [UIColor color_FFFFFF];
        UIButton *resetBtn = [UIButton buttonWithTitle:@"确认重置" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [resetBtn addTarget:self action:@selector(resetBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:resetBtn];
        [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view);
        }];
        _forgetFooterView = view;
    }
    return _forgetFooterView;
}

@end
