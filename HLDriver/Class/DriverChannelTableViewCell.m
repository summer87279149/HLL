//
//  DriverChannelTableViewCell.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "DriverChannelTableViewCell.h"

@implementation DriverChannelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.layer.masksToBounds = YES;
    self.shadowView.layer.cornerRadius = 10;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    // Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor.blackColor colorWithAlphaComponent: 0.48];
    shadow.shadowOffset = CGSizeMake(0, 0);
    shadow.shadowBlurRadius = 10;
    
    // Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.shadowView.frame cornerRadius: 10];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [color setFill];
    [rectanglePath fill];
    CGContextRestoreGState(context);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
