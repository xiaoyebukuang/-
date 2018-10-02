//
//  LoginViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "MineConnectionViewController.h"
#import "RegisterTableViewCell.h"
#import "RegisterModel.h"

static NSString * const RegisterTableViewCell01ID = @"RegisterTableViewCell01ID";
static NSString * const RegisterTableViewCell03ID = @"RegisterTableViewCell03ID";

/**
 登录
 */
@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *loginTableV;

@property (nonatomic, strong) UIView *loginFooterView;

@property (nonatomic, strong) UIView *loginHeaderView;

@property (nonatomic, strong) RegisterModel *registerModel;

/**
 app描述
 */
@property (nonatomic, strong) UILabel *desLabel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerModel = [[RegisterModel alloc]init];
    [self setupView];
}

- (void)setupView {
    [self.view addSubview:self.loginTableV];
    [self.loginTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark -- event
//登录
- (void)loginBtnEvent:(UIButton *)sender {
    NSString *des = [self.registerModel checkLogin];
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    [RequestPath user_loginView:self.view param:@{@"phone":self.registerModel.phone,@"password":self.registerModel.password} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
       [[UserModel sharedInstance] reloadWithDic:obj];
    } failure:^(ErrorType errorType, NSString *mes) {

    }];
}
//注册
- (void)registerBtnEvent:(UIButton *)sender {
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//忘记密码
- (void)forgetBtnEvent:(UIButton *)sender {
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];    
}
//问题
- (void)problemBtnEvent:(UIButton *)sender {
    MineConnectionViewController *vc = [[MineConnectionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegisterTableViewCell *cell;
    NSArray *placeholderArr = @[LOGIN_TEL_PLACEHOLDER,LOGIN_PSW_PLACEHOLDER];
    NSArray *logoArr = @[@"login_tel",@"login_psw"];
    NSArray *tieldTypeArr = @[@(UITextFieldTel),@(UITextFieldPassword)];
    NSArray *contentArr = @[[NSString safe_string:self.registerModel.phone],
                            [NSString safe_string:self.registerModel.password]
                            ];
    NSString *cellID;
    if (indexPath.row == 0) {
        cellID = RegisterTableViewCell01ID;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        cellID = RegisterTableViewCell03ID;
    }
    cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    WeakSelf;
    [cell reloadData:contentArr[indexPath.row] logo:logoArr[indexPath.row] placeholder:placeholderArr[indexPath.row] textFieldType:[NSString safe_integer:tieldTypeArr[indexPath.row]] registerTVBlock:^(NSString *obj) {
        if (indexPath.row == 0) {
            weakSelf.registerModel.phone = obj;
        } else if (indexPath.row == 1) {
            weakSelf.registerModel.password = obj;
        }
    }];
    return cell;
}
#pragma mark -- setup
- (UITableView *)loginTableV {
    if (!_loginTableV) {
        _loginTableV = [[UITableView alloc] init];
        _loginTableV.delegate = self;
        _loginTableV.dataSource = self;
        _loginTableV.showsVerticalScrollIndicator = NO;
        _loginTableV.showsHorizontalScrollIndicator = NO;
        _loginTableV.bounces = NO;
        _loginTableV.rowHeight = 50;
        _loginTableV.tableFooterView = self.loginFooterView;
        _loginTableV.tableHeaderView = self.loginHeaderView;
        _loginTableV.backgroundColor = [UIColor clearColor];
        _loginTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_loginTableV registerClass:[RegisterTableViewCell01 class] forCellReuseIdentifier:RegisterTableViewCell01ID];
        [_loginTableV registerClass:[RegisterTableViewCell03 class] forCellReuseIdentifier:RegisterTableViewCell03ID];
    }
    return _loginTableV;
}
- (UIView *)loginHeaderView {
    if (!_loginHeaderView) {
        UIImage *logo = [UIImage imageNamed:@"logo"];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, logo.size.height + 180)];
        view.backgroundColor = [UIColor color_FFFFFF];
        UIImageView *logoImageV = [[UIImageView alloc]initWithImage:logo];
        [view addSubview:logoImageV];
        [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(100);
            make.centerX.equalTo(view);
        }];
        _loginHeaderView = view;
    }
    return _loginHeaderView;
}
- (UIView *)loginFooterView {
    if (!_loginFooterView) {
        CGFloat space = 10.0;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 180)];
        view.backgroundColor = [UIColor color_FFFFFF];
        //登录
        UIButton *loginBtn = [UIButton buttonWithTitle:@"登 录" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [loginBtn addTarget:self action:@selector(loginBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(50);
            make.right.equalTo(view).offset(-50);
            make.height.mas_offset(50);
            make.top.equalTo(view).offset(60);
        }];
        
        UIView *btnView = [[UIView alloc]init];
        [view addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginBtn.mas_bottom).offset(10);
            make.centerX.equalTo(loginBtn);
            make.height.mas_equalTo(30);
        }];
        //账号注册
        UIButton *registerBtn = [UIButton buttonWithTitle:@"账号注册>" font:SYSTEM_FONT_13 titleColor:[UIColor color_99D3F8]];
        [registerBtn addTarget:self action:@selector(registerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:registerBtn];
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.equalTo(btnView);
        }];
        //分割线01
        UIView *sView01 = [[UIView alloc]init];
        sView01.backgroundColor = [UIColor color_99D3F8];
        [btnView addSubview:sView01];
        [sView01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(0.5);
            make.centerY.equalTo(btnView);
            make.left.equalTo(registerBtn.mas_right).offset(space);
        }];
        //忘记密码
        UIButton *forgetBtn = [UIButton buttonWithTitle:@"忘记密码>" font:SYSTEM_FONT_13 titleColor:[UIColor color_99D3F8]];
        [forgetBtn addTarget:self action:@selector(forgetBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:forgetBtn];
        [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(registerBtn);
            make.left.equalTo(sView01.mas_right).offset(space);
        }];
        //分割线01
        UIView *sView02 = [[UIView alloc]init];
        sView02.backgroundColor = [UIColor color_99D3F8];
        [btnView addSubview:sView02];
        [sView02 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.height.equalTo(sView01);
            make.left.equalTo(forgetBtn.mas_right).offset(space);
        }];
        //忘记密码
        UIButton *problemBtn = [UIButton buttonWithTitle:@"问题>" font:SYSTEM_FONT_13 titleColor:[UIColor color_99D3F8]];
        [problemBtn addTarget:self action:@selector(problemBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:problemBtn];
        [problemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(registerBtn);
            make.left.equalTo(sView02.mas_right).offset(space);
            make.right.equalTo(btnView);
        }];
        _loginFooterView = view;
    }
    return _loginFooterView;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithText:@"———— 轻松换app ————" font:SYSTEM_FONT_13 textColor:[UIColor color_C7C7C7]];
    }
    return _desLabel;
}
@end
