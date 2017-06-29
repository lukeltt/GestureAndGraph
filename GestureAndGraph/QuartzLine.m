//
//  QuartzLine.m
//  GestureAndGraph
//
//  Created by luke on 2017/6/26.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "QuartzLine.h"

CGPoint drawPoint;

@implementation QuartzLine

- (void)drawRect:(CGRect)rect {
    [self drawLine];
}
// 画直线
-(void)drawLine{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [COLOR4 setStroke];
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, drawPoint.x, 0);
    CGContextAddLineToPoint(context, drawPoint.x, 580);
    
    NSString * time = [[NSString alloc]initWithFormat:@"时间：%.1f",3.0+(drawPoint.x/40-1)*0.1];
    NSString * level = [[NSString alloc]initWithFormat:@"水位：%dm",(int)(580-drawPoint.y)/5];
    
    [time drawInRect:CGRectMake(drawPoint.x+20, 100, 100, 30) withAttributes:nil];
    [level drawInRect:CGRectMake(drawPoint.x+20, 130, 100, 30) withAttributes:nil];
    
    CGContextStrokePath(context);
}
// 获取坐标点并重绘
-(void)point:(CGPoint)point{
    drawPoint = point;
    [self setNeedsDisplay];
}
@end
