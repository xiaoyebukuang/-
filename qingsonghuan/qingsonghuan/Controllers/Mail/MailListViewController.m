//
//  MailListViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/29.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MailListViewController.h"
#import "MailListTableViewCell.h"
#import "MailListModel.h"
#import "MJRefreshControl.h"
#import "MailReadViewController.h"

static NSString * const MailListTableViewCellID = @"MailListTableViewCellID";

@interface MailListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mailListTableV;

//是否请求中
@property (nonatomic, assign) BOOL isRequest;

//编辑按钮
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIView *footerView;

//删除的个数
@property (nonatomic, assign) NSInteger today_del;
//数据源
@property (nonatomic, strong) MailListModel *mailListModel;
//多选时删除数组
@property (nonatomic, strong) NSMutableArray<MailModel *> *deleteArr;
//选中的indexPath
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *indexPathArr;

//选中跳转的index
@property (nonatomic, strong) NSIndexPath *select_indexPath;
@end

@implementation MailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"站内信";
    self.today_del = 0;
    self.mailListModel = [[MailListModel alloc]init];
    self.deleteArr = [[NSMutableArray alloc]init];
    self.indexPathArr = [[NSMutableArray alloc]init];
    [self setupUI];
    [self setNavigationBar];
    [self setupData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasReadMail) name:NOTIFICATION_MAIL_READ object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)setNavigationBar {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
    UIBarButtonItem *rightNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[rightButtonItem, rightNagetiveSpacer];
}
- (void)setupUI {
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.mailListTableV];
    [self.mailListTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
    
}
- (void)setupData {
    WeakSelf;
    [MJRefreshControl addRefreshControlWithScrollView:self.mailListTableV headerBlock:^{
        [weakSelf getLetterMesList:YES];
    } footerBlock:^{
        [weakSelf getLetterMesList:NO];
    }];
    [MJRefreshControl beginRefresh:self.mailListTableV];
}
#pragma mark -- request
//已经读取
- (void)hasReadMail {
    self.mailListModel.listArr[self.select_indexPath.row].is_read = YES;
    [self.mailListTableV reloadRowsAtIndexPaths:@[self.select_indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//请求数据
- (void)getLetterMesList:(BOOL)refresh {
    if (self.isRequest) {
        return;
    }
    self.isRequest = YES;
    NSDictionary *param = @{
                            @"page": refresh ? @(1):@(self.mailListModel.page + 1),
                            @"limit":@(20),
                            @"today_del":@(self.today_del)
                            };
    [RequestPath letter_mesListParam:param success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        self.isRequest = NO;
        [self.mailListModel reloadDataDic:obj refresh:refresh];
        [MJRefreshControl endRefresh:self.mailListTableV];
        [self.mailListTableV reloadData];
        if (!self.mailListModel.isContinue) {
            [MJRefreshControl endRefreshNoData:self.mailListTableV];
        }
        if (refresh) {
            self.today_del = 0;
        }
        [self.deleteArr removeAllObjects];
        [self.indexPathArr removeAllObjects];
    } failure:^(ErrorType errorType, NSString *mes) {
        self.isRequest = NO;
        [MJRefreshControl endRefresh:self.mailListTableV];
    }];
}
//失败是否删除
- (void)letterMesDeleteRemove:(BOOL)remove{
    if (self.deleteArr.count == 0 || self.isRequest) {
        return;
    }
    NSMutableString *letter_id = [[NSMutableString alloc]init];
    for (int i = 0; i < self.deleteArr.count; i ++) {
        MailModel *model = self.deleteArr[i];
        if (i == 0) {
            [letter_id appendString:model.letter_id];
        } else {
            [letter_id appendFormat:@",%@",model.letter_id];
        }
    }
    [RequestPath letter_mesdelView:self.view param:@{@"letter_id":letter_id} success:^(NSDictionary *obj, NSInteger code, NSString *mes) {
        [self.mailListModel.listArr removeObjectsInArray:self.deleteArr];
        [self.mailListTableV deleteRowsAtIndexPaths:self.indexPathArr withRowAnimation:UITableViewRowAnimationFade];
        self.today_del = self.deleteArr.count + self.today_del;
        [self.deleteArr removeAllObjects];
        [self.indexPathArr removeAllObjects];
        [MBProgressHUD showSuccess:@"删除成功" ToView:self.view];
    } failure:^(ErrorType errorType, NSString *mes) {
        if (remove) {
            [self.deleteArr removeAllObjects];
            [self.indexPathArr removeAllObjects];
        }
    }];
}
#pragma mark -- event
//编辑
- (void)editBtnEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected && self.mailListTableV.editing) {
        [self.mailListTableV setEditing:NO animated:NO];
    }
    [self.deleteArr removeAllObjects];
    [self.indexPathArr removeAllObjects];
    [self.mailListTableV setEditing:sender.selected animated:YES];
    if (sender.selected) {
        //选中
        [UIView animateWithDuration:0.3 animations:^{
            self.footerView.top = CONTENT_HEIGHT - self.footerView.height;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.footerView.top = CONTENT_HEIGHT;
        }];
    }
}
//全部标记
- (void)allSelectBtnEvent:(UIButton *)sender {
    [self.deleteArr removeAllObjects];
    [self.indexPathArr removeAllObjects];
    for (int i = 0; i< self.mailListModel.listArr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.mailListTableV selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.indexPathArr addObject:indexPath];
    }
    [self.deleteArr addObjectsFromArray:self.mailListModel.listArr];
}
//删除按钮
- (void)deleteBtnEvent:(UIButton *)sender {
    [self letterMesDeleteRemove:NO];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mailListModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: MailListTableViewCellID];
    [cell reloadDataWithMailModel:self.mailListModel.listArr[indexPath.row]];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editBtn.selected) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中数据
    if (tableView.editing) {
        [self.deleteArr addObject:self.mailListModel.listArr[indexPath.row]];
        [self.indexPathArr addObject:indexPath];
    } else {
        self.select_indexPath = indexPath;
        MailModel *model = self.mailListModel.listArr[indexPath.row];
        MailReadViewController *mailReadVC = [[MailReadViewController alloc]init];
        mailReadVC.letter_id = model.letter_id;
        [self.navigationController pushViewController:mailReadVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中
    if (tableView.editing) {
        [self.deleteArr removeObject:self.mailListModel.listArr[indexPath.row]];
        [self.indexPathArr removeObject:indexPath];
    }
}
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.deleteArr removeAllObjects];
        [self.indexPathArr removeAllObjects];
        [self.deleteArr addObject:self.mailListModel.listArr[indexPath.row]];
        [self.indexPathArr addObject:indexPath];
        [self letterMesDeleteRemove:YES];
    }
    
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


#pragma mark -- setup
- (UITableView *)mailListTableV{
    if (!_mailListTableV) {
        _mailListTableV = [[UITableView alloc] init];
        _mailListTableV.delegate = self;
        _mailListTableV.dataSource = self;
        _mailListTableV.rowHeight = 70;
        _mailListTableV.showsVerticalScrollIndicator = NO;
        _mailListTableV.showsHorizontalScrollIndicator = NO;
        _mailListTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mailListTableV registerClass:[MailListTableViewCell class] forCellReuseIdentifier:MailListTableViewCellID];
    }
    return _mailListTableV;
}
- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithTitle:@"编辑" selectTitle:@"取消" font:SYSTEM_FONT_17 titleColor:[UIColor color_FFFFFF]];
        [_editBtn addTarget:self action:@selector(editBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT, MAIN_SCREEN_WIDTH, 50 + NAV_BOTTOW_HEIGHT)];
        view.backgroundColor = [UIColor color_FFFFFF];
        _footerView = view;
        
        UIButton *allSelectBtn = [UIButton buttonWithTitle:@"全部标记" font:SYSTEM_FONT_17 titleColor:[UIColor color_666666]];
        [allSelectBtn addTarget:self action:@selector(allSelectBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:allSelectBtn];
        [allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(CELL_LEFT_APACE);
            make.top.equalTo(view).offset(10);
            make.width.mas_offset(70);
            make.height.mas_offset(30);
        }];
        
        UIButton *deleteBtn = [UIButton buttonWithTitle:@"删除" font:SYSTEM_FONT_17 titleColor:[UIColor color_666666]];
        [deleteBtn addTarget:self action:@selector(deleteBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-CELL_LEFT_APACE);
            make.top.width.height.equalTo(allSelectBtn);
        }];
    }
    return _footerView;
}
@end
