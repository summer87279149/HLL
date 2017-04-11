//
//  SettingCenterViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "AboutUsViewController.h"
#import "FeedBackViewController.h"
#import "OftenViewController.h"
#import "ShouFeiViewController.h"
#import "ShouZeViewController.h"
#import "SettingCenterViewController.h"

@interface SettingCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *cellArr;
@end

@implementation SettingCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置中心";
    [self.view addSubview:self.tableview];
}





-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:@"WalletTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WalletTableViewCellID"];
        _tableview.estimatedRowHeight = 130;
        _tableview.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:{vc = [ShouZeViewController new]; }break;
        case 1:{vc = [ShouFeiViewController new]; }break;
        case 2:{vc = [OftenViewController new]; }break;
        case 3:{ }break;
        case 4:{vc = [FeedBackViewController new]; }break;
        case 5:{vc = [AboutUsViewController new]; }break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (self.cellArr) {
        cell.textLabel.text = self.cellArr[indexPath.row];
    }
    return cell;
}


-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@"司机守则",@"收费问题",@"常见问题",@"分享",@"意见反馈",@"关于我们"];
    }
    return _cellArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
