//
//  AchievementViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AchievementViewController.h"

@interface AchievementViewController ()
@property (weak, nonatomic) IBOutlet UILabel *avgScore;
@property (weak, nonatomic) IBOutlet UILabel *zhunDianLv;
@property (weak, nonatomic) IBOutlet UILabel *juDanLv;
@property (weak, nonatomic) IBOutlet UILabel *xinYong;

@end

@implementation AchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[NSBundle mainBundle]loadNibNamed:@"AchievementHeadView" owner:self options:nil][0];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 258);
    [self.view addSubview:headerView];
    
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
















-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
