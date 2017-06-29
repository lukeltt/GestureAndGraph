//
//  ViewController.m
//  GestureAndGraph
//
//  Created by luke on 2017/6/11.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "ViewController.h"
#import "gestureViewController.h"
#import "graphViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor=[UIColor cyanColor].CGColor;
    
    UILabel * label = [[UILabel alloc]initWithFrame:self.view.bounds];
    label.text = @"请点击屏幕";
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton * button = [[UIButton alloc]initWithFrame:self.view.bounds];
    [button addTarget:self action:@selector(buttonSkip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
// 界面跳转提示框
-(void)buttonSkip{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你想进入哪个页面" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * alertAction1 = [UIAlertAction actionWithTitle:@"进入手势" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        gestureViewController * gesture = [[gestureViewController alloc]init];
        [self presentViewController:gesture animated:YES completion:nil];
    }];
    
    UIAlertAction * alertAction2 = [UIAlertAction actionWithTitle:@"进入绘图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        graphViewController * graph = [[graphViewController alloc]init];
        [self presentViewController:graph animated:YES completion:nil];
    }];
    
    [alertController addAction:alertAction1];
    [alertController addAction:alertAction2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
