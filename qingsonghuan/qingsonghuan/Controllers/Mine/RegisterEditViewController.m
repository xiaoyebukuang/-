//
//  RegisterEditViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegisterEditViewController.h"
#import "XYPickerViewController.h"
#import "RegisterTableViewCell.h"
#import "RegisterModel.h"

static NSString * const RegisterTableViewCell01ID = @"RegisterTableViewCell01ID";
static NSString * const RegisterTableViewCell02ID = @"RegisterTableViewCell02ID";
static NSString * const RegisterTableViewCell03ID = @"RegisterTableViewCell03ID";
static NSString * const RegisterTableViewCell04ID = @"RegisterTableViewCell04ID";
/**
 注册
 */

@interface RegisterEditViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *registerTableV;

@property (nonatomic, strong) UIView *registerFooterView;

@property (nonatomic, strong) RegisterModel *registerModel;
@end

@implementation RegisterEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息修改";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.registerTableV];
    [self.registerTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self requestData];
}
#pragma mark -- event
//请求数据
- (void)requestData {
    [RequestPath user_getUserInfoView:self.view success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        //成功后处理数据
        self.registerModel = [[RegisterModel alloc]initWithDic:obj];
        [RequestPath user_regNeedInfoView:self.view success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
            [self.registerTableV reloadData];
        } failure:^(ErrorType errorType, NSString *mes) {
            WeakSelf;
            [self showErrorView:^{
                [weakSelf requestData];
            }];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        WeakSelf;
        [self showErrorView:^{
            [weakSelf requestData];
        }];
    }];
}
- (void)registerBtnEvent:(UIButton *)sender {
    NSString *des = [self.registerModel checkReg];
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    NSDictionary *param = @{@"phone":self.registerModel.phone,
                            @"airline_id":[NSString safe_string:self.registerModel.airlineModel.airline_id],
                            @"subsidiary_id":[NSString safe_string:self.registerModel.subsidiaryModel.subsidiary_id],
                            @"duty_id":[NSString safe_string:self.registerModel.dutyModel.duty_id],
                            @"visa_id":[NSString safe_string:self.registerModel.visaModel.visa_id],
                            @"work_number":self.registerModel.work_number,
                            @"sex":[NSString safe_string:self.registerModel.sexModel.sex_id],
                            @"password":self.registerModel.password,
                            @"password_confirm":self.registerModel.password_confirm,
                            @"code":self.registerModel.code,
                            @"iden":[NSString safe_string:self.registerModel.sendCodeModel.iden]
                            };
    [RequestPath user_editUserInfoView:self.view param:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"修改成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *placeholderArr = @[LOGIN_TEL_PLACEHOLDER, LOGIN_COMPANY_PLACEHOLDER, LOGIN_AREA_PLACEHOLDER, LOGIN_POST_PLACEHOLDER, LOGIN_VISA_PLACEHOLDER, LOGIN_CARD_PLACEHOLDER, LOGIN_SEX_PLACEHOLDER, LOGIN_PSW_PLACEHOLDER,LOGIN_AGAIN_PSW_PLACEHOLDER,LOGIN_CODE_PLACEHOLDER];
    NSArray *logoArr = @[@"login_tel",@"login_company",@"login_area",@"login_post",@"login_visa",@"login_card",@"login_sex",@"login_psw",@"login_psw",@"login_code"];
    NSArray *tieldTypeArr = @[@(UITextFieldTel),@(UITextFieldNormal),@(UITextFieldNormal),@(UITextFieldNormal),@(UITextFieldNormal),@(UITextFieldCard),@(UITextFieldNormal),@(UITextFieldPassword),@(UITextFieldPassword),@(UITextFieldCode)];
    NSArray *contentArr = @[[NSString safe_string:self.registerModel.phone],
                            [NSString safe_string:self.registerModel.airlineModel.airline_name],
                            [NSString safe_string:self.registerModel.subsidiaryModel.subsidiary_name],
                            [NSString safe_string:self.registerModel.dutyModel.duty_name],
                            [NSString safe_string:self.registerModel.visaModel.visa_name],
                            [NSString safe_string:self.registerModel.work_number],
                            [NSString safe_string:self.registerModel.sexModel.sex_name],
                            [NSString safe_string:self.registerModel.password],
                            [NSString safe_string:self.registerModel.password_confirm],
                            [NSString safe_string:self.registerModel.code]
                            ];
    NSString *cellID;
    if (indexPath.row == 0 || indexPath.row == 5) {
        cellID = RegisterTableViewCell01ID;
    } else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6) {
        cellID = RegisterTableViewCell02ID;
    } else if (indexPath.row == 7 || indexPath.row == 8) {
        cellID = RegisterTableViewCell03ID;
    } else {
        cellID = RegisterTableViewCell04ID;
    }
    RegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    WeakSelf;
    [cell reloadData:contentArr[indexPath.row] logo:logoArr[indexPath.row] placeholder:placeholderArr[indexPath.row] textFieldType:[NSString safe_integer:tieldTypeArr[indexPath.row]] registerTVBlock:^(NSString *obj) {
        RegNeedInfoModel *regModle = [RegNeedInfoModel sharedInstance];
        if (indexPath.row == 0) {
            weakSelf.registerModel.phone = obj;
        } else if (indexPath.row == 1) {
            [weakSelf.view endEditing:YES];
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:regModle.airlineModelArr pickerBlock:^(id model) {
                if (model) {
                    weakSelf.registerModel.airlineModel = (AirlineModel *)model;
                    cell.content = weakSelf.registerModel.airlineModel.airline_name;
                    weakSelf.registerModel.subsidiaryModel = nil;
                    [tableView reloadData];
                }
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        } else if (indexPath.row == 2) {
            [weakSelf.view endEditing:YES];
            if (weakSelf.registerModel.airlineModel == nil) {
                [MBProgressHUD showError:@"请选择航空公司"];
                return;
            }
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:weakSelf.registerModel.airlineModel.subsidiaryArr pickerBlock:^(id model) {
                if (model) {
                    weakSelf.registerModel.subsidiaryModel = (SubsidiaryModel *)model;
                    cell.content = weakSelf.registerModel.subsidiaryModel.subsidiary_name;
                }
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        } else if (indexPath.row == 3) {
            [weakSelf.view endEditing:YES];
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:regModle.dutyModelArr pickerBlock:^(id model) {
                if (model) {
                    weakSelf.registerModel.dutyModel = (DutyModel *)model;
                    cell.content = weakSelf.registerModel.dutyModel.duty_name;
                }
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        } else if (indexPath.row == 4) {
            [weakSelf.view endEditing:YES];
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:regModle.visaModelArr pickerBlock:^(id model) {
                if (model) {
                    weakSelf.registerModel.visaModel = (VisaModel *)model;
                    cell.content = weakSelf.registerModel.visaModel.visa_name;
                }
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        } else if (indexPath.row == 5) {
            weakSelf.registerModel.work_number = obj;
        } else if (indexPath.row == 6) {
            [weakSelf.view endEditing:YES];
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:regModle.sexModelArr pickerBlock:^(id model) {
                if (model) {
                    weakSelf.registerModel.sexModel = (SexModel *)model;
                    cell.content = weakSelf.registerModel.sexModel.sex_name;
                }
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        } else if (indexPath.row == 7) {
            weakSelf.registerModel.password = obj;
        } else if (indexPath.row == 8) {
            weakSelf.registerModel.password_confirm = obj;
        } else if (indexPath.row == 9) {
            weakSelf.registerModel.code = obj;
        }
    }];
    if (indexPath.row == 9) {
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
- (UITableView *)registerTableV {
    if (!_registerTableV) {
        _registerTableV = [[UITableView alloc] init];
        _registerTableV.delegate = self;
        _registerTableV.dataSource = self;
        _registerTableV.showsVerticalScrollIndicator = NO;
        _registerTableV.showsHorizontalScrollIndicator = NO;
        _registerTableV.bounces = NO;
        _registerTableV.rowHeight = 44;
        _registerTableV.tableFooterView = self.registerFooterView;
        _registerTableV.backgroundColor = [UIColor clearColor];
        _registerTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_registerTableV registerClass:[RegisterTableViewCell01 class] forCellReuseIdentifier:RegisterTableViewCell01ID];
        [_registerTableV registerClass:[RegisterTableViewCell02 class] forCellReuseIdentifier:RegisterTableViewCell02ID];
        [_registerTableV registerClass:[RegisterTableViewCell03 class] forCellReuseIdentifier:RegisterTableViewCell03ID];
        [_registerTableV registerClass:[RegisterTableViewCell04 class] forCellReuseIdentifier:RegisterTableViewCell04ID];
    }
    return _registerTableV;
}
- (UIView *)registerFooterView {
    if (!_registerFooterView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 110)];
        view.backgroundColor = [UIColor color_FFFFFF];
        
        UIButton *registerBtn = [UIButton buttonWithTitle:@"确认修改" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [registerBtn addTarget:self action:@selector(registerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:registerBtn];
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view);
        }];
        _registerFooterView = view;
    }
    return _registerFooterView;
}

@end
