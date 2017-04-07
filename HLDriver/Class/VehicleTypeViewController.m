//
//  VehicleTypeViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "VehicleTypeViewController.h"

@interface VehicleTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UITableView *tableview2;
@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, strong) NSArray *cellArr2;//存放右边tableview2的数据
@property (nonatomic, strong) NSArray *cellArr3;//临时arr
@end

@implementation VehicleTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆类型";
    self.cellArr3 = self.cellArr2[0];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.tableview2];

}

#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth/4, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        _tableview.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _tableview;
}
-(UITableView*)tableview2{
    if(!_tableview2){
        _tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 64, kScreenWidth*3/4, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview2.delegate = self;
        _tableview2.dataSource = self;
        _tableview2.tableFooterView = [UIView new];
    }
    return _tableview2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        self.cellArr3 = self.cellArr2[indexPath.row];
        [self.tableview2 reloadData];
    }else{
        if (self.callBack) {
            self.callBack(indexPath);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*k_scale;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableview) {
        return self.cellArr.count;
    }else{
        return self.cellArr3.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.tableview) {
        static NSString *tableCell = @"CellIdentifier";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
        }
        cell.textLabel.text = self.cellArr[indexPath.row];
        cell.backgroundColor = [UIColor lightGrayColor];
         cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        static NSString *tableCell = @"CellIdentifier2";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        if (indexPath.row<2) {
            cell.textLabel.text = [NSString stringWithFormat:@"   整车长%@米",self.cellArr3[indexPath.row]];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"   车厢长%@米",self.cellArr3[indexPath.row]];
        }
        
        return cell;
    }

}





-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@"面包车",@"轻型货车",@"厢式货车",@"平板货车",@"高栏货车"];
    }
    return _cellArr;
}
-(NSArray*)cellArr2{
    if(!_cellArr2){
        _cellArr2 = @[
  @[@"3.20-3.59",@"3.6-3.99",@"4.00-4.39",@"4.40-4.59",@"4.6-4.79",@"4.80-4.99",@"5.00-5.39",@"5.40-5.79"],
  @[@"4.60-4.79",@"4.80-4.99",@"5.00-5.49",@"5.50-5.99",@"6.00-6.99"],
  @[@"1.8",@"2.0",@"2.5",@"2.7",@"3.0",@"3.3",@"3.8",@"4.2",@"4.5"],
  @[@"1.8",@"2.0",@"2.5",@"2.7",@"3.0",@"3.3",@"3.8",@"4.2",@"4.5"],
  @[@"1.8",@"2.0",@"2.5",@"2.7",@"3.0",@"3.3",@"3.8",@"4.2",@"4.5"]
  ];
    }
    return _cellArr2;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
