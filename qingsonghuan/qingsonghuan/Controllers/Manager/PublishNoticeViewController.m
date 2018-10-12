//
//  PublishNoticeViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/9.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "PublishNoticeViewController.h"
#import "CommonTableViewCell.h"
#import "XYPickerViewController.h"
static NSString * const CommonTableViewCell01ID = @"CommonTableViewCell01ID";
static NSString * const CommonTableViewCell03ID = @"CommonTableViewCell03ID";
static NSString * const CommonTableViewCell04ID = @"CommonTableViewCell04ID";
static NSString * const CommonTableViewCell05ID = @"CommonTableViewCell05ID";

@interface PublishNoticeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *publishTV;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) NSMutableArray *sexModelArr;

@property (nonatomic, strong) SexModel *sexModel;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *messageStr;

@end


@implementation PublishNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布公告";
    [self setupView];
    [self setData];
}
- (void)setupView {
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.publishTV];
    [self.publishTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.bottom.equalTo(self.submitBtn.mas_top);
    }];
}
- (void)setData {
    self.sexModelArr = [NSMutableArray array];
    NSArray *sexArr = @[@{@"sex_name": @"男",@"sex_id":@(1)},
                        @{@"sex_name": @"女",@"sex_id":@(2)},
                        @{@"sex_name": @"全部",@"sex_id":@(3)}];
    for (NSDictionary *subDic in sexArr) {
        SexModel *sexModel = [[SexModel alloc]initWithDic:subDic];
        [self.sexModelArr addObject:sexModel];
    }
}
#pragma mark -- event
- (void)submitBtnEvent:(UIButton *)sender {
    NSString *des;
    if (self.sexModel == nil) {
        des = @"请选择发送人群";
    } else if ([NSString isEmpty:self.titleStr]) {
        des = @"请输入您的标题";
    } else if ([NSString isEmpty:self.messageStr]) {
        des = @"请输入您的内容";
    }
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    NSDictionary *param = @{
                            @"phone": [UserModel sharedInstance].phone,
                            @"sex": self.sexModel.sex_id,
                            @"title": self.titleStr,
                            @"content": self.messageStr
                            };
    [RequestPath statistics_addAnnouncementView:self.view param:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [MBProgressHUD showSuccess:@"发布成功" ToView:self.view completeBlcok:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(ErrorType errorType, NSString *mes) {
        
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr = @[@"发送人群:",@"标题:",@"内容:"];
    CommonTableViewCell *cell;
    WeakSelf;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell01ID];
        [(CommonTableViewCell01 *)cell reloadViewWithText:titleArr[indexPath.row] placeHolder:@"请选择发送人群" content:self.titleStr enabled:NO textFieldType:UITextFieldNormal commonClickBlock:^(id obj) {
            XYPickerViewController *pickerVC = [[XYPickerViewController alloc]init];
            [pickerVC reloadViewWithArr:self.sexModelArr pickerBlock:^(id model) {
                weakSelf.sexModel = (SexModel *)model;
                ((CommonTableViewCell01 *)cell).textField.text = weakSelf.sexModel.sex_name;
            }];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];

        }];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell01ID];
        [(CommonTableViewCell01 *)cell reloadViewWithText:titleArr[indexPath.row] placeHolder:@"请输入标题" content:self.messageStr enabled:YES textFieldType:UITextFieldNormal commonClickBlock:^(id obj) {
            weakSelf.titleStr = (NSString *)obj;
        }];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier: CommonTableViewCell05ID];
        ((CommonTableViewCell05 *)cell).hiddenNumber = YES;
        [((CommonTableViewCell05 *)cell) reloadViewTitle:titleArr[indexPath.row] content:@"" commonClickBlock:^(id obj) {
            weakSelf.messageStr = (NSString *)obj;
        }];
    }
    cell.index = indexPath.row;
    return cell;
}
#pragma mark -- setup
- (UITableView *)publishTV {
    if (!_publishTV) {
        _publishTV = [[UITableView alloc] init];
        _publishTV.delegate = self;
        _publishTV.dataSource = self;
        _publishTV.showsVerticalScrollIndicator = NO;
        _publishTV.showsHorizontalScrollIndicator = NO;
        _publishTV.estimatedRowHeight = 44;
        _publishTV.backgroundColor = [UIColor clearColor];
        _publishTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_publishTV registerClass:[CommonTableViewCell01 class] forCellReuseIdentifier:CommonTableViewCell01ID];
        [_publishTV registerClass:[CommonTableViewCell03 class] forCellReuseIdentifier:CommonTableViewCell03ID];
        [_publishTV registerClass:[CommonTableViewCell04 class] forCellReuseIdentifier:CommonTableViewCell04ID];
        [_publishTV registerClass:[CommonTableViewCell05 class] forCellReuseIdentifier:CommonTableViewCell05ID];
        
    }
    return _publishTV;
}
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithBGImage:@"mail_submit_btn" title:@"发 送" font:SYSTEM_FONT_17 textColor:[UIColor color_FFFFFF]];
        [_submitBtn addTarget:self action:@selector(submitBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
@end
