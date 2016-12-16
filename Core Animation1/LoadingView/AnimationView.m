//
//  AnimationView.m
//  Core Animation1
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 贺亚飞. All rights reserved.
//

#import "AnimationView.h"
#import "firstLayer.h"
//#import "ArcToCircleLayer.h"
#import "secLayer.h"


#define greenColor [UIColor colorWithRed:0x32/255.0 green:0xa9/255.0 blue:0x82/255.0 alpha:1.0]
#define RedColor [UIColor colorWithRed:0xff/255.0 green:0x61/255.0 blue:0x51/255.0 alpha:1.0]

static NSString *const hyfName = @"name";
static CGFloat const hyfRadius=45;
static CGFloat const hyfLineW=6;
static CGFloat const hyfLineH=10;
static CGFloat const hyfBeforeStep6SuccessDelay = 0.1;
/**
 各个阶段 动画持续时间
 */
static CGFloat const hyfDurationfir=1;
static CGFloat const hyfDurationsec=0.4;
static CGFloat const hyfDurationthr=0.12;
static CGFloat const hyfDurationfour=0.25;
static CGFloat const hyfDurationfive=1.0;
static CGFloat const hyfDurationsix=1.0;
static CGFloat const hyfDurationsixFail1=0.5;
static CGFloat const hyfDurationsixFail2=0.07;


@interface AnimationView ()

//两种状态
@property (nonatomic,assign)BOOL success;
/**
 第一阶段
 */
@property (nonatomic,strong) firstLayer *firstlayer;
//@property (nonatomic) ArcToCircleLayer *arcToCircleLayer;

/**
 第二阶段
 */
@property (nonatomic,strong) secLayer *seclayer;
@property (nonnull,strong) CAShapeLayer *shapelayer;

/**
 第三阶段
 */
@property (nonatomic,strong) CALayer *thrlayer;

/**
 第四阶段
 */
@property (nonatomic,strong) CAShapeLayer *fourshapelayer;
@property (nonatomic,strong) CAShapeLayer *fourshapelayer1;

/**
 第五阶段
 */
@property (nonatomic,strong) CAShapeLayer *leftShapelayer;
@property (nonatomic,strong) CAShapeLayer *rightShapelayer;

/**
 第六阶段
 */
@property (nonatomic,strong) CAShapeLayer *sucessShapelayer;
@property (nonatomic,strong) CAShapeLayer *sucessShapelayer1;
@property (nonatomic,strong) CAShapeLayer *failShapelayer;
@property (nonatomic,strong) CAShapeLayer *failShapelayer1;

@end
@implementation AnimationView

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)starAnimationWithState:(BOOL)success{
    [self resetlayer];
    [self startlayer];
    if (success) {
        self.success=YES;
    }else{
        self.success=NO;
    }
//    [self doStep1];
//    [self dostep2];
    
}


-(void)resetlayer{
    [self.firstlayer removeFromSuperlayer];
    [self.seclayer removeFromSuperlayer];
    [self.shapelayer removeFromSuperlayer];
    [self.thrlayer removeFromSuperlayer];
    [self.fourshapelayer removeFromSuperlayer];
    [self.fourshapelayer1 removeFromSuperlayer];
    [self.leftShapelayer removeFromSuperlayer];
    [self.rightShapelayer removeFromSuperlayer];
    [self.sucessShapelayer removeFromSuperlayer];
    [self.sucessShapelayer1 removeFromSuperlayer];
    [self.failShapelayer1 removeFromSuperlayer];
    [self.failShapelayer removeFromSuperlayer];
}


#pragma mark ----------第一阶段------
-(void)startlayer{
    self.firstlayer = [firstLayer layer];
    
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer addSublayer:_firstlayer];
    
    self.firstlayer.bounds = CGRectMake(0, 0, hyfRadius*2,  hyfRadius*2);
    
    self.firstlayer.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.firstlayer.progressOne = 1;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progressOne"];
    animation.duration =hyfDurationfir;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
//  animation.autoreverses = YES;
    animation.delegate = (id)self;
    [animation setValue:@"step1" forKey:hyfName];
    self.firstlayer.color=[UIColor lightGrayColor];
    [self.firstlayer addAnimation:animation forKey:nil];
    
}
#pragma mark ---------第二阶段---------
-(void)dostep2{
    
    self.seclayer = [secLayer layer];
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.seclayer];
    
    self.seclayer.bounds = CGRectMake(0, 0, self.bounds.size.width, 200);
    self.seclayer.position =CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);

    self.seclayer.progressTwo=1;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"progressTwo"];
    animation2.duration=hyfDurationsec;
    animation2.fromValue=@0.0;
    animation2.toValue=@1.0;
    animation2.delegate=(id)self;
    [animation2 setValue:@"step2" forKey:hyfName];
    
    [self.seclayer addAnimation:animation2 forKey:nil];
    
}

/**
 阶段2的第二种方法
 */

-(void)dostep21{
  
    self.shapelayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.shapelayer];
    self.shapelayer.frame = self.layer.bounds;
    self.shapelayer.backgroundColor = [UIColor clearColor].CGColor;
    // 弧的path
    UIBezierPath *moveArcPath = [UIBezierPath bezierPath];
    // 小圆圆心
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    // d（x轴上弧圆心与小圆左边缘的距离）
    CGFloat d = hyfRadius / 2;
    // 弧圆心
    CGPoint arcCenter = CGPointMake(center.x - hyfRadius - d, center.y);
    // 弧半径
    CGFloat arcRadius = hyfRadius * 2 + d;
    // O(origin)
    CGFloat origin = M_PI * 2;
    // D(dest)
    CGFloat dest = M_PI * 2 - asin(hyfRadius * 2 / arcRadius);
    [moveArcPath addArcWithCenter:arcCenter radius:arcRadius startAngle:origin endAngle:dest clockwise:NO];
    self.shapelayer.path = moveArcPath.CGPath;
    self.shapelayer.lineWidth = 3;
    self.shapelayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.shapelayer.fillColor = nil;

    
    CGFloat SSFrom =0;
    CGFloat SSTo=0.9;
    
    CGFloat SEFrom=0.1;
    CGFloat SETo=1;
    self.shapelayer.strokeStart=SSTo;
    self.shapelayer.strokeEnd=SETo;
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue=@(SSFrom);
    startAnimation.toValue=@(SSTo);

    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue=@(SEFrom);
    endAnimation.toValue=@(SETo);
    
    CAAnimationGroup *step=[CAAnimationGroup animation];
    step.animations=@[startAnimation,endAnimation];
    step.duration=hyfDurationsec;
    step.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.shapelayer addAnimation:step forKey:nil];
    
    
}


#pragma mark ----------第三阶段---------


-(void)step3{

    [self.seclayer removeFromSuperlayer];
    self.thrlayer = [CALayer layer];
    self.thrlayer.contentsScale = [UIScreen mainScreen].scale;
    self.thrlayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:self.thrlayer];
    
    self.thrlayer.bounds=CGRectMake(0, 0, 4,hyfLineH);
    self.thrlayer.position= CGPointMake(CGRectGetMidX(self.frame), 10);
    
    CGPoint originPoint =CGPointMake(self.thrlayer.position.x, hyfLineH/2+20);
    CGPoint destPosition=CGPointMake(originPoint.x, CGRectGetHeight(self.bounds)/2-hyfRadius-hyfLineW+5);
    self.thrlayer.position=destPosition;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation2.fromValue=@(originPoint.y);
    animation2.toValue=@(destPosition.y);
    animation2.duration=hyfDurationthr;
    
    animation2.delegate= (id)self;
    [animation2 setValue:@"step3" forKey:hyfName];
    [self.thrlayer addAnimation:animation2 forKey:nil];
}


#pragma  mark -----------第四阶段----------
-(void)step4{

    //小线逐渐消失
    [self disappearLiner];
    //大线逐渐出现
    [self appearLiner];
    //圆逐渐变扁
    [self getEllipse];
    
}
/**
 小圆逐渐变扁成椭圆
 */
-(void)getEllipse{
    CGRect frame = self.firstlayer.frame;
    self.firstlayer.anchorPoint= CGPointMake(0.5, 1);
    self.firstlayer.frame=frame;
    
    // scale y
    CGFloat yfromeScale=1.0;
    CGFloat ytoScale=0.8;
    
    //scale x
    CGFloat xfromeScale=1.0;
    CGFloat xtoScale=1.1;
    
    self.firstlayer.transform = CATransform3DMakeScale(xtoScale, ytoScale, 1);
    
    CABasicAnimation *yanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    yanimation.fromValue =@(yfromeScale);
    yanimation.toValue=@(ytoScale);
    
    CABasicAnimation *xanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    xanimation.fromValue=@(xfromeScale);
    xanimation.toValue=@(xtoScale);
    
    CAAnimationGroup *animation =[CAAnimationGroup animation];
    animation.animations=@[yanimation,xanimation];
    animation.duration=hyfDurationfour;
    animation.delegate=(id)self;
    [animation setValue:@"step41" forKey:hyfName];
    
    [self.firstlayer addAnimation:animation forKey:nil];
}

/**
 小线逐渐消失
 */
-(void)disappearLiner
{
    
    [self.thrlayer removeFromSuperlayer];
    
    self.fourshapelayer = [CAShapeLayer layer];
    self.fourshapelayer.frame=self.bounds;
    [self.layer addSublayer:self.fourshapelayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = hyfRadius*0.4+hyfLineH;
    CGPoint origin =CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-hyfRadius-hyfLineH+10);
    CGFloat pathheight =hyfRadius*0.8-hyfLineH+hyfLineW;
    
    [path moveToPoint:origin];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-pathheight+10)];
    
    
    self.fourshapelayer.path=path.CGPath;
    self.fourshapelayer.lineWidth=4;
    self.fourshapelayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.fourshapelayer.fillColor=nil;
    
    CGFloat SSFrom =0;
    CGFloat SSend=1;
    
    CGFloat SEfrom =hyfLineH/height;
    CGFloat SEend=1;
    
    self.fourshapelayer.strokeStart=SSend;
    self.fourshapelayer.strokeEnd=SEend;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.fromValue=@(SSFrom);
    animation1.toValue=@(SSend);
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue=@(SEfrom);
    animation2.toValue=@(SEend);
    
    CAAnimationGroup *animationG = [CAAnimationGroup animation];
    animationG.animations =@[animation1,animation2];
    animationG.duration = hyfDurationfour;
    
    [self.fourshapelayer addAnimation:animationG forKey:nil];
}

/**
 大线逐渐出现
 */
-(void)appearLiner
{
//    self.firstlayer.color=greenColor;
    self.fourshapelayer1 = [CAShapeLayer layer];
    self.fourshapelayer1.frame = self.bounds;
//    self.fourshapelayer1.backgroundColor=[UIColor yellowColor].CGColor;
    [self.layer addSublayer:self.fourshapelayer1];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds)-hyfRadius;
    CGFloat originY1 = CGRectGetMidY(self.bounds)+hyfRadius;

    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY1)];
    
    self.fourshapelayer1.path=path.CGPath;
    self.fourshapelayer1.lineWidth=hyfLineW;
    self.fourshapelayer1.strokeColor=[UIColor lightGrayColor].CGColor;
    self.fourshapelayer1.fillColor = nil;
    
    CGFloat SSFrom =0;
    CGFloat SSend =(1-0.8);
    
    CGFloat SEFrom =0;
    CGFloat SEend = 0.5;
    
    self.fourshapelayer1.strokeStart=SSend;
    self.fourshapelayer1.strokeEnd=SEend;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.fromValue=@(SSFrom);
    animation1.toValue=@(SSend);
    
    CABasicAnimation *animation2=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue=@(SEFrom);
    animation2.toValue=@(SEend);
    
    CAAnimationGroup *animationG =[CAAnimationGroup animation];
    animationG.animations =@[animation1,animation2];
    animationG.duration=hyfDurationfour;
    [self.fourshapelayer1 addAnimation:animationG forKey:nil];
    
    
}

#pragma mark ----------第五阶段---------
-(void)dostep5{

    [self getCircle];
    [self lineGoLength];
    [self leftLine];
    [self rightLine];
}

/**
 小圆回复原状
 */
-(void)getCircle
{
    self.firstlayer.transform = CATransform3DIdentity;
    
    // animation
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    anima.duration = hyfDurationfive;
    anima.fromValue = @(0.8);
    anima.toValue = @1;
    [self.firstlayer addAnimation:anima forKey:nil];
}

/**
 中间线变长
 */
-(void)lineGoLength{
   
    
    // SS(strokeStart)
    CGFloat SSFrom = 1 - 0.8;
    CGFloat SSTo = 0;
    
    // SE(strokeEnd)
    CGFloat SEFrom = 0.5;
    CGFloat SETo = 1;
    
    // end status
    self.fourshapelayer1.strokeStart = SSTo;
    self.fourshapelayer1.strokeEnd = SETo;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SEFrom);
    endAnimation.toValue = @(SETo);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation,endAnimation];
    anima.duration = hyfDurationfive;
    anima.delegate= (id)self;
    [anima setValue:@"step5" forKey:hyfName];
    [self.fourshapelayer1 addAnimation:anima forKey:nil];

}

/**
 左边线
 */
-(void)leftLine{

    self.leftShapelayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.leftShapelayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint originPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [path moveToPoint:originPoint];
    CGFloat deltaX = hyfRadius * sin(M_PI / 3);
    CGFloat deltaY = hyfRadius * cos(M_PI / 3);
    CGPoint destPoint = originPoint;
    destPoint.x -= deltaX;
    destPoint.y += deltaY;
    [path addLineToPoint:destPoint];
    self.leftShapelayer.path = path.CGPath;
    self.leftShapelayer.lineWidth = hyfLineW;
    self.leftShapelayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.leftShapelayer.fillColor = nil;
    
    // end status
    CGFloat strokeEnd = 1;
    self.leftShapelayer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.duration = hyfDurationfive;
    anima.fromValue = @0;
    anima.toValue = @(strokeEnd);
    [self.leftShapelayer addAnimation:anima forKey:nil];
}

/**
 右边线
 */
-(void)rightLine{
    self.rightShapelayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.rightShapelayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint originPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [path moveToPoint:originPoint];
    CGFloat deltaX = hyfRadius * sin(M_PI / 3);
    CGFloat deltaY = hyfRadius * cos(M_PI / 3);
    CGPoint destPoint = originPoint;
    destPoint.x += deltaX;
    destPoint.y += deltaY;
    [path addLineToPoint:destPoint];
    self.rightShapelayer.path = path.CGPath;
    self.rightShapelayer.lineWidth = hyfLineW;
    self.rightShapelayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.rightShapelayer.fillColor = nil;
    
    // end status
    CGFloat strokeEnd = 1;
    
    // animation
    self.rightShapelayer.strokeEnd = strokeEnd;
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.duration = hyfDurationfive;
    anima.fromValue = @0;
    anima.toValue = @(strokeEnd);
    [self.rightShapelayer addAnimation:anima forKey:nil];
}

#pragma mark ------第六阶段-----
- (void)doStep6Success {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(hyfBeforeStep6SuccessDelay * 1000 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        self.firstlayer.color=greenColor;
      
        [self prepareForStep6Success];;
        [self processStep6SuccessA];
        [self processStep6SuccessB];
    });
}

- (void)prepareForStep6Success {
    [self.fourshapelayer1 removeFromSuperlayer];
    [self.leftShapelayer removeFromSuperlayer];
    [self.rightShapelayer removeFromSuperlayer];
}

// 圆变色
- (void)processStep6SuccessA {
    [self setCircleColorWithColor:YES];
}

-(void)setCircleColorWithColor:(BOOL)success{

    [self.firstlayer removeFromSuperlayer];
    self.sucessShapelayer1 = [CAShapeLayer layer];
    [self.layer addSublayer:self.sucessShapelayer1];
    self.sucessShapelayer1.frame = self.layer.bounds;
    self.sucessShapelayer1.backgroundColor = [UIColor clearColor].CGColor;
    // 弧的path
    UIBezierPath *moveArcPath = [UIBezierPath bezierPath];
    // 小圆圆心
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // 弧圆心
    CGPoint arcCenter = center;
    // 弧半径
    CGFloat arcRadius = hyfRadius ;
    // O(origin)
    CGFloat origin = M_PI * 2;
    // D(dest)
    CGFloat dest = 0;
    [moveArcPath addArcWithCenter:arcCenter radius:arcRadius startAngle:origin endAngle:dest clockwise:NO];
    self.sucessShapelayer1.path = moveArcPath.CGPath;
    self.sucessShapelayer1.lineWidth = hyfLineW;
    if (success) {
        self.sucessShapelayer1.strokeColor = greenColor.CGColor;
    }else{
        self.sucessShapelayer1.strokeColor = RedColor.CGColor;
    }
    
    self.sucessShapelayer1.fillColor = nil;

}

// 对号出现
- (void)processStep6SuccessB {
    self.sucessShapelayer = [CAShapeLayer layer];
    self.sucessShapelayer.frame = self.bounds;
    [self.layer addSublayer:self.sucessShapelayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint firstPoint = centerPoint;
    firstPoint.x -= hyfRadius / 2;
    [path moveToPoint:firstPoint];
    CGPoint secondPoint = centerPoint;
    secondPoint.x -= hyfRadius / 8;
    secondPoint.y += hyfRadius / 2;
    [path addLineToPoint:secondPoint];
    CGPoint thirdPoint = centerPoint;
    thirdPoint.x += hyfRadius / 2;
    thirdPoint.y -= hyfRadius / 2;
    [path addLineToPoint:thirdPoint];
    
    self.sucessShapelayer.path = path.CGPath;
    self.sucessShapelayer.lineWidth = 6;
    self.sucessShapelayer.strokeColor = greenColor.CGColor;
    self.sucessShapelayer.fillColor = nil;
    
    // end status
    CGFloat strokeEnd = 1;
    self.sucessShapelayer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *step6bAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    step6bAnimation.duration = hyfDurationsix;
    step6bAnimation.fromValue = @0;
    step6bAnimation.toValue = @(strokeEnd);
    [self.sucessShapelayer addAnimation:step6bAnimation forKey:nil];
}
#pragma mark ------第六阶段，失败-----
-(void)doStep6Fail{

    [self.thrlayer removeFromSuperlayer];
    [self setCircleColorWithColor:NO];
    [self processStep6FailB];
    [self processStep6FailC];
}
// 叹号上半部分出现
- (void)processStep6FailB {
    self.failShapelayer = [CAShapeLayer layer];
    self.failShapelayer.frame = self.bounds;
    [self.layer addSublayer: self.failShapelayer];
    
    CGFloat partLength = hyfRadius * 2 / 8;
    CGFloat pathPartCount = 5;
    CGFloat visualPathPartCount = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) - hyfRadius;
    CGFloat destY = originY + partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    self.failShapelayer.path = path.CGPath;
    self.failShapelayer.lineWidth = 6;
    self.failShapelayer.strokeColor = RedColor.CGColor;
    self.failShapelayer.fillColor = nil;
    
    // end status
    CGFloat strokeStart = (pathPartCount - visualPathPartCount ) / pathPartCount;
    CGFloat strokeEnd = 1.0;
    self.failShapelayer.strokeStart = strokeStart;
    self.failShapelayer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @0;
    startAnimation.toValue = @(strokeStart);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @0;
    endAnimation.toValue = @(strokeEnd);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = hyfDurationsixFail1;
    anima.delegate = (id)self;
    [anima setValue:@"step6Fail" forKey:hyfName];
    
    [self.failShapelayer addAnimation:anima forKey:nil];
}

// 叹号下半部分出现
- (void)processStep6FailC {
    self.failShapelayer1 = [CAShapeLayer layer];
    self.failShapelayer1.frame = self.bounds;
    [self.layer addSublayer: self.failShapelayer1];
    
    CGFloat partLength = hyfRadius * 2 / 8;
    CGFloat pathPartCount = 2;
    CGFloat visualPathPartCount = 1;
    
    self.failShapelayer1.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) + hyfRadius;
    CGFloat destY = originY - partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    self.failShapelayer1.path = path.CGPath;
    self.failShapelayer1.lineWidth = 6;
    self.failShapelayer1.strokeColor = RedColor.CGColor;
    self.failShapelayer1.fillColor = nil;
    
    // end status
    CGFloat strokeStart = (pathPartCount - visualPathPartCount ) / pathPartCount;
    CGFloat strokeEnd = 1.0;
    self.failShapelayer1.strokeStart = strokeStart;
    self.failShapelayer1.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @0;
    startAnimation.toValue = @(strokeStart);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @0;
    endAnimation.toValue = @(strokeEnd);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = hyfDurationsixFail1;
    
    [self.failShapelayer1 addAnimation:anima forKey:nil];
}
#pragma mark ----第七阶段，叹号的震动----
- (void)doStep7Fail {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.fromValue = @(-M_PI / 12);
    anima.toValue = @(M_PI / 12);
    anima.duration = hyfDurationsixFail2;
    anima.autoreverses = YES;
    anima.repeatCount = 4;
    [self.layer addAnimation:anima forKey:nil];
}


#pragma mark -----animation delegate-----
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if ([[anim valueForKey:hyfName] isEqualToString:@"step1"]) {
        [self dostep2];
    }else if([[anim valueForKey:hyfName] isEqualToString:@"step2"])
    {
        [self step3];
    }else if ([[anim valueForKey:hyfName] isEqualToString:@"step3"])
    {
        if (self.success) {
            [self step4];
        }else{
            [self doStep6Fail];
        }
    }else if ([[anim valueForKey:hyfName] isEqualToString:@"step41"])
    {
        [self dostep5];
        
    }else if ([[anim valueForKey:hyfName] isEqualToString:@"step5"]){
    
           [self doStep6Success];
            
    }else if([[anim valueForKey:hyfName] isEqualToString:@"step6Fail"]){
    
        [self doStep7Fail];
    }
}

/**
 
 */


@end
