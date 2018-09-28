//
//  FlightFilterModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "FlightFilterModel.h"

@implementation FlightFilterModel

- (instancetype)initWithModel:(FlightFilterModel *)filterModel {
    self = [super init];
    if (self) {
        self.sign_date = filterModel.sign_date;
        self.airLine = filterModel.airLine;
        self.signModel = filterModel.signModel;
        self.visaModel = filterModel.visaModel;
        self.wordLogoModel = filterModel.wordLogoModel;
        self.dutiesModel = filterModel.dutiesModel;
    }
    return self;
}

@end
