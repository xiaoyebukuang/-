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
    
    if (!self.dutiesModelArr) {
        self.dutiesModelArr = [[NSMutableArray alloc]init];
        if ([dic[@"duties"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"duties"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    DutiesModel *dutiesModel = [[DutiesModel alloc]initWithDic:subDic];
                    [self.dutiesModelArr addObject:dutiesModel];
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
        NSArray *sexArr = @[@{@"sex_name": @"男",@"id":@(1)},
                            @{@"sex_name": @"女",@"id":@(2)}];
        self.sexModelArr = [[NSMutableArray alloc]init];
        for (NSDictionary *subDic in sexArr) {
            SexModel *sexModel = [[SexModel alloc]initWithDic:subDic];
            [self.sexModelArr addObject:sexModel];
        }
    }
    if (!self.wordLogoArr) {
        self.wordLogoArr = [[NSMutableArray alloc]init];
        if ([dic[@"wordLogo"] isKindOfClass:[NSArray class]]) {
            for (id subDic in dic[@"wordLogo"]) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    WordLogoModel *wordLogoModel = [[WordLogoModel alloc]initWithDic:subDic];
                    [self.wordLogoArr addObject:wordLogoModel];
                }
            }
        }
    }
    
    if (!self.signModelArr) {
        NSArray *sexArr = @[@{@"sign_name": @"上午",@"id":@(1)},
                            @{@"sign_name": @"下午",@"id":@(2)}];
        self.signModelArr = [[NSMutableArray alloc]init];
        for (NSDictionary *subDic in sexArr) {
            SignModel *signModel = [[SignModel alloc]initWithDic:subDic];
            [self.signModelArr addObject:signModel];
        }
    }
}
+ (BOOL)checkRegData {
    RegNeedInfoModel *model = [RegNeedInfoModel sharedInstance];
    return (model.airlineModelArr.count > 0)&(model.dutiesModelArr.count > 0)&(model.visaModelArr.count > 0)&(model.sexModelArr.count > 0)&(model.wordLogoArr.count > 0)&(model.signModelArr.count > 0);
}
@end



@implementation AirlineModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.airlineId =        [NSString safe_integer:dic[@"id"]];
        self.company_name =     [NSString safe_string:dic[@"company_name"]];
        self.subsidiaryArr =    [[NSMutableArray alloc]init];
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
        self.subsidiaryId = [NSString safe_integer:dic[@"id"]];
        self.city =         [NSString safe_string:dic[@"city"]];
    }
    return self;
}
@end

@implementation DutiesModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.dutiesId =     [NSString safe_integer:dic[@"id"]];
        self.job_title =    [NSString safe_string:dic[@"job_title"]];
    }
    return self;
}
@end

@implementation VisaModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.visaId =       [NSString safe_integer:dic[@"id"]];
        self.visa_name =    [NSString safe_string:dic[@"visa_name"]];
    }
    return self;
}
@end

@implementation SexModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.sexId =        [NSString safe_integer:dic[@"id"]];
        self.sex_name =     [NSString safe_string:dic[@"sex_name"]];
    }
    return self;
}
@end

@implementation WordLogoModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.wordLogoID =   [NSString safe_integer:dic[@"id"]];
        self.mark =         [NSString safe_string:dic[@"mark"]];
    }
    return self;
}
@end

@implementation SignModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.signId =       [NSString safe_integer:dic[@"id"]];
        self.sign_name =    [NSString safe_string:dic[@"sign_name"]];
    }
    return self;
}
@end



