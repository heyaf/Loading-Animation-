//
//  secLayer.m
//  Core Animation1
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 贺亚飞. All rights reserved.
//

#import "secLayer.h"
#define hyfRadius (47/(sqrtf(3)-1)


@implementation secLayer
@dynamic progressTwo;

+(BOOL)needsDisplayForKey:(NSString *)key{

    if ([key isEqualToString:@"progressTwo"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}
-(void)drawInContext:(CGContextRef)ctx{
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    
//    //半径
//    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2-6/2;
//    
//    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
//    
//    //O点
//    CGFloat starOrigin = M_PI*2;
//    CGFloat endOrigin = M_PI*2;
//    CGFloat currentOrigin = starOrigin-(starOrigin-endOrigin)*self.progressTwo;
//    
//    //D点
//    CGFloat starDest =M_PI*2;
//    CGFloat endDest =0;
//    CGFloat currentDest = starDest-(starDest-endDest)*self.progressTwo;
//    
//    [path addArcWithCenter:center radius:radius startAngle:currentOrigin endAngle:currentDest clockwise:NO];
//    CGContextAddPath(ctx, path.CGPath);
//    CGContextSetLineWidth(ctx, 6);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor cyanColor].CGColor);
//    CGContextStrokePath(ctx);

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat x=42/(sqrtf(3)-1);
    CGFloat radius = (42+x);
    
    CGPoint position = CGPointMake(CGRectGetMidX(self.bounds)-x,100);
    
    //O点
    CGFloat startO = M_PI*(2-0.03);
    CGFloat endO=M_PI*(1.70-0.03);
    
    CGFloat nowO = startO-(startO-endO)*self.progressTwo;
    
    //D点
    CGFloat startD = M_PI*(2);
    CGFloat endD = M_PI*(1.70);
    CGFloat nowD = startD-(startD-endD)*self.progressTwo;
    
    [path addArcWithCenter:position radius:radius startAngle:nowD endAngle:nowO clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, 4);
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextStrokePath(ctx);
    
    
    
}

@end
