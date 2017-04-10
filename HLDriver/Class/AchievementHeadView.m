//
//  AchievementHeadView.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UIColor+JKHEX.h"
#import "AchievementHeadView.h"

@implementation AchievementHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
   
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:self.gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    self.gradientLayer.colors = @[(__bridge id)[UIColor jk_colorWithHexString:@"FA9D1D"].CGColor,
                                  (__bridge id)[UIColor jk_colorWithHexString:@"FF8300"].CGColor];
    
    //设置颜色分割点（范围：0-1）
    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
    for (UIView*view in self.subviews) {
        [self bringSubviewToFront:view];
    }

}


@end
