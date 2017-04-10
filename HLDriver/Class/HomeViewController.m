//
//  HomeViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "BaseNavViewController.h"
#import "SettingViewController.h"
#import "UIButton+Layout.h"
#import "UIColor+JKHEX.h"
#import "LBWSwitch.h"
#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *successView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LBWSwitch * lee = [[LBWSwitch alloc] initWithFrame:CGRectMake(0,0, 85, 30)];
    lee.onColor =[UIColor jk_colorWithHexString:@"FEA101"];
    [lee setFunnySwitchDidSelectedBlock:^(BOOL isOn) {
        if (isOn)
        {
            NSLog(@"hahahaha");
        }else{
            
        }
    }];
    UIImageView *rightImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"人"]];
    rightImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightItemClicked)];
    [rightImgView addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:lee];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightImgView];
    
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"我的XX" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:19 weight:50];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake( 0, 0, 100, 30);
    self.navigationItem.titleView = cancelBtn;
}
- (IBAction)mainBtnClicked:(UIButton *)sender {
    self.mainView.hidden = YES;
    self.successView.hidden = NO;
}

-(void)rightItemClicked{
    SettingViewController*vc=[SettingViewController new];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:vc];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nav animated:YES completion:nil];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
