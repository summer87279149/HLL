//
//  UserInfoViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *BankNum;

@property (weak, nonatomic) IBOutlet UILabel *licencePlate;

@property (weak, nonatomic) IBOutlet UILabel *vehicleType;
@property (weak, nonatomic) IBOutlet UIButton *idCard;
@property (weak, nonatomic) IBOutlet UIButton *licencePlateIMG;

@property (weak, nonatomic) IBOutlet UIButton *drivingLicence;
@property (weak, nonatomic) IBOutlet UIButton *vehicle45Imge;


@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
}
-(void)viewDidLayoutSubviews{
    self.scrollview.contentSize =CGSizeMake(kScreenWidth,836);
}























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
