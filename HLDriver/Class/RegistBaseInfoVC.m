//
//  RegistBaseInfoVC.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
//
#import "VehicleTypeViewController.h"
#import "UploadViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "RETableViewOptionsController.h"
#import "RegistBaseInfoVC.h"

@interface RegistBaseInfoVC ()<RETableViewManagerDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *section2HeaderView;
@property (nonatomic, strong) UIView *section2FooterView;
@property (nonatomic, strong) UIImageView *image;//头像
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *name;
@property (nonatomic, strong) RENumberItem *idCard;
@property (nonatomic, strong) RENumberItem *creditCard;
@property (nonatomic, strong) RETableViewItem *address;
@property (nonatomic, strong) RETableViewItem *vehicleType;
@property (nonatomic, strong) RETextItem *drivingLicence;
@property (nonatomic, strong) RETextItem *LicensePlateNumber;//车牌号
@property (nonatomic, strong) REBoolItem *quanchaizuo;
@property (nonatomic, strong) NSString *storeCertifyAddress;
@end

@implementation RegistBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupview];
    self.title = @"基本信息";
}

-(void)pushMapVC{
    
}

-(void)footerViewBtnClicked:(UIButton*)sender{
    
}
-(void)completeCilcked:(UIButton *)sender{
    [self.navigationController pushViewController:[UploadViewController new] animated:YES];
}
-(void)modifyImage{
    WS(weakSelf)
    self.xt_block = ^(NSData*data){
        weakSelf.image.image = [UIImage imageWithData:data];
    };
    [self openImagePickerWithType:XTCameraTypeSeal];
}




#pragma mark - ui
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    
    //section1
    RETableViewSection *section1 = [RETableViewSection sectionWithHeaderView:nil footerView:self.footerView];
    [self.manager addSection:section1];
    self.name = [RETextItem itemWithTitle:@"姓名" value:nil placeholder:@"填写用户姓名"];
    self.idCard = [RENumberItem itemWithTitle:@"身份证号" value:@"" placeholder:@"填写本人身份证号"];
    self.creditCard = [RENumberItem itemWithTitle:@"银行卡号" value:@"" placeholder:@"填写本人银行卡号"];
    [section1 addItem:self.name];
    [section1 addItem:self.idCard];
    [section1 addItem:self.creditCard];
    //section2
    RETableViewSection *section2 = [RETableViewSection sectionWithHeaderView:self.section2HeaderView footerView:nil];
    [self.manager addSection:section2];
    WS(weakSelf)
    self.address = [RETableViewItem itemWithTitle:@"公司地址:" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf pushMapVC];
    }];
    self.LicensePlateNumber = [RETextItem itemWithTitle:@"车牌号" value:nil placeholder:nil];
    self.vehicleType =  [RETableViewItem itemWithTitle:@"车辆类型:" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        VehicleTypeViewController *vc = [VehicleTypeViewController new];
        vc.callBack = ^(id info){
            NSLog(@"拿到%@",info);
        };
        [weakSelf.navigationController pushViewController:[VehicleTypeViewController new] animated:YES];
    }];
    self.drivingLicence = [RETextItem itemWithTitle:@"驾驶证号" value:nil placeholder:nil];
    self.quanchaizuo = [REBoolItem itemWithTitle:@"全拆座" value:NO];
    [section2 addItem:self.address];
    [section2 addItem:self.LicensePlateNumber];
    [section2 addItem:self.vehicleType];
    [section2 addItem:self.drivingLicence];
    [section2 addItem:self.quanchaizuo];
    
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.tableHeaderView = self.headerView;
        _tableview.tableFooterView = self.section2FooterView;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UIView*)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        UIButton *btn = [UIButton XT_createBtnWithTitle:@"查看支持的银行" TitleColor:[UIColor blackColor] TitleFont:@15 cornerRadio:nil BGColor:[UIColor whiteColor] Borderline:nil BorderColor:nil target:self Method:@selector(footerViewBtnClicked:)];
        [_footerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_footerView).offset(-10);
            make.width.mas_equalTo(100*k_scale);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(_footerView);
        }];
        
    }
    return _footerView;
}
-(UIView*)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170*k_scaleHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BaseInfoIMG.png"]];
        [_headerView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_headerView);
            make.width.mas_equalTo(image.mas_height).multipliedBy(4);
            make.height.mas_equalTo(50*k_scaleHeight);
            make.top.mas_equalTo(_headerView);
        }];
        UIView *v = [self makePortrait];
        [_headerView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_headerView);
            make.width.and.height.mas_equalTo(100*k_scale);
            make.top.mas_equalTo(image.mas_bottom).offset(10);
        }];
        
    }
    return _headerView;
}



#pragma mark - lazyload
-(UIView*)makePortrait{
    //portrait
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100*k_scale, 100*k_scale)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyImage)];
    [view addGestureRecognizer:tap];
    [view addSubview:self.image];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top);
        make.width.mas_equalTo(view.mas_width);
        make.height.mas_equalTo(view.mas_width);
        make.centerX.mas_equalTo(view);
    }];
    _image.layer.cornerRadius = 50*k_scale;
    _image.layer.masksToBounds = YES;
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"用户头像";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_image.mas_bottom);
        make.left.right.mas_equalTo(_image);
    }];
    return view;
}
-(UIImageView*)image{
    if(!_image){
        _image = [[UIImageView alloc]init];
        _image.image = [UIImage imageNamed:@"defaultUserImg.jpg"];
    }
    return _image;
}

-(UIView*)section2HeaderView{
    if(!_section2HeaderView){
        _section2HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"车辆信息";
        [_section2HeaderView addSubview:lab];
    }
    return _section2HeaderView;
}
-(UIView*)section2FooterView{
    if(!_section2FooterView){
        _section2FooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50*k_scale)];
        UIButton *btn = [UIButton XT_createBtnWithTitle:@"下一步" TitleColor:[UIColor whiteColor] TitleFont:@15 cornerRadio:@5 BGColor:[UIColor jk_colorWithHexString:@"F1671D"] Borderline:nil BorderColor:nil target:self Method:@selector(completeCilcked:)];
        btn.frame = CGRectMake(15, 0, kScreenWidth-30, 30*k_scale);
        [_section2FooterView addSubview:btn];
        
    }
    return _section2FooterView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
