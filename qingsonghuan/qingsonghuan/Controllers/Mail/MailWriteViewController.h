//
//  MailWriteViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

#import "FlightListModel.h"

@interface MailWriteViewController : BaseMultiViewController

//是否可以编辑航班
@property (nonatomic, assign) BOOL isEditFlight;

//发件人Model
@property (nonatomic, strong)FlightModel *sendModel;
//收件人Model
@property (nonatomic, strong)FlightModel *receiveModel;

@end
