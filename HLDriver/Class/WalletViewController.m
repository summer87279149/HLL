//
//  WalletViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "WalletTableViewCell.h"
#import "WalletViewController.h"

@interface WalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *headV;
@property (strong, nonatomic)  UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellArr;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
   
    [self.view addSubview:self.tableview];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(100*k_scale);
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.tableview.mas_top).offset(0);
    }];
    self.title = @"我的余额";
}
- (IBAction)fetchMoney:(UIButton *)sender {
    NSLog(@"11111");
}











-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableHeaderView = self.headerView;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:@"WalletTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WalletTableViewCellID"];
        _tableview.estimatedRowHeight = 130;
        _tableview.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"WalletTableViewCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)headerView{
    if(!_headerView){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"WalletHeaderView" owner:self options:nil][0];
    }
    return _headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
