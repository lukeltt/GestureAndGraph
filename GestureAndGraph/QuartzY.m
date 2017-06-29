//
//  QuartzY.m
//  GestureAndGraph
//
//  Created by luke on 2017/6/11.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "QuartzY.h"

@implementation QuartzY

- (void)drawRect:(CGRect)rect {
    [self drawYAxis];
}
// Y轴
-(void)drawYAxis{
    [@"水位/m" drawInRect:CGRectMake(0, 40, 100, 20) withAttributes:nil];
    
    for (int i=0; i<6; i++) {
        NSString * str = [NSString stringWithFormat:@"%4i", i*20];
        [str drawInRect:CGRectMake(10, 20+(6-i)*100, 30, 20) withAttributes:nil];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [COLOR1 setStroke];
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, 40, 40);
    CGContextAddLineToPoint(context, 40, 620);
    
    CGContextStrokePath(context);
}
@end
