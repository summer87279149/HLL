//
//  UploadViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UIViewController+CameraAndPhoto.h"
#import "CollectionViewCell.h"
#import "UploadViewController.h"

@interface UploadViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cellArr;
@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传资料";
    UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uploadIMG"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(imageView.mas_height).multipliedBy(557/125);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(self.view).offset(70);
    }];
    [self.view addSubview:self.collectionView];
    [self makeCompleteBtn];
}


-(void)completeCilcked{
    
}
-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@"身份证照片",@"行驶证照片",@"驾驶证照片",@"车辆45度侧面照"];
    }
    return _cellArr;
}
-(void)makeCompleteBtn{
    UIButton *btn = [UIButton XT_createBtnWithTitle:@"确定" TitleColor:[UIColor whiteColor] TitleFont:@15 cornerRadio:@5 BGColor:[UIColor jk_colorWithHexString:@"F1671D"] Borderline:nil BorderColor:nil target:self Method:@selector(completeCilcked)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-30*k_scale);
        make.height.mas_equalTo(30*k_scale);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(20);
    }];
}
#pragma mark - delegate
-(UICollectionView*)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(kScreenWidth/2-20, (kScreenWidth/2-20)/278*194);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, ((kScreenWidth/2-20)/278*194)*2+20) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        cell.title.text = self.cellArr[indexPath.row];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellArr.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.xt_block = ^(NSData *data) {
        cell.imageView.image = [UIImage imageWithData:data];
        //判断拿到的是哪个cell，得到image
    };
    [self openImagePickerWithType:XTCameraTypeSeal];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
