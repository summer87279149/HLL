//
//  VehicleTypeViewController.h
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"

@interface VehicleTypeViewController : BaseViewController
typedef void(^CallBack)(id info);
@property (nonatomic, copy) CallBack callBack;


@end
