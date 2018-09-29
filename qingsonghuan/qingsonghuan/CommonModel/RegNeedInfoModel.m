//
//  RegNeedInfoModel.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegNeedInfoModel.h"


@implementation RegNeedInfoModel
//获取单例
+ (RegNeedInfoModel *)sharedInstance {
    static RegNeedInfoModel *instance;
    RegNeedInfoModel *strongInstance = instance;
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[[self class] alloc] init];
            instance = strongInstance;
        }
    }
    return strongInstance;
}

- (void)reloadWithDic:(NSDictionary *)dic {
    if (!self.airlineModelArr) {
        self.airlineModelArr = [[NSMutableArray alloc]init];
        if ([dic[@"airline"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"airline"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    AirlineModel *airlineModel = [[AirlineModel alloc]initWithDic:subDic];
                    [self.airlineModelArr addObject:airlineModel];
                }
            }
        }
    }
    
    if (!self.dutyModelArr) {
        self.dutyModelArr = [[NSMutableArray alloc]init];
        if ([dic[@"duty"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"duty"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    DutyModel *dutiesModel = [[DutyModel alloc]initWithDic:subDic];
                    [self.dutyModelArr addObject:dutiesModel];
                }
            }
        }
    }
    
    if (!self.visaModelArr) {
        self.visaModelArr = [[NSMutableArray alloc]init];
        if ([dic[@"visa"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"visa"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    VisaModel *visaModel = [[VisaModel alloc]initWithDic:subDic];
                    [self.visaModelArr addObject:visaModel];
                }
            }
        }
    }
    
    if (!self.sexModelArr) {
        NSArray *sexArr = @[@{@"sex_name": @"男",@"sex_id":@(1)},
                            @{@"sex_name": @"女",@"sex_id":@(2)}];
        self.sexModelArr = [[NSMutableArray alloc]init];
        for (NSDictionary *subDic in sexArr) {
            SexModel *sexModel = [[SexModel alloc]initWithDic:subDic];
            [self.sexModelArr addObject:sexModel];
        }
    }
    if (!self.wordLogoArr) {
        self.wordLogoArr = [[NSMutableArray alloc]init];
        if ([dic[@"word_logo"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"word_logo"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    WordLogoModel *wordLogoModel = [[WordLogoModel alloc]initWithDic:subDic];
                    [self.wordLogoArr addObject:wordLogoModel];
                }
            }
        }
    }
    
    if (!self.signModelArr) {
        NSArray *sexArr = @[@{@"sign_name": @"上午",@"sign_id":@(1)},
                            @{@"sign_name": @"下午",@"sign_id":@(2)}];
        self.signModelArr = [[NSMutableArray alloc]init];
        for (NSDictionary *subDic in sexArr) {
            SignModel *signModel = [[SignModel alloc]initWithDic:subDic];
            [self.signModelArr addObject:signModel];
        }
    }
    if (!self.daysModelArr) {
        self.daysModelArr = [[NSMutableArray alloc]init];
        if ([dic[@"days"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"days"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    DaysModel *daysModel = [[DaysModel alloc]initWithDic:subDic];
                    [self.daysModelArr addObject:daysModel];
                }
            }
        }
    }
}
+ (BOOL)checkRegData {
    RegNeedInfoModel *model = [RegNeedInfoModel sharedInstance];
    return (model.airlineModelArr.count > 0)&(model.dutyModelArr.count > 0)&(model.visaModelArr.count > 0)&(model.sexModelArr.count > 0)&(model.wordLogoArr.count > 0)&(model.signModelArr.count > 0)&(model.daysModelArr.count > 0);
}
@end



@implementation AirlineModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.airline_id =        [NSString safe_integer:dic[@"airline_id"]];
        self.airline_name =      [NSString safe_string:dic[@"airline_name"]];
        self.subsidiaryArr =     [[NSMutableArray alloc]init];
        if ([dic[@"subsidiary"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *subDic in dic[@"subsidiary"]) {
                SubsidiaryModel *model = [[SubsidiaryModel alloc]initWithDic:subDic];
                [self.subsidiaryArr addObject:model];
            }
        }
    }
    return self;
}
@end

@implementation SubsidiaryModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.subsidiary_Id =           [NSString safe_integer:dic[@"subsidiary_Id"]];
        self.subsidiary_name =         [NSString safe_string:dic[@"subsidiary_name"]];
    }
    return self;
}
@end

@implementation DutyModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.duty_id =      [NSString safe_integer:dic[@"duty_id"]];
        self.duty_name =    [NSString safe_string:dic[@"duty_name"]];
    }
    return self;
}
@end

@implementation VisaModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.visa_id =       [NSString safe_integer:dic[@"visa_id"]];
        self.visa_name =     [NSString safe_string:dic[@"visa_name"]];
    }
    return self;
}
@end

@implementation SexModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.sex_id =        [NSString safe_integer:dic[@"sex_id"]];
        self.sex_name =      [NSString safe_string:dic[@"sex_name"]];
    }
    return self;
}
@end

@implementation WordLogoModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.word_logo_id =          [NSString safe_integer:dic[@"word_logo_id"]];
        self.word_logo_name =        [NSString safe_string:dic[@"word_logo_name"]];
    }
    return self;
}
@end

@implementation SignModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.sign_id =       [NSString safe_integer:dic[@"sign_id"]];
        self.sign_name =     [NSString safe_string:dic[@"sign_name"]];
    }
    return self;
}
@end

@implementation DaysModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.days_id =       [NSString safe_integer:dic[@"days_id"]];
        self.days_name =     [NSString safe_string:dic[@"days_name"]];
    }
    return self;
}
@end


