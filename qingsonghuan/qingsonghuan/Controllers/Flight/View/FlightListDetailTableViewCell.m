//
//  FlightListDetailTableViewCell.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightListDetailTableViewCell.h"

@interface FlightListDetailTableViewCell()

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *desL;

@end

@implementation FlightListDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor redColor];
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CELL_LEFT_APACE);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(70);
    }];
    [self addSubview:self.desL];
    [self.desL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL.mas_right);
        make.right.equalTo(self).offset(-CELL_LEFT_APACE);
        make.top.equalTo(self.titleL);
        make.bottom.equalTo(self).offset(-10);
    }];
}
- (void)reloadViewWithIndex:(NSInteger)index title:(NSString *)title content:(NSString *)content {
    if (index%2 == 0) {
        self.backgroundColor = [UIColor color_FFFFFF];
    } else {
        self.backgroundColor = [UIColor color_D5E8F6];
    }
    self.titleL.text = title;
    self.desL.text = [NSString isEmpty:content] ? @" " : content;
}
#pragma mark -- setup
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_666666]];
    }
    return _titleL;
}
- (UILabel *)desL {
    if (!_desL) {
        _desL = [[UILabel alloc]initWithText:@"" font:SYSTEM_FONT_15 textColor:[UIColor color_666666]];
        _desL.numberOfLines = 0;
    }
    return _desL;
}
@end
