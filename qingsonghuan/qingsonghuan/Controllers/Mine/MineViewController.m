//
//  MineViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MainReecordViewController.h"
#import "RegisterEditViewController.h"
#import "MineConnectionViewController.h"
#import "NoticeViewController.h"
static NSString * const MineTableViewCellID = @"MineTableViewCellID";

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *footerTableView;
@property (nonatomic, strong) UIView *headerTableView;
//头部view
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UITableView *mineTableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.mineTableView];
    [self.mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if (@available(iOS 11.0,*)) {
        self.mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.height.mas_offset(NAV_BAR_HEIGHT);
    }];
}

#pragma mark -- event
- (void)signOutBtnEvent:(UIButton *)sender {
    [UIAlertViewTool showTitle:@"提示" message:@"是否退出" alertBlock:^(NSString *mes, NSInteger index) {
        if (index == 1) {
            [[UserModel sharedInstance] signOut];
        }
    }];
}
- (void)backBtnEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: MineTableViewCellID];
    NSArray *logo = @[@"main_reecord",@"main_revise",@"main_connection",@"mine_notice",@"main_about"];
    NSArray *titles = @[@"上传记录",@"修改信息",@"联系我们",@"公告",@"关于"];
    [cell reloadViewLogo:logo[indexPath.row] title:titles[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainReecordViewController *reecordVC = [[MainReecordViewController alloc]init];
        [self.navigationController pushViewController:reecordVC animated:YES];
    }
    if (indexPath.row == 1) {
        RegisterEditViewController *registerVC = [[RegisterEditViewController alloc]init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }
    if (indexPath.row == 2) {
        MineConnectionViewController *connectVC = [[MineConnectionViewController alloc]init];
        [self.navigationController pushViewController:connectVC animated:YES];
    }
    if (indexPath.row == 3) {
        NoticeViewController *noticeVC = [[NoticeViewController alloc]init];
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    if (indexPath.row == 4) {
//        JSHAREMessage *message = [JSHAREMessage message];
//        message.text = @"JShare SDK 支持主流社交平台、帮助开发者轻松实现社会化功能！";
//        message.platform = JSHAREPlatformWechatSession;
//        message.mediaType = JSHAREText;
//        [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
//            NSLog(@"分享回调");
//        }];
        
        JSHAREMessage *message = [JSHAREMessage message];
        NSString *imageURL = @"http://img2.3lian.com/2014/f5/63/d/23.jpg";
        NSURL *imageU = [NSURL URLWithString:imageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageU];
        message.mediaType = JSHAREImage;
        message.platform = JSHAREPlatformWechatSession;
        message.image = imageData;
        [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
#pragma mark -- setup
- (UIView *)headerView {
    if (!_headerView) {
        UIView *view = [[UIView alloc]init];
        UILabel *title = [[UILabel alloc]initWithText:@"个人中心" font:SYSTEM_FONT_20 textColor:[UIColor color_FFFFFF]];
        [view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(NAV_STA_HEIGHT);
            make.bottom.equalTo(view);
            make.centerX.equalTo(view);
        }];
        UIButton *backBtn= [UIButton buttonWithImage:@"back"];
        [backBtn addTarget:self action:@selector(backBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.top.equalTo(title);
            make.width.height.mas_offset(44);
        }];
        _headerView = view;
    }
    return _headerView;
}

- (UITableView *)mineTableView{
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc] init];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        _mineTableView.rowHeight = 50;
        _mineTableView.bounces = NO;
        _mineTableView.tableHeaderView = self.headerTableView;
        _mineTableView.tableFooterView = self.footerTableView;
        _mineTableView.showsVerticalScrollIndicator = NO;
        _mineTableView.showsHorizontalScrollIndicator = NO;
        _mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mineTableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:MineTableViewCellID];
    }
    return _mineTableView;
}
- (UIView *)headerTableView {
    if (!_headerTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 200)];
        UIImageView *mineLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_bg"]];
        [view addSubview:mineLogo];
        [mineLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        
        UIImageView *mine_head_bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_head_bg"]];
        [mineLogo addSubview:mine_head_bg];
        [mine_head_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(mineLogo);
            make.top.equalTo(mineLogo).mas_equalTo(90);
        }];
        
        UIImageView *mine_head = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_head"]];
        [mine_head_bg addSubview:mine_head];
        [mine_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(mine_head_bg);
        }];
        _headerTableView = view;
    }
    return _headerTableView;
}
- (UIView *)footerTableView {
    if (!_footerTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor color_FFFFFF];
        UIButton *signOutBtn = [UIButton buttonWithTitle:@"退出" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF] backgroundImage:@"login_btn_bg"];
        [signOutBtn addTarget:self action:@selector(signOutBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:signOutBtn];
        [signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view);
        }];
        _footerTableView = view;
    }
    return _footerTableView;
}

@end
