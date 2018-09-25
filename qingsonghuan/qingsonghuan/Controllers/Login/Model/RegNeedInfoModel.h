//
//  RegNeedInfoModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AirlineModel;
@class DutiesModel;
@class VisaModel;
@class SexModel;

/**
 注册信息Model
 */
@interface RegNeedInfoModel : NSObject

//航空公司数组
@property (nonatomic, strong) NSMutableArray *airlineModelArr;
//职务等级数组
@property (nonatomic, strong) NSMutableArray *dutiesModelArr;
//签证类型数组
@property (nonatomic, strong) NSMutableArray *visaModelArr;
//性别数组
@property (nonatomic, strong) NSMutableArray *sexModelArr;


/**
 检验是否有数据
 YES：有数据
 NO：无数据
 */
+ (BOOL)checkRegData;


//获取单例
+ (RegNeedInfoModel *)sharedInstance;

- (void)reloadWithDic:(NSDictionary *)dic;

@end

/**
 航空公司
 */
@interface AirlineModel : NSObject

//id
@property (nonatomic, assign) NSInteger airlineId;
//公司名称
@property (nonatomic, copy) NSString *company_name;
//子公司数组
@property (nonatomic, strong)NSMutableArray *subsidiaryArr;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 航空子公司
 */
@interface SubsidiaryModel : NSObject
//id
@property (nonatomic, assign) NSInteger subsidiaryId;
//子公司城市名称
@property (nonatomic, copy) NSString *city;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 职务等级
 */
@interface DutiesModel : NSObject
//id
@property (nonatomic, assign) NSInteger dutiesId;
//职务名称
@property (nonatomic, copy) NSString *job_title;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

/**
 签证类型
 */
@interface VisaModel : NSObject
//id
@property (nonatomic, assign) NSInteger visaId;
//签证类型名称
@property (nonatomic, copy) NSString *visa_name;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

/**
 性别
 */
@interface SexModel : NSObject

//id
@property (nonatomic, assign) NSInteger sexId;
//性别名称
@property (nonatomic, copy) NSString *sex_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


