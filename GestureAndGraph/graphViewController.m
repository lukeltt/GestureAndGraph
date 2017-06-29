//
//  graphViewController.m
//  GestureAndGraph
//
//  Created by luke on 2017/6/11.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "graphViewController.h"
#import "QuartzY.h"
#import "QuartzX.h"

@interface graphViewController ()
@end

@implementation graphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    QuartzY * quartzY = [[QuartzY alloc]initWithFrame:CGRectMake(0, 0, 120, 650)];
    quartzY.backgroundColor = [UIColor clearColor];
    [self.view addSubview:quartzY];
    [quartzY setNeedsDisplay];
    
    QuartzX * quartzX = [[QuartzX alloc]initWithFrame:CGRectMake(40, 40, 2000, 620)];
    quartzX.backgroundColor = [UIColor clearColor];
    CGRect oldFrame = quartzX.frame;
    [quartzX.layer setAnchorPoint:CGPointMake(0.0f, 1.0f)];
    quartzX.frame = oldFrame;
    [self.view addSubview:quartzX];
    [quartzX setNeedsDisplay];
    
    [self buttonBack];
}
// 返回按钮
-(void)buttonBack{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(150, 650, 115, 50)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)buttonBackAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
