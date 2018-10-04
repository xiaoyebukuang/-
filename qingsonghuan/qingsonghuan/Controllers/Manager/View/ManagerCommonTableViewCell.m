//
//  ManagerCommonTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ManagerCommonTableViewCell.h"

@interface ManagerCommonTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineV01;

@property (nonatomic, strong) UIView *lineV02;

@property (nonatomic, strong) UIView *lableView;

@end

@implementation ManagerCommonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(150);
    }];
    
    [self.contentView addSubview:self.lineV01];
    [self.lineV01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.contentView addSubview:self.lableView];
    [self.lableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineV01.mas_right);
        make.top.bottom.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.lineV02];
    [self.lineV02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lableView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)reloadViewWithModel:(ManagerCommonModel *)commonModel {
    self.titleLabel.text = commonModel.airline_name;
    for (UIView *temp in self.lableView.subviews) {
        [temp removeFromSuperview];
    }
    CGFloat space = 15;
    CGFloat label_height = 20;
    for (int i = 0; i < commonModel.child.count; i ++) {
        ManagerCommonChildModel *childModel = commonModel.child[i];
        UILabel *label = [[UILabel alloc]initWithText:[NSString stringWithFormat:@"%@:%@",childModel.subsidiary_name,childModel.count] font:SYSTEM_FONT_15 textColor:[UIColor color_666666]];
        [self.lableView addSubview:label];
        if (i != commonModel.child.count - 1) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lableView).offset(space);
                make.top.mas_equalTo(i*(label_height + space) + space);
                make.height.mas_equalTo(label_height);
            }];
        } else {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lableView).offset(space);
                make.top.mas_equalTo(i*(label_height + space) + space);
                make.height.mas_equalTo(label_height);
                make.bottom.equalTo(self.lableView).offset(-space);
            }];
        }
    }
}
#pragma mark -- setup

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_17 textColor:[UIColor color_666666]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)lableView {
    if (!_lableView) {
        _lableView = [[UIView alloc]init];
    }
    return _lableView;
}

- (UIView *)lineV01 {
    if (!_lineV01) {
        _lineV01 = [[XYLineView alloc]init];
    }
    return _lineV01;
}

- (UIView *)lineV02 {
    if (!_lineV02) {
        _lineV02 = [[XYLineView alloc]init];
    }
    return _lineV02;
}
@end
