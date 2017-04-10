//
//  LBWSwitch.h
//  FunnySwitch
//
//  Created by 李博文 on 16/6/30.
//  Copyright © 2016年 李博文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBWSwitchFaceLayer;
typedef void(^FunnySwitchDidSelectedBlock)(BOOL isOn);
@interface LBWSwitch : UIView

/**
 *  switch on color , default is [UIColor colorWithRed:73/255.0 green:182/255.0 blue:235/255.0 alpha:1.f]
 */
@property (nonatomic,strong)UIColor * onColor;

/**
 *  switch off color , default is [UIColor colorWithRed:211/255.0 green:207/255.0 blue:207/255.0 alpha:1.f]
 */
@property (nonatomic,strong)UIColor * offColor;

/**
 *  head color , default is [UIColor whiteColor];
 */
@property (nonatomic,strong)UIColor * headColor;

/**
 *  default is NO
 */
@property (nonatomic,assign)BOOL isOn;

/**
 *  layer for emotion
 */
@property (nonatomic,strong)LBWSwitchFaceLayer *  faceLayer;

/**
 *  block will call when u select switch and animation stop
 */
-(void)setFunnySwitchDidSelectedBlock:(FunnySwitchDidSelectedBlock)block;
@end
