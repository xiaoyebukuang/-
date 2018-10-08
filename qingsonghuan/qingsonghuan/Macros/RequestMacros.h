//
//  RequestMacros.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef RequestMacros_h
#define RequestMacros_h

#define BASE_URL                @"http://47.75.167.95"


//TODO: APP接口

//1.注册页信息 ( 航空公司,子公司,职务,签证 )
#define API_USER_REGNEEDINFO           [NSString stringWithFormat:@"%@/user/regNeedInfo",BASE_URL]
//2.发送手机验证码
#define API_USER_SENDCODE              [NSString stringWithFormat:@"%@/user/sendCode",BASE_URL]
//3.注册
#define API_USER_REGISTER              [NSString stringWithFormat:@"%@/user/register",BASE_URL]
//4.找回密码
#define API_USER_RETRIEVE              [NSString stringWithFormat:@"%@/user/retrieve",BASE_URL]
//5.登录
#define API_USER_LOGIN                 [NSString stringWithFormat:@"%@/user/login",BASE_URL]
//6.获取航段列表
#define API_FLIGHT_GETLISTFLIGHT       [NSString stringWithFormat:@"%@/flight/getListFlight",BASE_URL]
//7.添加航班信息
#define API_FLIGHT_ADDLINE             [NSString stringWithFormat:@"%@/flight/addLine",BASE_URL]
//8.用户站内信列表
#define API_LETTER_MESLIST             [NSString stringWithFormat:@"%@/letter/mesList",BASE_URL]
//9.站内信删除
#define API_LETTER_MESDEL              [NSString stringWithFormat:@"%@/letter/mesDel",BASE_URL]
//10.读站内信
#define API_LETTER_MESSEE              [NSString stringWithFormat:@"%@/letter/mesSee",BASE_URL]
//11.当前用户未读信息数量
#define API_LETTER_ISMES               [NSString stringWithFormat:@"%@/letter/isMes",BASE_URL]
//12.修改航班信息
#define API_FLIGHT_EDITFLIGHT          [NSString stringWithFormat:@"%@/flight/editFlight",BASE_URL]
//13.删除一条航班信息
#define API_FLIGHT_DELFLIGHT           [NSString stringWithFormat:@"%@/flight/delFlight",BASE_URL]
//14.获取当前用户个人信息
#define API_USER_GETUSERINFO           [NSString stringWithFormat:@"%@/user/getUserInfo",BASE_URL]
//15.个人信息修改
#define API_USER_EDITUSERINFO          [NSString stringWithFormat:@"%@/user/editUserInfo",BASE_URL]
//16.发送站内信
#define API_LETTER_MESSEND             [NSString stringWithFormat:@"%@/letter/mesSend",BASE_URL]
//17.添加建议
#define API_ADVICE_ADDADVIC            [NSString stringWithFormat:@"%@/advice/addAdvice",BASE_URL]
//18.获取公告列表
#define API_ANNOUNCEMENT_LIST          [NSString stringWithFormat:@"%@/announcement/getList",BASE_URL]




//TODO: 后台接口
//1.注册人数统计
#define API_STATISTICS_USERSTA         [NSString stringWithFormat:@"%@/statistics/userStatistics",BASE_URL]
//2.根据设备统计人数
#define API_STATISTICS_EQUIPMENTSTA    [NSString stringWithFormat:@"%@/statistics/equipmentStatistics",BASE_URL]
//3.建议列表
#define API_STATISTICS_GETADVICELIST   [NSString stringWithFormat:@"%@/statistics/getAdviceList",BASE_URL]
//4.用户列表
#define API_STATISTICS_GETUSERLIST     [NSString stringWithFormat:@"%@/statistics/getUserList",BASE_URL]
//5.删除，注销，取消注销接口
#define API_STATISTICS_EDITUSERSTATUS  [NSString stringWithFormat:@"%@/statistics/editUserStatus",BASE_URL]
//6.航班统计
#define API_STATISTICS_FLIGHTSTA       [NSString stringWithFormat:@"%@/statistics/flightStatistics",BASE_URL]
//7.站内信统计
#define API_STATISTICS_LETTERSTA       [NSString stringWithFormat:@"%@/statistics/letterStatistics",BASE_URL]





#endif /* RequestMacros_h */
