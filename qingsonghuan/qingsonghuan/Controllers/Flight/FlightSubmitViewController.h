//
//  FlightSubmitViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"
#import "FlightListModel.h"

@interface FlightSubmitViewController : BaseMultiViewController

@property (nonatomic, strong) FlightModel *flightAddLineModel;

//是否修改
@property (nonatomic, assign) BOOL isEdit;

@end
