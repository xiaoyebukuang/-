//
//  AboutViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AboutViewController.h"
#import "ManagerTableViewCell.h"
#import "WebViewController.h"
#import "ShareView.h"
static NSString * const ManagerTableViewCellID = @"ManagerTableViewCellID";
@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *aboutTableView;

@property (nonatomic, strong) NSArray *listArr;

@property (nonatomic, strong) ShareView *shareView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.listArr = @[@"协议与条款",@"分享给好友"];
    [self setupView];
}
- (void)setupView {
    [self.view addSubview:self.aboutTableView];
    [self.aboutTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = @"https://www.jiguang.cn/";
    message.text = @"JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = platform;
    NSString *imageURL = @"http://img2.3lian.com/2014/f5/63/d/23.jpg";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ManagerTableViewCellID];
    [cell reloadViewTitle:self.listArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WebViewController *webVC = [[WebViewController alloc]init];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (indexPath.row == 1) {
        [self.shareView showWithContentType:JSHARELink];
    }
}
#pragma mark -- setup
- (UITableView *)aboutTableView{
    if (!_aboutTableView) {
        _aboutTableView = [[UITableView alloc] init];
        _aboutTableView.delegate = self;
        _aboutTableView.dataSource = self;
        _aboutTableView.rowHeight = 50;
        _aboutTableView.showsVerticalScrollIndicator = NO;
        _aboutTableView.showsHorizontalScrollIndicator = NO;
        _aboutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_aboutTableView registerClass:[ManagerTableViewCell class] forCellReuseIdentifier:ManagerTableViewCellID];
    }
    return _aboutTableView;
}

- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
            [self shareLinkWithPlatform:platform];
        }];
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:_shareView];
    }
    return _shareView;
}

@end
