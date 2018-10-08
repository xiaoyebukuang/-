//
//  NoticeDetailViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController ()

@property (nonatomic, strong) UIImageView *noticeImageV;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.noticeImageV];
    [self.noticeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.top.equalTo(self.view).offset(CELL_LEFT_APACE);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeImageV.mas_right).offset(10);
        make.top.equalTo(self.noticeImageV);
    }];
    
    [self.view addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.noticeImageV);
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CELL_LEFT_APACE);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.noticeImageV.mas_bottom).offset(40);
    }];
    self.titleLabel.text = @"我是标题";
    self.dateLabel.text = @"2018-10-08 12:10";
    self.contentLabel.text = @"1、等忙完这一阵，就可以接着忙下一阵了。\n2、世上无难事，只要肯放弃。\n3、我的意中人是盖世英雄，有一天他会踩着七色云彩娶别人。\n4、假如生活欺骗了你，不要悲伤，不要心急，反正明天也一样\n5、有时候你不努力一下，你都不知道什么叫绝望。\n6、当你觉得自己又丑又穷的时候，不要悲伤，至少你的判断是对的。\n7、万事开头难，然后中间难，最后结尾难。\n8、岁月是把杀猪刀，可是他拿丑的人一点办法都没有。\n9、上帝是公平的，给你了丑的外表，还会给你低的智商，以免让你显得不协调。\n10、世上99%的事情都能用钱解决，剩下的1%，需要更多钱解决。";
}

#pragma mark -- setup
- (UIImageView *)noticeImageV {
    if (!_noticeImageV) {
        _noticeImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_notice_list"]];
    }
    return _noticeImageV;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_333333]];
    }
    return _titleLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_13 textColor:[UIColor color_999999]];
    }
    return _dateLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_333333]];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
