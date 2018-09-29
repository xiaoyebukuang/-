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
        [(CommonTableViewCell01 *)cell reloadViewWithText:titleArr[indexPath.row] placeHolder:placeHolder content:nil enabled:NO textFieldType:UITextFieldNormal commonClickBlock:^(id obj) {
            [weakSelf.view endEditing:YES];
            if (indexPath.row == 0||indexPath.row == 1) {
                XYPickerDateViewController *dateVC = [[XYPickerDateViewController alloc]init];
                dateVC.pickerMode = pickerMode;
                [dateVC reloadViewWithPickerDateBlock:^(NSString *date, BOOL edit) {
                    if (edit) {
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
        [((CommonTableViewCell03 *)cell) reloadViewContent:self.flightAddLineModel.airline_number days:self.flightAddLineModel.daysModel.days_name daysClickBlock:^{
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
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell05ID];
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
        _submitTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_submitTV registerClass:[CommonTableViewCell01 class] forCellReuseIdentifier:CommonTableViewCell01ID];
        [_submitTV registerClass:[CommonTableViewCell03 class] forCellReuseIdentifier:CommonTableViewCell03ID];
        [_submitTV registerClass:[CommonTableViewCell04 class] forCellReuseIdentifier:CommonTableViewCell04ID];
        [_submitTV registerClass:[CommonTableViewCell05 class] forCellReuseIdentifier:CommonTableViewCell05ID];
        
    }
    return _submitTV;
}
@end
