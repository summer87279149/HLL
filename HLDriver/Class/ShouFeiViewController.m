//
//  ShouFeiViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ShouFeiViewController.h"

@interface ShouFeiViewController ()
{
    UIScrollView*scrollView;
}
@end

@implementation ShouFeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收费标准";
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenWidth*1703/750);

    [self.view addSubview:scrollView];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"收费标准"];
    imgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*1703/750);
    [scrollView addSubview:imgView];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
