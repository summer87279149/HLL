//
//  SettingHeaderView.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SettingHeaderView.h"

@implementation SettingHeaderView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.view.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    self.gradientLayer.colors = @[(__bridge id)[UIColor jk_colorWithHexString:@"FA9D1D"].CGColor,
                                  (__bridge id)[UIColor jk_colorWithHexString:@"FF8300"].CGColor];
    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
    for (UIView*view in self.view.subviews) {
        [self.view bringSubviewToFront:view];
    }
}


@end
