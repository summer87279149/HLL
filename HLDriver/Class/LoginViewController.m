//
//  LoginViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "RegistViewController.h"
#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"登入";
  
}

- (IBAction)getVerifyCode:(UIButton *)sender {
    if([UserTool isValidateMobile:_phoneNum.text]){
        [UserTool codeCountDownTimerWith:sender];
    }else{
        [MBProgressHUD showError:@"请输入正确的手机号"];
    }
}
- (IBAction)loginBtnClicked:(UIButton *)sender {
    if (_verifyCode.text.length==0) {
        [MBProgressHUD showError:@"信息不完整"];
    }else{
        
    }
}

- (IBAction)goToRegist:(UIButton *)sender {
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
