//
//  CollectionViewCell.m
//  HLDriver
//
//  Created by Admin on 2017/4/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
        [_imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"uploadItemsImage"]];
        [self.contentView addSubview:self.imageView];
        _imageView.layer.cornerRadius=5;
        _imageView.layer.masksToBounds = YES;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(frame.size.width-30);
            make.height.mas_equalTo((frame.size.width-30)*194/278);
        }];
        self.title = [[UILabel alloc]init];
        self.title.font = [UIFont systemFontOfSize:15];
        self.title.textColor =[UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(self);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
        }];

    }
    return self;
}

@end
