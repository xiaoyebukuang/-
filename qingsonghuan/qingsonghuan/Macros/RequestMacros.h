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








#endif /* RequestMacros_h */
