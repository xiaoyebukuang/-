//
//  GuidePageViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "GuidePageViewController.h"
#import "AppDelegate.h"
@interface GuidePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setData];
}
- (void)setupView {
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-NAV_TABBAR_HEIGHT);
        make.height.mas_equalTo(30);
    }];
    
    
}
- (void)setData {
    NSMutableArray *imagesArr = [NSMutableArray array];
    if (IS_IPHONE_4) {
        [imagesArr addObjectsFromArray:@[@"640×960_01",@"640×960_02",@"640×960_03",@"640×960_04"]];
    } else if (IS_IPHONE_5) {
        [imagesArr addObjectsFromArray:@[@"640×1136_01",@"640×1136_02",@"640×1136_03",@"640×1136_04"]];
    } else if (IS_IPHONE_678) {
        [imagesArr addObjectsFromArray:@[@"750×1334_01",@"750×1334_02",@"750×1334_03",@"750×1334_04"]];
    } else if (IS_IPHONE_678_PLUS) {
        [imagesArr addObjectsFromArray:@[@"1242×2208_01",@"1242×2208_02",@"1242×2208_03",@"1242×2208_04"]];
    } else {
        [imagesArr addObjectsFromArray:@[@"1125×2436_01",@"1125×2436_02",@"1125×2436_03",@"1125×2436_04"]];
    }
    for (int i = 0; i < imagesArr.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagesArr[i]]];
        [self.scrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(self.scrollView);
            make.left.equalTo(self.scrollView).offset(i * MAIN_SCREEN_WIDTH);
        }];
    }
    [self.scrollView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(NAV_STA_HEIGHT);
        make.left.equalTo(self.scrollView).offset(MAIN_SCREEN_WIDTH*imagesArr.count - 100);
        make.height.mas_equalTo(44);
    }];
    self.scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH * imagesArr.count, MAIN_SCREEN_HEIGHT);
    _pageControl.numberOfPages = imagesArr.count;
}
- (void)loginBtnEvent:(UIButton *)btn {
    [kApplicationDelegate setRootViewControoler];
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = currentPage;
}
#pragma mark -- setup
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor color_99D3F8];
        _pageControl.pageIndicatorTintColor = [UIColor color_ABABAB];
    }
    return _pageControl;
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithTitle:@"立即体验>>" font:SYSTEM_FONT_15 titleColor:[UIColor color_99D3F8]];
        [_loginBtn addTarget:self action:@selector(loginBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
@end
