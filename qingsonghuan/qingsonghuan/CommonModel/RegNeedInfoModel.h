//
//  RegNeedInfoModel.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AirlineModel;
@class DutyModel;
@class VisaModel;
@class SexModel;
@class WordLogoModel;
@class SignModel;
@class DaysModel;

/**
 注册信息Model
 */
@interface RegNeedInfoModel : NSObject

//航空公司数组
@property (nonatomic, strong) NSMutableArray <AirlineModel*> *airlineModelArr;
//职务等级数组
@property (nonatomic, strong) NSMutableArray <DutyModel *> *dutyModelArr;
//签证类型数组
@property (nonatomic, strong) NSMutableArray <VisaModel *> *visaModelArr;
//性别数组
@property (nonatomic, strong) NSMutableArray <SexModel *> *sexModelArr;
//字母标识数组
@property (nonatomic, strong) NSMutableArray <WordLogoModel *> *wordLogoArr;
//签到时段
@property (nonatomic, strong) NSMutableArray <SignModel *> *signModelArr;
//出差天数
@property (nonatomic, strong) NSMutableArray <DaysModel *> *daysModelArr;

/**
 检验是否有数据（航空公司，职务等级。签证类型，性别数组）
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
@property (nonatomic, assign) NSInteger airline_id;
//公司名称
@property (nonatomic, copy) NSString *airline_name;
//子公司数组
@property (nonatomic, strong)NSMutableArray *subsidiaryArr;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 航空子公司
 */
@interface SubsidiaryModel : NSObject
//id
@property (nonatomic, assign) NSInteger subsidiary_Id;
//子公司城市名称
@property (nonatomic, copy) NSString *subsidiary_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 职务等级
 */
@interface DutyModel : NSObject
//id
@property (nonatomic, assign) NSInteger duty_id;
//职务名称
@property (nonatomic, copy) NSString *duty_name;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

/**
 签证类型
 */
@interface VisaModel : NSObject
//id
@property (nonatomic, assign) NSInteger visa_id;
//签证类型名称
@property (nonatomic, copy) NSString *visa_name;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

/**
 性别
 */
@interface SexModel : NSObject

//id
@property (nonatomic, assign) NSInteger sex_id;
//性别名称
@property (nonatomic, copy) NSString *sex_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 字符标识
 */
@interface WordLogoModel : NSObject

//标识id
@property (nonatomic, assign) NSInteger word_logo_id;
//标识名称
@property (nonatomic, copy) NSString *word_logo_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 签到时段Model
 */
@interface SignModel : NSObject

//签到id
@property (nonatomic, assign) NSInteger sign_id;
//签到时段名称
@property (nonatomic, copy) NSString *sign_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

/**
 出差天数
 */
@interface DaysModel : NSObject
//出差天数id
@property (nonatomic, assign) NSInteger days_id;
//出差天数名称
@property (nonatomic, copy) NSString *days_name;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


