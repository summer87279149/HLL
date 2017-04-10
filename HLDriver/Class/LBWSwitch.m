//
//  LBWSwitch.m
//  FunnySwitch
//
//  Created by 李博文 on 16/6/30.
//  Copyright © 2016年 李博文. All rights reserved.
//

#import "LBWSwitch.h"

#pragma mark LBWSwitchFaceLayer
@interface LBWSwitchFaceLayer : CALayer

/**
 *  equals to onColor
 */
@property (nonatomic,strong)UIColor * happyEmotionColor;

/**
 *  equals to offColor
 */
@property (nonatomic,strong)UIColor * unhappyEmotionColor;

/**
 *  isHappy equals to isOn
 */
@property (nonatomic,assign)BOOL isHappy;

/**
 *  create it for keyAnimation
 */
@property (nonatomic,assign)CGRect eyesRect;

/**
 *  to certain mouth'shape
 */
@property (nonatomic,assign)CGFloat mouthOffset;
@end

@implementation LBWSwitchFaceLayer
#pragma mark  Set Get Method
-(void)setIsHappy:(BOOL)isHappy
{
    _isHappy = isHappy;
    [self setNeedsDisplay];
}

-(void)setHappyEmotionColor:(UIColor *)happyEmotionColor
{
    _happyEmotionColor = happyEmotionColor;
    [self setNeedsDisplay];
}

-(void)setUnhappyEmotionColor:(UIColor *)unhappyEmotionColor
{
    _unhappyEmotionColor = unhappyEmotionColor;
    [self setNeedsDisplay];
}

#pragma mark  init
/**
 * fuck this method, it will call when u use CAKeyAnimation.subclasses can override
 * this method to copy their instance variables into the presentation
 * layer
 *
 *  @param layer <#layer description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithLayer:(LBWSwitchFaceLayer *)layer
{
    if (self = [super initWithLayer:layer])
    {
        self.happyEmotionColor = layer.happyEmotionColor;
        self.unhappyEmotionColor = layer.unhappyEmotionColor;
        self.isHappy = layer.isHappy;
        self.eyesRect = layer.eyesRect;
        self.mouthOffset = layer.mouthOffset;
    }
    return self;
}

#pragma mark
-(void)drawInContext:(CGContextRef)ctx
{
    
    CGContextSetFillColorWithColor(ctx, _isHappy?_happyEmotionColor.CGColor:_unhappyEmotionColor.CGColor);
 
    //left eye
    UIBezierPath * pathOfLeftEye = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_eyesRect.origin.x, _eyesRect.origin.y, _eyesRect.size.width, _eyesRect.size.height)];
    CGContextAddPath(ctx, pathOfLeftEye.CGPath);
    
    //right eye
    UIBezierPath * pathOfRightEye = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width - _eyesRect.size.width - _eyesRect.origin.x, _eyesRect.origin.y, _eyesRect.size.width, _eyesRect.size.height)];
    CGContextAddPath(ctx, pathOfRightEye.CGPath);
    
    //mouth
    UIBezierPath * pathOfMouth = [UIBezierPath bezierPath];
    if (_isHappy)
    {
        [pathOfMouth moveToPoint:CGPointMake(self.frame.size.width * 0.2, self.frame.size.height * 0.68)];
        [pathOfMouth addCurveToPoint:CGPointMake(self.frame.size.width * 0.8, self.frame.size.height * 0.68) controlPoint1:CGPointMake(self.frame.size.width * 0.2 + _mouthOffset /3, self.frame.size.height * 0.68 + _mouthOffset) controlPoint2:CGPointMake(self.frame.size.width * 0.8 - _mouthOffset /3, self.frame.size.height * 0.68 + _mouthOffset)];
    }
    else
    {
        pathOfMouth = [UIBezierPath bezierPathWithRect:CGRectMake(self.frame.size.width * 0.22, self.frame.size.height * 0.7, self.frame.size.width * 0.56, 2)];
    }
    [pathOfMouth closePath];
    CGContextAddPath(ctx, pathOfMouth.CGPath);
    
    CGContextFillPath(ctx);
}

+(BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqual:@"mouthOffset"])
    {
        return YES;
    }
    
    if ([key isEqual:@"eyesRect"])
    {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}
@end

#pragma mark LBWSwitch

/**
 *  Animation keys
 */
NSString * const kHeadLayerAnimationKey = @"HeadLayerAnimationKey";
NSString * const kBackgroundAnimationKey = @"BackgroundAnimationKey";
NSString * const kFaceLayerHiddenAnimationKey = @"FaceLayerHiddenAnimationKey";
NSString * const kFaceLayerShowAnimationKey = @"FaceLayerShowAnimationKey";
NSString * const kFaceLayerEndMoveAnimationKey = @"FaceLayerEndMoveAnimationKey";
NSString * const kFaceLayerEyesCloseAndOpenKey = @"FaceLayerEyesCloseAndOpenKey";

@interface LBWSwitch ()<CAAnimationDelegate>
{
    CGFloat _sideOfHead;
    
    CGFloat _moveDistance;
    
    BOOL isAnimating;
    BOOL textAnima;
    
    FunnySwitchDidSelectedBlock _funnySwitchDidSelectedBlock;
}

@property (nonatomic,strong)CAShapeLayer * headLayer;
@property (nonatomic, strong) CATextLayer *textlayer;
@property (nonatomic, strong) CATextLayer *textlayer2;
@end

const CGFloat kWidthOfPadding = 5;

const CGFloat kAnimationDuration = 1.2f;
@implementation LBWSwitch

#pragma mark  set method
-(void)setOnColor:(UIColor *)onColor
{
    _onColor = onColor;
    self.faceLayer.happyEmotionColor = _onColor;
    if (_isOn)
    {
        self.backgroundColor = _onColor;
    }
}

-(void)setOffColor:(UIColor *)offColor
{
    _offColor = offColor;
    self.faceLayer.unhappyEmotionColor = _offColor;
    if (!_isOn)
    {
        self.backgroundColor = _offColor;
    }
}

-(void)setHeadColor:(UIColor *)headColor
{
    _headColor = headColor;
    self.headLayer.fillColor = _headColor.CGColor;
}

-(void)setIsOn:(BOOL)isOn
{
    _isOn = isOn;
    self.faceLayer.isHappy = _isOn;
    self.backgroundColor = _isOn?_onColor:_offColor;
    
    self.faceLayer.mouthOffset = _isOn?15.0f:0.f;
}

-(CALayer *)headLayer
{
    if (!_headLayer)
    {
        _sideOfHead = self.frame.size.height - 2 * kWidthOfPadding;
        
        _headLayer = [CAShapeLayer layer];
        _headLayer.frame = CGRectMake(kWidthOfPadding, kWidthOfPadding, _sideOfHead, _sideOfHead);
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:_headLayer.bounds];
        _headLayer.path = path.CGPath;
        
        [self.layer addSublayer:_headLayer];
        /**
         *  init properties
         */
        _textlayer = [CATextLayer layer];
        _textlayer.frame = CGRectMake(kWidthOfPadding+_sideOfHead+5,  self.frame.size.height/2-12, self.frame.size.width, 24 );
        _textlayer.alignmentMode = kCAAlignmentJustified;
        _textlayer.wrapped = YES;
        UIFont *font = [UIFont systemFontOfSize:16];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _textlayer.font = fontRef;
        _textlayer.fontSize = font.pointSize;
        _textlayer.string = @"下班啦";
        _textlayer2.opacity = 1;
        _textlayer.contentsScale = 2;
        _textlayer.alignmentMode = @"left";
        [self.layer addSublayer:_textlayer];
        //工作中
        _textlayer2 = [CATextLayer layer];
        _textlayer2.frame = CGRectMake(kWidthOfPadding+5,  self.frame.size.height/2-12, self.frame.size.width, 24 );
        _textlayer2.alignmentMode = kCAAlignmentJustified;
        _textlayer2.wrapped = YES;
        _textlayer2.font = fontRef;
        _textlayer2.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        _textlayer2.string = @"工作中";
        _textlayer2.opacity = 0;
        _textlayer2.contentsScale = 2;
        _textlayer2.alignmentMode = @"left";
        [self.layer addSublayer:_textlayer2];
        
        
        
    }
    return _headLayer;
}

-(void)setFunnySwitchDidSelectedBlock:(FunnySwitchDidSelectedBlock)block
{
    _funnySwitchDidSelectedBlock = block;
}
#pragma mark
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSAssert(frame.size.width > frame.size.height,@"width must more than height");
        _moveDistance = self.frame.size.width - self.frame.size.height;
        
        [self initLBWSwitch];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchTouched:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)initLBWSwitch
{
   
    isAnimating = NO;
    _isOn = NO;
    self.layer.cornerRadius = self.frame.size.height/2;
    
    self.onColor = [UIColor colorWithRed:73/255.0 green:182/255.0 blue:235/255.0 alpha:1.f];
    self.offColor = [UIColor colorWithRed:211/255.0 green:207/255.0 blue:207/255.0 alpha:1.f];
    self.headColor = [UIColor whiteColor];
    
    self.headLayer.masksToBounds = YES;
    
    self.faceLayer = [LBWSwitchFaceLayer layer];
    self.faceLayer.frame = self.headLayer.bounds;
    self.faceLayer.happyEmotionColor = self.onColor;
    self.faceLayer.unhappyEmotionColor = self.offColor;
    self.faceLayer.eyesRect = CGRectMake(self.faceLayer.frame.size.width * 0.2, self.frame.size.height * 0.25, self.faceLayer.frame.size.width * 0.15, self.faceLayer.frame.size.height * 0.3);
    self.faceLayer.mouthOffset = 15.0f;
    self.faceLayer.isHappy = self.isOn;
    
    [self.headLayer addSublayer:self.faceLayer];
    
}

#pragma mark   Tap GestureRecognizer
-(void)switchTouched:(UITapGestureRecognizer *)tap
{
    if (isAnimating)
    {
        return;
    }
    
    isAnimating = YES;
    /*
        animation can not change layer.position's value . if u want to remove it ,u need change
        value after animation by yourself
     */
    CABasicAnimation * headLayerAnimation = [self animationForHeadLayerWithBeginPosition:self.headLayer.position endPosition:CGPointMake(_isOn?self.headLayer.position.x - _moveDistance:self.headLayer.position.x + _moveDistance, self.headLayer.position.y)];
    headLayerAnimation.delegate = self;
    [self.headLayer addAnimation:headLayerAnimation forKey:kHeadLayerAnimationKey];

    CABasicAnimation * backgroundAnimation = [self animationForBackgroundColorWithBeginColor:_isOn?_onColor:_offColor endColor:_isOn?_offColor:_onColor];
    [self.layer addAnimation:backgroundAnimation forKey:kBackgroundAnimationKey];

    CABasicAnimation * faceLayerAnimation = [self animationForFaceLayerWithBeginStatus:@(0) endStatus:_isOn?@(-_faceLayer.frame.size.width):@(_faceLayer.frame.size.width)];
    faceLayerAnimation.delegate = self;
    [self.faceLayer addAnimation:faceLayerAnimation forKey:kFaceLayerHiddenAnimationKey];
    textAnima = !textAnima;
    if (textAnima) {
        [self textAnima2];
        
    }else{
        [self textAnima1];
    }
//    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
//    alphaAnimation.keyPath = @"opacity";
//    alphaAnimation.toValue = @0;
//    alphaAnimation.delegate = self;
//    alphaAnimation.removedOnCompletion = NO;
//    alphaAnimation.fillMode = kCAFillModeForwards;
//    [self.textlayer addAnimation:alphaAnimation forKey:@"textAnima"];
//    
//    CABasicAnimation *alphaAnimation2 = [CABasicAnimation animation];
//    alphaAnimation2.keyPath = @"opacity";
//    alphaAnimation2.fromValue = @0;
//    alphaAnimation2.toValue = @1;
//    alphaAnimation2.delegate = self;
//    alphaAnimation2.removedOnCompletion = NO;
//    alphaAnimation2.fillMode = kCAFillModeForwards;
//    [self.textlayer2 addAnimation:alphaAnimation forKey:@"textAnima2"];
    if (_isOn)
    {
        CAKeyframeAnimation * eyesAnimation = [self animationForEyesCloseAndOpenWithRect:_faceLayer.eyesRect];
        eyesAnimation.delegate = self;
        [self.faceLayer addAnimation:eyesAnimation forKey:kFaceLayerEyesCloseAndOpenKey];
        
        CAKeyframeAnimation * unSmileAnimation = [self animationForSmileWithMouthOffset:15.0f isOn:!self.isOn];
        [self.faceLayer addAnimation:unSmileAnimation forKey:kFaceLayerEyesCloseAndOpenKey];
    }
}

#pragma mark   animation
-(CABasicAnimation *)animationForHeadLayerWithBeginPosition:(CGPoint)beginPosition endPosition:(CGPoint)endPosition
{
    CABasicAnimation * headLayerAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    headLayerAnimation.fromValue = [NSValue valueWithCGPoint:beginPosition];
    headLayerAnimation.toValue = [NSValue valueWithCGPoint:endPosition];
    headLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    headLayerAnimation.duration = kAnimationDuration * 2 /3;
    headLayerAnimation.removedOnCompletion = NO;
    headLayerAnimation.fillMode = kCAFillModeForwards;
    
    return headLayerAnimation;
}

-(CABasicAnimation *)animationForBackgroundColorWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor
{
    CABasicAnimation * backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.fromValue = (id)beginColor.CGColor;
    backgroundColorAnimation.toValue = (id)endColor.CGColor;
    backgroundColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    backgroundColorAnimation.duration = kAnimationDuration / 3 * 2;
    backgroundColorAnimation.removedOnCompletion = NO;
    backgroundColorAnimation.fillMode = kCAFillModeForwards;
    
    return backgroundColorAnimation;
}

-(CABasicAnimation *)animationForFaceLayerWithBeginStatus:(NSValue *)beginStatus endStatus:(NSValue *)endStatus
{
    CABasicAnimation * faceMoveAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    faceMoveAnimation.fromValue = beginStatus;
    faceMoveAnimation.toValue = endStatus;
    faceMoveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    faceMoveAnimation.duration = kAnimationDuration / 3;
    faceMoveAnimation.removedOnCompletion = NO;
    faceMoveAnimation.fillMode = kCAFillModeForwards;
    
    return faceMoveAnimation;
}

-(CAKeyframeAnimation *)animationForEyesCloseAndOpenWithRect:(CGRect)rect
{
    CGFloat numOfSizes = kAnimationDuration * 180 / 3;
    CGFloat heightOfFrame = rect.size.height/(numOfSizes/3);
    
    NSMutableArray * sizes = [NSMutableArray array];
    
    CGFloat heightValue;
    CGFloat yValue;
    
    for (int i = 0; i < numOfSizes; i++)
    {
        //close
        if (i < numOfSizes/3)
        {
            heightValue = rect.size.height - heightOfFrame * i;
            
        }
        //open
        else if(i >= numOfSizes * 2/3)
        {
            heightValue = heightOfFrame * (i - numOfSizes * 2/3 + 1);
        }
        //keep
        else
        {
            heightValue = 0;
        }
        
        yValue = rect.origin.y + (rect.size.height - heightValue)/2;
        //sun dog , the value is heightValue not heightOfFrame
        [sizes addObject:[NSValue valueWithCGRect:CGRectMake(rect.origin.x, yValue, rect.size.width, heightValue)]];
    }
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"eyesRect"];
    keyAnimation.values = sizes;
    keyAnimation.duration = kAnimationDuration / 3;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    return keyAnimation;
}


-(CAKeyframeAnimation *)animationForSmileWithMouthOffset:(CGFloat)mouthOffset isOn:(BOOL)isOn
{
    CGFloat numOfFrame = kAnimationDuration * 180 / 18;
    
    CGFloat mouthOffsetOfFrame = mouthOffset/numOfFrame;
    
    CGFloat mouthOffsetValue;
    
    NSMutableArray * mouthOffsets = [NSMutableArray array];
    for (int i = 0; i < numOfFrame; i++)
    {
        if (isOn)
        {
            mouthOffsetValue = i * mouthOffsetOfFrame;
        }
        else
        {
            mouthOffsetValue = mouthOffset - i * mouthOffsetOfFrame;
        }
        [mouthOffsets addObject:@(mouthOffsetValue)];
    }
    
    CAKeyframeAnimation * mouthOffsetAnimation = [CAKeyframeAnimation animationWithKeyPath:@"mouthOffset"];
    mouthOffsetAnimation.values = mouthOffsets;
    mouthOffsetAnimation.duration = kAnimationDuration / 3;
    if (!isOn && kAnimationDuration >= 1.f)
    {
        mouthOffsetAnimation.beginTime = CACurrentMediaTime() + kAnimationDuration / 12;
    }
    mouthOffsetAnimation.removedOnCompletion = NO;
    mouthOffsetAnimation.fillMode = kCAFillModeForwards;
    
    return mouthOffsetAnimation;
}
-(void)textAnima1{
    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @0;
    alphaAnimation.toValue = @1;
    alphaAnimation.delegate = self;
    alphaAnimation.duration = kAnimationDuration / 1.5;
    alphaAnimation.removedOnCompletion = NO;
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    alphaAnimation.fillMode = kCAFillModeForwards;
    [self.textlayer addAnimation:alphaAnimation forKey:@"textAnima"];
    
    CABasicAnimation *alphaAnimation2 = [CABasicAnimation animation];
    alphaAnimation2.keyPath = @"opacity";
    alphaAnimation2.fromValue = @1;
    alphaAnimation2.toValue = @0;
    alphaAnimation2.delegate = self;
//    alphaAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    alphaAnimation2.duration = kAnimationDuration / 3;
    alphaAnimation2.removedOnCompletion = NO;
    alphaAnimation2.fillMode = kCAFillModeForwards;
    [self.textlayer2 addAnimation:alphaAnimation2 forKey:@"textAnima2"];
}
-(void)textAnima2{
    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
//    alphaAnimation.duration = kAnimationDuration / 3;
    alphaAnimation.delegate = self;
    alphaAnimation.removedOnCompletion = NO;
//    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    alphaAnimation.fillMode = kCAFillModeForwards;
    [self.textlayer addAnimation:alphaAnimation forKey:@"textAnima"];
    
    CABasicAnimation *alphaAnimation2 = [CABasicAnimation animation];
    alphaAnimation2.keyPath = @"opacity";
    alphaAnimation2.fromValue = @0;
    alphaAnimation2.toValue = @1;
    alphaAnimation2.delegate = self;
    alphaAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    alphaAnimation2.duration = kAnimationDuration / 1.5;
    alphaAnimation2.removedOnCompletion = NO;
    alphaAnimation2.fillMode = kCAFillModeForwards;
    [self.textlayer2 addAnimation:alphaAnimation2 forKey:@"textAnima2"];
}
#pragma mark   Animation Delegate
-(void)animationDidStart:(CAAnimation *)anim{
    if (anim == [_textlayer animationForKey:@"textAnima"]  ) {
        
        
    }
    if (anim == [_textlayer2 animationForKey:@"textAnima2"]  ) {
        
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
        
    {
        if (anim == [_textlayer animationForKey:@"textAnima"]  ) {
//            _textlayer.opacity = 0;
//            _textlayer2.opacity = 1;
        }
        if (anim == [_textlayer2 animationForKey:@"textAnima2"]  ) {
//            _textlayer.opacity = 1;
//            _textlayer2.opacity = 0;
           
        }
        if (anim == [_faceLayer animationForKey:kFaceLayerHiddenAnimationKey])
        {
            CABasicAnimation * faceLayerAnimation = [self animationForFaceLayerWithBeginStatus:@(_isOn?_faceLayer.frame.size.width:-_faceLayer.frame.size.width) endStatus:@(_isOn?-5 : 5)];
            faceLayerAnimation.delegate = self;
            [self.faceLayer addAnimation:faceLayerAnimation forKey:kFaceLayerShowAnimationKey];
            
            _faceLayer.isHappy = !_isOn;
            _faceLayer.mouthOffset = !_isOn?15.0f:0.f;
            
            if (!_isOn)
            {
                CAKeyframeAnimation * smileAnimation = [self animationForSmileWithMouthOffset:15.0f isOn:!self.isOn];
                [self.faceLayer addAnimation:smileAnimation forKey:kFaceLayerEyesCloseAndOpenKey];
            }
            
            return;
        }
        
        if (anim == [_faceLayer animationForKey:kFaceLayerShowAnimationKey])
        {
            CABasicAnimation * faceLayerShowAnimation = [self animationForFaceLayerWithBeginStatus:@(_isOn?-5:5) endStatus:@(0)];
            faceLayerShowAnimation.delegate = self;
            [self.faceLayer addAnimation:faceLayerShowAnimation forKey:kFaceLayerEndMoveAnimationKey];
            
            //change headLayer's position
            _headLayer.position = CGPointMake(_isOn?_headLayer.position.x - _moveDistance : _headLayer.position.x + _moveDistance, _headLayer.position.y);
            
            //change isOn
            self.isOn = !self.isOn;
            
            if (self.isOn)
            {
                CAKeyframeAnimation * eyesAnimation = [self animationForEyesCloseAndOpenWithRect:_faceLayer.eyesRect];
                eyesAnimation.delegate = self;
                [self.faceLayer addAnimation:eyesAnimation forKey:kFaceLayerEyesCloseAndOpenKey];
            }
            
            return;
        }
        
        if (anim == [_faceLayer animationForKey:kFaceLayerEndMoveAnimationKey])
        {
            
            isAnimating = NO;
            if (_funnySwitchDidSelectedBlock)
            {
                _funnySwitchDidSelectedBlock(_isOn);
            }
            return;
        }

    }
}
@end
