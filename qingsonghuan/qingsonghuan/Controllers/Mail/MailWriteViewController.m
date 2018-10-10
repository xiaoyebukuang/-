//
//  MailWriteViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailWriteViewController.h"
#import "XYTextView.h"
#import "MailFlightView.h"
#import "FlightListDetailViewController.h"
#import "MainReecordViewController.h"
@interface MailWriteViewController ()<MainReecordViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) XYTextView *textView;

//自己的航班
@property (nonatomic, strong) MailFlightView *topMailFlightView;
//对方的航班
@property (nonatomic, strong) MailFlightView *bottomMailFlightView;

@end

@implementation MailWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写站内信";
    [self setupUI];
    [self setNavigationBar];
}
- (void)setNavigationBar {
    UIButton *submitBtn = [UIButton buttonWithTitle:@"发送" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF]];
    submitBtn.frame = CGRectMake(0, 0, 44, 44);
    [submitBtn addTarget:self action:@selector(submitBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:submitBtn];
    UIBarButtonItem *rightNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[rightButtonItem, rightNagetiveSpacer];
}
- (void)setupUI {
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.scrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.scrollView);
        make.height.mas_equalTo(220);
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
    self.topMailFlightView.flightModel = self.receiveModel;
    self.topMailFlightView.mailFlightViewBlock = ^{
        if (weakSelf.receiveModel) {
            FlightListDetailViewController *VC = [[FlightListDetailViewController alloc]init];
            VC.flightModel = weakSelf.receiveModel;
            VC.readMail = YES;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
    self.bottomMailFlightView.flightModel = self.sendModel;
    self.bottomMailFlightView.mailFlightViewBlock = ^{
        if (weakSelf.sendModel) {
            FlightListDetailViewController *VC = [[FlightListDetailViewController alloc]init];
            VC.flightModel = weakSelf.sendModel;
            VC.readMail = YES;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
    self.bottomMailFlightView.mailAddFlightViewBlock = ^{
        MainReecordViewController *mainReecordVC = [[MainReecordViewController alloc]init];
        mainReecordVC.delegate = weakSelf;
        [weakSelf.navigationController pushViewController:mainReecordVC animated:YES];
    };
}
#pragma mark -- event
//发送站内信
- (void)submitBtnEvent:(UIButton *)sender {
    NSString *des;
    if (!self.sendModel) {
        des = @"请选择您与对方互换的航班";
    } else if ([NSString isEmpty:self.textView.text]) {
        des = @"请输入内容";
    }
    if (des) {
        [MBProgressHUD showError:des ToView:self.view];
        return;
    }
    if (self.sendModel && self.receiveModel) {
        NSDictionary *param = @{
                                @"receive_uid":self.receiveModel.user_id,
                                @"send_flight_id":self.sendModel.flight_id,
                                @"receive_flight_id":self.receiveModel.flight_id,
                                @"content":self.textView.text
                                };
        [RequestPath letter_mesSendView:self.view param:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
            [MBProgressHUD showSuccess:@"发送成功" ToView:self.view completeBlcok:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(ErrorType errorType, NSString *mes) {
            
        }];
    }
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark -- MainReecordViewControllerDelegate
- (void)selectFlightModel:(FlightModel *)model {
    self.sendModel = model;
    self.bottomMailFlightView.flightModel = model;
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
- (UIView *)headerView {
    if (!_headerView) {
        UIView *view = [[UIView alloc]init];
        [view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(CELL_LEFT_APACE);
            make.top.equalTo(view).offset(CELL_LEFT_APACE);
            make.right.equalTo(view).offset(-CELL_LEFT_APACE);
            make.bottom.equalTo(view).offset(-CELL_LEFT_APACE);
        }];
        XYLineView *lineView = [[XYLineView alloc]init];
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(view);
            make.height.mas_equalTo(1);
        }];
        _headerView= view;
    }
    return _headerView;
}
- (MailFlightView *)topMailFlightView {
    if (!_topMailFlightView) {
        _topMailFlightView = [[MailFlightView alloc]init];
        _topMailFlightView.bgColor = [UIColor color_f7f8fa];
        _topMailFlightView.title = @"您想要替换对方哪个航班:";
    }
    return _topMailFlightView;
}
- (MailFlightView *)bottomMailFlightView {
    if (!_bottomMailFlightView) {
        _bottomMailFlightView = [[MailFlightView alloc]init];
        _bottomMailFlightView.bgColor = [UIColor color_FFFFFF];
        _bottomMailFlightView.isEditFlight = self.isEditFlight;
        _bottomMailFlightView.title = @"您想要用哪个航班与对方互换:";
    }
    return _bottomMailFlightView;
}
- (XYTextView *)textView {
    if (!_textView) {
        _textView = [[XYTextView alloc]init];
        _textView.placeHolder = @"请输入内容";
    }
    return _textView;
}
@end
