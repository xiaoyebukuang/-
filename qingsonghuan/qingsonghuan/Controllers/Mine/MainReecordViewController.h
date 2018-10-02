//
//  MainReecordViewController.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/1.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"
#import "FlightListModel.h"

@protocol MainReecordViewControllerDelegate <NSObject>

- (void)selectFlightModel:(FlightModel *)model;

@end

@interface MainReecordViewController : BaseMultiViewController

@property (nonatomic, weak) id<MainReecordViewControllerDelegate>delegate;

@end
