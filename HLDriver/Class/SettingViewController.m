
//
//  SettingViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/8.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "SettingCenterViewController.h"
#import "AchievementViewController.h"
#import "DriverChannelViewController.h"
#import "MyOrderViewController.h"
#import "WalletViewController.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *zhunDianLv;
@property (weak, nonatomic) IBOutlet UILabel *juDanLv;
@property (weak, nonatomic) IBOutlet UILabel *xinYong;
@property (weak, nonatomic) IBOutlet UIImageView *touXiang;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableview];
}
- (IBAction)backBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showPersonInfo{
    UserInfoViewController *vc = [UserInfoViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView*)headerView{
    if(!_headerView){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"SettingHeaderView" owner:self options:nil][0];
        UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPersonInfo)];
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableHeaderView = self.headerView;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *VC;
    switch (indexPath.row) {
        case 0:{VC = [[WalletViewController alloc]init];}break;
        case 1:{VC = [[MyOrderViewController alloc]init];}break;
        case 2:{VC = [[DriverChannelViewController alloc]init];}break;
        case 3:{VC = [[AchievementViewController alloc]init];}break;
        case 4:{VC = [[SettingCenterViewController alloc]init];}break;
        default: break;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44*k_scale;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellArr) {
        
        cell.imageView.image = [UIImage imageNamed:[self.cellArr[indexPath.row] objectForKey:@"image"]];
        cell.textLabel.text = [self.cellArr[indexPath.row] objectForKey:@"title"];
    }
    
    return cell;
}
-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@{@"image":@"我的钱包",@"title":@"我的钱包"},
                     @{@"image":@"我的订单",@"title":@"我的订单"},
                     @{@"image":@"司机频道",@"title":@"司机频道"},
                     @{@"image":@"我的成就",@"title":@"我的成就"},
                     @{@"image":@"设置中心",@"title":@"设置中心"}];
    }
    return _cellArr;
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
