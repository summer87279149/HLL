//
//  HomeViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "MessageTableViewCell.h"
#import "BaseNavViewController.h"
#import "SettingViewController.h"
#import "UIButton+Layout.h"
#import "UIColor+JKHEX.h"
#import "LBWSwitch.h"
#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *successView;

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellArr;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeNav];
    [self.view addSubview:self.tableview];
    UIView *view = [[NSBundle mainBundle]loadNibNamed:@"BottomView" owner:self options:nil][0];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-5);
        make.height.mas_equalTo(50);
    }];
}
- (IBAction)refuse:(UIButton *)sender {
}
- (IBAction)accept:(UIButton *)sender {
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

#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        _tableview.rowHeight = UITableViewAutomaticDimension;
        _tableview.estimatedRowHeight = 159;
        [_tableview registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MessageTableViewCellID"];
        [_tableview registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OrderTableViewCellID"];
    }
    return _tableview;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 20;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MessageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        return cell;
    }else{
        OrderTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.cellArr.count>0) {
          
        }
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        
    }
}



-(void)makeNav{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
