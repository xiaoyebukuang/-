//
//  MailReadViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailReadViewController.h"
#import "MailReadlHeaderView.h"
#import "MailFlightView.h"
#import "MailReadModel.h"
#import "FlightListDetailViewController.h"
#import "MailWriteViewController.h"
@interface MailReadViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MailReadlHeaderView *headerView;

@property (nonatomic, strong) UIView *footerView;

//自己的航班
@property (nonatomic, strong) MailFlightView *topMailFlightView;
//对方的航班
@property (nonatomic, strong) MailFlightView *bottomMailFlightView;

//数据源
@property (nonatomic, strong) MailReadModel *mailReadModel;

@end

@implementation MailReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"读站内信";
    [self setupUI];
    [self getLetterMesSee];
}
- (void)setupUI {
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
    
    [self.scrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.scrollView);
    }];
    
    [self.scrollView addSubview:self.topMailFlightView];
    [self.topMailFlightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    [self.scrollView addSubview:self.bottomMailFlightView];
    [self.bottomMailFlightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.topMailFlightView.mas_bottom);
        make.bottom.equalTo(self.scrollView);
    }];
    WeakSelf;
    self.topMailFlightView.mailFlightViewBlock = ^{
        if (weakSelf.mailReadModel.receiveModel) {
            FlightListDetailViewController *VC = [[FlightListDetailViewController alloc]init];
            VC.flightModel = weakSelf.mailReadModel.receiveModel;
            VC.readMail = YES;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
    self.bottomMailFlightView.mailFlightViewBlock = ^{
        if (weakSelf.mailReadModel.sendModel) {
            FlightListDetailViewController *VC = [[FlightListDetailViewController alloc]init];
            VC.flightModel = weakSelf.mailReadModel.sendModel;
            VC.readMail = YES;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
}
//读站内信
- (void)getLetterMesSee {
    [RequestPath letter_messeeView:self.view param:@{@"letter_id": [NSString safe_string:self.letter_id]} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        //发送读站内信通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MAIL_READ object:nil];
        
        self.mailReadModel = [[MailReadModel alloc]initWithDic:obj];
        self.headerView.readModel = self.mailReadModel;
        //自己的航班
        self.topMailFlightView.flightModel = self.mailReadModel.receiveModel;
        //对方的航班
        self.bottomMailFlightView.flightModel = self.mailReadModel.sendModel;
    } failure:^(ErrorType errorType, NSString *mes) {
        WeakSelf;
        [self showErrorView:^{
            [weakSelf getLetterMesSee];
        }];
    }];
}
#pragma mark -- event
- (void)mailWriteBtnEvent:(UIButton *)sender {
    MailWriteViewController *mwVC = [[MailWriteViewController alloc]init];
    mwVC.receiveModel = self.mailReadModel.sendModel;
    mwVC.sendModel = self.mailReadModel.receiveModel;
    mwVC.isEditFlight = NO;
    [self.navigationController pushViewController:mwVC animated:YES];
}
#pragma mark -- setup
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}
- (MailReadlHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MailReadlHeaderView alloc]init];
    }
    return _headerView;
}
- (MailFlightView *)topMailFlightView {
    if (!_topMailFlightView) {
        _topMailFlightView = [[MailFlightView alloc]init];
        _topMailFlightView.bgColor = [UIColor color_f7f8fa];
        _topMailFlightView.title = @"对方想换您的:";
    }
    return _topMailFlightView;
}
- (MailFlightView *)bottomMailFlightView {
    if (!_bottomMailFlightView) {
        _bottomMailFlightView = [[MailFlightView alloc]init];
        _bottomMailFlightView.bgColor = [UIColor color_FFFFFF];
        _bottomMailFlightView.title = @"对方用这个航班与您互换:";
    }
    return _bottomMailFlightView;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]init];
        UIButton *tel = [UIButton buttonWithBGImage:@"filter_detail_btn_bg" image:@"filter_detail_tel" title:@"拨号" font:SYSTEM_FONT_17 textColor:[UIColor color_FFFFFF]];
        [view addSubview:tel];
        [tel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(view);
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2 - 2);
        }];
        
        UIButton *mail = [UIButton buttonWithBGImage:@"filter_detail_btn_bg" image:@"filter_detail_mail" title:@"站内信" font:SYSTEM_FONT_17 textColor:[UIColor color_FFFFFF]];
        [mail addTarget:self action:@selector(mailWriteBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:mail];
        [mail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(view);
            make.width.equalTo(tel);
        }];
        _footerView = view;
    }
    return _footerView;
}
@end
