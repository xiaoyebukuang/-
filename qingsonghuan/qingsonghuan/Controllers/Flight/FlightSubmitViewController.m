//
//  FlightSubmitViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightSubmitViewController.h"
#import "CommonTableViewCell.h"
#import "XYPickerDateViewController.h"
#import "XYPickerViewController.h"
#import "FlightAddLineModel.h"
static NSString * const CommonTableViewCell01ID = @"CommonTableViewCell01ID";
static NSString * const CommonTableViewCell03ID = @"CommonTableViewCell03ID";
static NSString * const CommonTableViewCell04ID = @"CommonTableViewCell04ID";
static NSString * const CommonTableViewCell05ID = @"CommonTableViewCell05ID";
/**
 上传航班
 */
@interface FlightSubmitViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *submitTV;

@property (nonatomic, strong) FlightAddLineModel *flightAddLineModel;

@property (nonatomic, strong) UIView *footerView;


@end

@implementation FlightSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传航班";
    self.flightAddLineModel = [[FlightAddLineModel alloc]init];
    [self setupView];
    [self reuqestData];
}
- (void)setupView {
    [self.view addSubview:self.submitTV];
    [self.submitTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)reuqestData {
    if (![RegNeedInfoModel checkRegData]) {
        [RequestPath user_regNeedInfoView:nil success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
            //成功
            [self.submitTV reloadData];
        } failure:^(ErrorType errorType, NSString *mes) {
            //失败
            WeakSelf;
            [self showErrorView:^{
                [weakSelf reuqestData];
            }];
        }];
    }
}
#pragma mark -- event
- (void)sureBtnEvent:(UIButton *)sender {
    NSString *des = [self.flightAddLineModel checkAddLine];
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    NSDictionary *param = @{
                            @"sign_date":@(self.flightAddLineModel.sign_date),
                            @"sign_time":self.flightAddLineModel.sign_time,
                            @"airline_number":self.flightAddLineModel.airline_number,
                            @"leg_info":[self dataToJson:self.flightAddLineModel.leg_info],
                            @"visa_id":@(self.flightAddLineModel.visaModel.visa_id),
                            @"word_logo_id":@(self.flightAddLineModel.wordLogoModel.word_logo_id),
                            @"duty_id":@(self.flightAddLineModel.dutyModel.duty_id),
                            @"message":[NSString safe_string:self.flightAddLineModel.message],
                            @"days_id":@(self.flightAddLineModel.daysModel.days_id),
                            @"user_id":[UserModel sharedInstance].userId
                            };
    [RequestPath flight_addlineView:self.view param:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"上传成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
///data转json
- (NSString *)dataToJson:(id)theData {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if ([jsonString length] > 0 && error == nil){
        return jsonString;
    }else{
        return @"";
    }
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr = @[@"签到日期:",@"签到时间:",@"航班号:",@"航段信息:",@"签证信息:",@"字母标识:",@"职务等级:",@"留言信息:"];
    CommonTableViewCell *cell;
    WeakSelf;
    RegNeedInfoModel *regModle = [RegNeedInfoModel sharedInstance];
    if (indexPath.row == 0||indexPath.row == 1||indexPath.row == 4||indexPath.row == 5||indexPath.row == 6) {
        NSString *placeHolder;
        UIDatePickerMode pickerMode = UIDatePickerModeDate;
        NSString *content;
        NSArray *arr;
        switch (indexPath.row) {
            case 0:
                placeHolder = FLIGHT_SIGN_DATE;
                pickerMode = UIDatePickerModeDate;
                content = self.flightAddLineModel.date;
                break;
            case 1:
                placeHolder = FLIGHT_SIGN_TIME;
                pickerMode = UIDatePickerModeTime;
                content = self.flightAddLineModel.sign_time;
                break;
            case 4:
                placeHolder = LOGIN_VISA_PLACEHOLDER;
                arr = regModle.visaModelArr;
                content = self.flightAddLineModel.visaModel.visa_name;
                break;
            case 5:
                placeHolder = FLIGHT_WORD_SIGN;
                arr = regModle.wordLogoArr;
                content = self.flightAddLineModel.wordLogoModel.word_logo_name;
                break;
            case 6:
                placeHolder = LOGIN_POST_PLACEHOLDER;
                arr = regModle.dutyModelArr;
                content = self.flightAddLineModel.dutyModel.duty_name;
                break;
            default:
                break;
        }
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell01ID];
        [(CommonTableViewCell01 *)cell reloadViewWithText:titleArr[indexPath.row] placeHolder:placeHolder content:content enabled:NO textFieldType:UITextFieldNormal commonClickBlock:^(id obj) {
            [weakSelf.view endEditing:YES];
            if (indexPath.row == 0||indexPath.row == 1) {
                XYPickerDateViewController *dateVC = [[XYPickerDateViewController alloc]init];
                dateVC.pickerMode = pickerMode;
                [dateVC reloadViewWithPickerDateBlock:^(NSString *date, BOOL edit) {
                    if (edit) {
                        if (indexPath.row == 0) {
                            weakSelf.flightAddLineModel.date = date;
                            weakSelf.flightAddLineModel.sign_date = [NSDate getDateStample:date formatType:FormatyyyyMd];
                        } else {
                            weakSelf.flightAddLineModel.sign_time = date;
                        }
                        ((CommonTableViewCell01 *)cell).textField.text = date;
                    }
                }];
                [weakSelf presentViewController:dateVC animated:YES completion:nil];
            } else {
                XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
                [pickerVC reloadViewWithArr:arr pickerBlock:^(id model) {
                    if (indexPath.row == 4) {
                        weakSelf.flightAddLineModel.visaModel = (VisaModel *)model;
                        ((CommonTableViewCell01 *)cell).textField.text = ((VisaModel *)model).visa_name;
                    } else if (indexPath.row == 5) {
                        weakSelf.flightAddLineModel.wordLogoModel = (WordLogoModel *)model;
                        ((CommonTableViewCell01 *)cell).textField.text = ((WordLogoModel *)model).word_logo_name;
                    } else {
                        weakSelf.flightAddLineModel.dutyModel = (DutyModel *)model;
                        ((CommonTableViewCell01 *)cell).textField.text = ((DutyModel *)model).duty_name;
                    }
                }];
                [weakSelf presentViewController:pickerVC animated:YES completion:nil];
            }
        }];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell03ID];
        [((CommonTableViewCell03 *)cell) reloadViewTitle:titleArr[indexPath.row] content:self.flightAddLineModel.airline_number days:self.flightAddLineModel.daysModel.days_name daysClickBlock:^{
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:regModle.daysModelArr pickerBlock:^(id model) {
                    weakSelf.flightAddLineModel.daysModel = (DaysModel *)model;
                    ((CommonTableViewCell03 *)cell).days = ((DaysModel *)model).days_name;
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        } commonClickBlock:^(id obj) {
            weakSelf.flightAddLineModel.airline_number = (NSString *)obj;
        }];
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell04ID];
        [((CommonTableViewCell04 *)cell) reloadViewTitle:titleArr[indexPath.row] content:self.flightAddLineModel.leg_info commonClickBlock:^(id obj) {
            weakSelf.flightAddLineModel.leg_info = (NSArray *)obj;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell05ID];
        [((CommonTableViewCell05 *)cell) reloadViewTitle:titleArr[indexPath.row] content:self.flightAddLineModel.message commonClickBlock:^(id obj) {
            weakSelf.flightAddLineModel.message = (NSString *)obj;
        }];
    }
    cell.index = indexPath.row;
    return cell;
}
#pragma mark -- setup
- (UITableView *)submitTV {
    if (!_submitTV) {
        _submitTV = [[UITableView alloc] init];
        _submitTV.delegate = self;
        _submitTV.dataSource = self;
        _submitTV.showsVerticalScrollIndicator = NO;
        _submitTV.showsHorizontalScrollIndicator = NO;
        _submitTV.estimatedRowHeight = 44;
        _submitTV.backgroundColor = [UIColor clearColor];
        _submitTV.tableFooterView = self.footerView;
        _submitTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_submitTV registerClass:[CommonTableViewCell01 class] forCellReuseIdentifier:CommonTableViewCell01ID];
        [_submitTV registerClass:[CommonTableViewCell03 class] forCellReuseIdentifier:CommonTableViewCell03ID];
        [_submitTV registerClass:[CommonTableViewCell04 class] forCellReuseIdentifier:CommonTableViewCell04ID];
        [_submitTV registerClass:[CommonTableViewCell05 class] forCellReuseIdentifier:CommonTableViewCell05ID];
        
    }
    return _submitTV;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 60)];
        view.backgroundColor = [UIColor color_FFFFFF];
        UIButton *sureBtn = [UIButton buttonWithTitle:@"确定上传" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view);
        }];
        _footerView = view;
    }
    return _footerView;
}

@end
