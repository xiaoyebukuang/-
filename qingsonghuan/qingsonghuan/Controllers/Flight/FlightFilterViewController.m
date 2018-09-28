//
//  FlightFilterViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightFilterViewController.h"
#import "CommonTableViewCell.h"
#import "RegNeedInfoModel.h"
#import "XYPickerDateViewController.h"

static NSString * const CommonTableViewCell01ID = @"CommonTableViewCell01ID";
static NSString * const CommonTableViewCell02ID = @"CommonTableViewCell02ID";
/**
 筛选页面
 */
@interface FlightFilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *flightFilterTableV;
//重置&确定view
@property (nonatomic, strong) UIView *footerView;
//重置
@property (nonatomic, strong) UIButton *resetBtn;
//确定
@property (nonatomic, strong) UIButton *sureBtn;
//筛选model
@property (nonatomic, strong) FlightFilterModel *filterModel;
//确定，重置回调
@property (nonatomic, copy) FlilterSelectBlock flilterSelectBlock;

@end

@implementation FlightFilterViewController

- (instancetype)initWithFilterModel:(FlightFilterModel *)filterModel flilterSelectBlock:(FlilterSelectBlock)flilterSelectBlock {
    self = [super init];
    if (self) {
        self.filterModel = [[FlightFilterModel alloc]initWithModel:filterModel];
        self.flilterSelectBlock = flilterSelectBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_99D3F8_3];
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.flightFilterTableV];
    self.flightFilterTableV.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0);
}

#pragma mark -- event
//重置
- (void)resetBtnEvent:(UIButton *)sender {
    if (self.flilterSelectBlock) {
        self.flilterSelectBlock(nil);
    }
}
//确定
- (void)sureBtnEvent:(UIButton *)sender {
    if (self.flilterSelectBlock) {
        self.flilterSelectBlock(self.filterModel);
    }
}
//展示
- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.flightFilterTableV.height = CONTENT_HEIGHT;
    }];
}
//消失
- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.flightFilterTableV.height = 0;
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr = @[@"签到日期:",@"航班号:",@"签到时段:",@"签证信息:",@"字母标识:",@"职务等级:"];
    CommonTableViewCell *cell;
    WeakSelf;
    if (indexPath.row == 0) {
        cell = (CommonTableViewCell01 *)[tableView dequeueReusableCellWithIdentifier: CommonTableViewCell01ID];
        [(CommonTableViewCell01 *)cell reloadViewWithText:titleArr[indexPath.row] placeHolder:FLIGHT_SIGN_DATE content:self.filterModel.sign_date enabled:NO textFieldType:UITextFieldNormal commonClickBlock:^(id obj) {
            [weakSelf.view endEditing:YES];
            XYPickerDateViewController *dateVC = [[XYPickerDateViewController alloc]init];
            dateVC.pickerMode = UIDatePickerModeDate;
            [dateVC reloadViewWithPickerDateBlock:^(NSString *date, BOOL edit) {
                if (edit) {
                    weakSelf.filterModel.sign_date = date;
                    ((CommonTableViewCell01 *)cell).textField.text = date;
                }
            }];
            [weakSelf presentViewController:dateVC animated:YES completion:nil];
        }];
    } else if (indexPath.row == 1) {
        cell = (CommonTableViewCell01 *)[tableView dequeueReusableCellWithIdentifier: CommonTableViewCell01ID];
        [(CommonTableViewCell01 *)cell reloadViewWithText:titleArr[indexPath.row] placeHolder:FLIGHT_AIR_NUMBER content:self.filterModel.airLine enabled:YES textFieldType:UITextFieldFlight commonClickBlock:^(id obj) {
            weakSelf.filterModel.airLine = (NSString *)obj;
        }];
    } else {
        id obj;
        id model;
        switch (indexPath.row) {
            case 2:
                obj = [RegNeedInfoModel sharedInstance].signModelArr;
                model = self.filterModel.signModel;
                break;
            case 3:
                obj = [RegNeedInfoModel sharedInstance].visaModelArr;
                model = self.filterModel.visaModel;
                break;
            case 4:
                obj = [RegNeedInfoModel sharedInstance].wordLogoArr;
                model = self.filterModel.wordLogoModel;
                break;
            case 5:
                obj = [RegNeedInfoModel sharedInstance].dutiesModelArr;
                model = self.filterModel.dutiesModel;
                break;
            default:
                break;
        }
        cell = (CommonTableViewCell02 *)[tableView dequeueReusableCellWithIdentifier: CommonTableViewCell02ID];
        [(CommonTableViewCell02 *)cell reloadViewWithText:titleArr[indexPath.row]  content:obj selectModel:model  commonClickBlock:^(id obj) {
            [weakSelf.view endEditing:YES];
            if ([obj isKindOfClass:[SignModel class]]) {
                weakSelf.filterModel.signModel = obj;
            } else if ([obj isKindOfClass:[VisaModel class]]) {
                weakSelf.filterModel.visaModel = obj;
            } else if ([obj isKindOfClass:[WordLogoModel class]]) {
                weakSelf.filterModel.wordLogoModel = obj;
            } else if ([obj isKindOfClass:[DutiesModel class]]) {
                weakSelf.filterModel.dutiesModel = obj;
            }
        }];
    }
    cell.index = indexPath.row;
    return cell;
}


#pragma mark -- setup
- (UITableView *)flightFilterTableV {
    if (!_flightFilterTableV) {
        _flightFilterTableV = [[UITableView alloc] init];
        _flightFilterTableV.delegate = self;
        _flightFilterTableV.dataSource = self;
        _flightFilterTableV.showsVerticalScrollIndicator = NO;
        _flightFilterTableV.showsHorizontalScrollIndicator = NO;
        _flightFilterTableV.bounces = NO;
        _flightFilterTableV.estimatedRowHeight = 44;
        _flightFilterTableV.backgroundColor = [UIColor clearColor];
        _flightFilterTableV.tableFooterView = self.footerView;
        _flightFilterTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_flightFilterTableV registerClass:[CommonTableViewCell01 class] forCellReuseIdentifier:CommonTableViewCell01ID];
        [_flightFilterTableV registerClass:[CommonTableViewCell02 class] forCellReuseIdentifier:CommonTableViewCell02ID];
    }
    return _flightFilterTableV;
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
