//
//  ManagerTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ManagerTableViewCell.h"

@interface ManagerTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowLogo;

@property (nonatomic, strong) XYLineView *lineView;
@end

@implementation ManagerTableViewCell

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
        make.left.equalTo(self.contentView).mas_equalTo(CELL_LEFT_APACE);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.arrowLogo];
    [self.arrowLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_equalTo(-CELL_LEFT_APACE);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.arrowLogo);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)reloadViewTitle:(NSString *)title {
    self.titleLabel.text = title;
}
#pragma mark -- setup
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_666666]];
    }
    return _titleLabel;
}


- (UIImageView *)arrowLogo {
    if (!_arrowLogo) {
        _arrowLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_arrow"]];
    }
    return _arrowLogo;
}

- (XYLineView *)lineView {
    if (!_lineView) {
        _lineView = [[XYLineView alloc]init];
    }
    return _lineView;
}
@end
