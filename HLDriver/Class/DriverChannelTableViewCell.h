//
//  DriverChannelTableViewCell.h
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverChannelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
