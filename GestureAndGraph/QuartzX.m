//
//  QuartzX.m
//  GestureAndGraph
//
//  Created by luke on 2017/6/11.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "QuartzX.h"
#import "QuartzLine.h"

NSMutableDictionary * dic;
QuartzLine * quartzLine;

@implementation QuartzX

- (void)drawRect:(CGRect)rect {
    dic = [[NSMutableDictionary alloc]init];

    [self drawXAxis];
    [self drawLineChart];
    [self pinchGesture];
    [self longPressGesture];
}
// X轴
-(void)drawXAxis{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [COLOR2 setStroke];
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, 0, 580);
    CGContextAddLineToPoint(context, 2000, 580);
    
    for (int i=1; i<51; i++) {
        CGContextMoveToPoint(context, i*40, 580);
        CGContextAddLineToPoint(context,i*40, 575);
        
        NSString * str1 = [NSString stringWithFormat:@"%.1f",3.0+(float)(i-1)*0.1];
        [str1 drawInRect:CGRectMake(i*40, 590, 20, 20) withAttributes:nil];
    }

    CGContextStrokePath(context);
}
// 折线图
-(void)drawLineChart{
    CGContextRef context = UIGraphicsGetCurrentContext();

    [COLOR3 setStroke];
    CGContextSetLineWidth(context, 2.0);
    
    for (int i=1; i<51; i++) {
        
        int number = arc4random() % 10 + 20;
        
        int mx = i*40;
        int my =580-number*5;
        NSString * mxString = [NSString stringWithFormat:@"%d",mx];
        NSString * myString = [NSString stringWithFormat:@"%d",my];
        [dic setValue:myString forKey:mxString];
        
        NSString * str = [NSString stringWithFormat:@"%d",number];
        [str drawInRect:CGRectMake(mx, my-20, 20, 20) withAttributes:nil];
        
        if (i==1) {
            CGContextMoveToPoint(context, mx, my);
        }else{
            CGContextAddLineToPoint(context, mx, my);
        }
    }
    CGContextStrokePath(context);
}
// 缩放手势
-(void)pinchGesture{
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    [self addGestureRecognizer:pinch];
}
-(void)pinchAction:(UIPinchGestureRecognizer *)sender{
    CGFloat scale = sender.scale;
    self.transform = CGAffineTransformMakeScale(scale, 1);
}
// 长按手势
-(void)longPressGesture{
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [self addGestureRecognizer:longPress];
}
-(void)longPressAction:(UILongPressGestureRecognizer *)sender{

        CGPoint clickPoint = [sender locationInView:self];
        CGPoint myPoint = clickPoint;
    
        int distance;
        int min = 2000;
        
        for (NSString * item in dic) {
            int mx = item.intValue;
            NSString * item2 = [dic valueForKey:item];
            int my = item2.intValue;
            
            distance =sqrtf((mx-clickPoint.x)*(mx-clickPoint.x) + (my-clickPoint.y)*(my-clickPoint.y));
            
            if (distance < min) {
                min = distance;
                myPoint.x = mx;
                myPoint.y = my;
            }
        }
        
    if (sender.state == UIGestureRecognizerStateBegan) {
        quartzLine = [[QuartzLine alloc]initWithFrame:self.bounds];
        quartzLine.backgroundColor = [UIColor clearColor];
        [self addSubview:quartzLine];
        [quartzLine point:myPoint];
    }else
        if (sender.state == UIGestureRecognizerStateEnded){
        [quartzLine removeFromSuperview];
    }
}
@end
