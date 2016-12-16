//
//  firstLayer.m
//  Core Animation1
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 贺亚飞. All rights reserved.
//

#import "firstLayer.h"

static CGFloat const hyfLineW=6;
@implementation firstLayer

@dynamic progressOne;


+(BOOL)needsDisplayForKey:(NSString *)key{
    
    if ([key isEqualToString:@"progressOne"]) {
        
        return YES;
    }else if ([key isEqualToString:@"color"]) {
        return YES;
    }

    return [super needsDisplayForKey:key];
}
-(void)drawInContext:(CGContextRef)ctx{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //半径
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2-hyfLineW/2;
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);

    //O点
    CGFloat starOrigin = M_PI*7/2;
    CGFloat endOrigin = M_PI*2;
    CGFloat currentOrigin = starOrigin-(starOrigin-endOrigin)*self.progressOne;
    
    //D点
    CGFloat starDest =M_PI*3;
    CGFloat endDest =0;
    CGFloat currentDest = starDest-(starDest-endDest)*self.progressOne;
    
    [path addArcWithCenter:center radius:radius startAngle:currentOrigin endAngle:currentDest clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, hyfLineW);
    
   
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextStrokePath(ctx);
   
}


@end
