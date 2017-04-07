//
//  RegistViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "RegistBaseInfoVC.h"
#import "RegistViewController.h"

@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)getVerifyCode:(UIButton *)sender {
    if([UserTool isValidateMobile:_phoneNum.text]){
        [UserTool codeCountDownTimerWith:sender];
    }else{
        [MBProgressHUD showError:@"请输入正确的手机号"];
    }
}
- (IBAction)next:(UIButton *)sender {
    [self.navigationController pushViewController:[RegistBaseInfoVC new] animated:YES];
    if (_verifyCode.text.length==0) {
        [MBProgressHUD showError:@"信息不完整"];
    }else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
