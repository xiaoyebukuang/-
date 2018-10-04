//
//  DeviceViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "DeviceViewController.h"
#import "DeviceTableViewCell.h"
static NSString * const DeviceTableViewCellID = @"DeviceTableViewCellID";
@interface DeviceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *devcieTableV;

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册人数统计";
    self.listArr = [[NSMutableArray alloc]init];
    [self setupView];
    [self statisticsEquipmentStaRequedt];
}
- (void)setupView {
    [self.view addSubview:self.devcieTableV];
    [self.devcieTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)statisticsEquipmentStaRequedt {
    [RequestPath statistics_equipmentStaView:self.view param:@{@"phone":[UserModel sharedInstance].phone} success:^(NSArray *obj, NSInteger code, NSString *mes) {
        for (NSDictionary *subDic in obj) {
            if ([subDic isKindOfClass:[NSDictionary class]]) {
                NSString *count = [NSString safe_string:subDic[@"count"]];
                NSString *equipment = [NSString safe_string:subDic[@"equipment"]];
                NSString *content = [NSString stringWithFormat:@"%@:%@",equipment,count];
                [self.listArr addObject:content];
            }
        }
        [self.devcieTableV reloadData];
    } failure:^(ErrorType errorType, NSString *mes) {
        WeakSelf;
        [self showErrorView:^{
            [weakSelf statisticsEquipmentStaRequedt];
        }];
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DeviceTableViewCellID];
    [cell reloadViewTitle:self.listArr[indexPath.row]];
    return cell;
}
#pragma mark -- setup
- (UITableView *)devcieTableV{
    if (!_devcieTableV) {
        _devcieTableV = [[UITableView alloc] init];
        _devcieTableV.delegate = self;
        _devcieTableV.dataSource = self;
        _devcieTableV.rowHeight = 50;
        _devcieTableV.showsVerticalScrollIndicator = NO;
        _devcieTableV.showsHorizontalScrollIndicator = NO;
        _devcieTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_devcieTableV registerClass:[DeviceTableViewCell class] forCellReuseIdentifier:DeviceTableViewCellID];
    }
    return _devcieTableV;
}

@end
