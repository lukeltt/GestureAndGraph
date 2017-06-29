//
//  gestureViewController.m
//  GestureAndGraph
//
//  Created by luke on 2017/6/11.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "gestureViewController.h"

@interface gestureViewController ()
@end

UIView * yellowView;
UILabel * label;
UILabel * gestureLabel;
NSMutableArray * buttonChooseArray;
NSMutableArray * buttonTitleArray;
NSString * item;

@implementation gestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor=[UIColor cyanColor].CGColor;
    
    buttonChooseArray = [[NSMutableArray alloc]init];
    buttonTitleArray = [[NSMutableArray alloc]initWithObjects:
                        @"滑动",@"轻扫",@"边缘",@"长按",@"缩放",@"点击",@"旋转", nil];
    
    [self yellowView];
    [self buttonBack];
    [self buttonChoose];
    [self gesture];
}
// 黄色view
-(void)yellowView{
    yellowView = [[UIView alloc]initWithFrame:CGRectMake(7, 300, 400, 300)];
    yellowView.layer.backgroundColor=[UIColor yellowColor].CGColor;
    
    label = [[UILabel alloc]initWithFrame:yellowView.bounds];
    label.text = @"请点击上面的按钮，完成相关手势操作";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [yellowView addSubview:label];
    
    [self.view addSubview:yellowView];
}
// 返回按钮
-(void)buttonBack{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(150, 620, 115, 50)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)buttonBackAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 手势选择按钮
-(void)buttonChoose{
    for (int i=0; i<4; i++) {
        UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(20+55*(3-i), 70+50*i, 50, 50)];
        button1.tag = 100 + i;
        [buttonChooseArray addObject:button1];
        if (i!=0) {
            UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(20+55*(3+i), 70+50*i, 50, 50)];
            button2.tag = 200 + i;
            [buttonChooseArray addObject:button2];
        }
    }
    
    for(int i=0;i<buttonChooseArray.count;i++){
        UIButton * button = [buttonChooseArray objectAtIndex:i];
        [button setTitle:[buttonTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor orangeColor];
        button.layer.cornerRadius=25;
        [button addTarget:self action:@selector(buttonChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)buttonChooseAction:(UIButton*)sender{
    
    for (UIButton * button in buttonChooseArray) {
        if (button.tag == sender.tag) {
            button.backgroundColor=[UIColor purpleColor];
        }else{
            button.backgroundColor = [UIColor orangeColor];
        }
    }

    label.text=sender.titleLabel.text;
}
// 手势操作
-(void)gesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [yellowView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction)];
    [yellowView addGestureRecognizer:longPress];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [yellowView addGestureRecognizer:swipe];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction)];
    [yellowView addGestureRecognizer:pan];
    
    UIScreenEdgePanGestureRecognizer * edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanAction)];
    edgePan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:edgePan];
    
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction)];
    [yellowView addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer * rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction)];
    [yellowView addGestureRecognizer:rotation];
}
-(void)tapAction{
    item=@"点击";
    [self checkGesture:item];
}
-(void)longPressAction{
    item=@"长按";
    [self checkGesture:item];
}
-(void)swipeAction{
    item=@"轻扫";
    [self checkGesture:item];
}
-(void)panAction{
    item=@"滑动";
    [self checkGesture:item];
}
-(void)edgePanAction{
    item=@"边缘";
    [self checkGesture:item];
}
-(void)pinchAction{
    item=@"缩放";
    [self checkGesture:item];
}
-(void)rotationAction{
    item=@"旋转";
    [self checkGesture:item];
}

// 判断手势
-(void)checkGesture:(NSString *)item{
    for (UIButton * button in buttonChooseArray) {
        if (button.backgroundColor == [UIColor purpleColor]) {
            if ([button.titleLabel.text isEqualToString:item]) {
                [self animation];
            }
        }
    }
}

// 动画
-(void)animation{
    NSString * suffixItem = @"方法已经触发";
    if (gestureLabel != nil) {
        [gestureLabel removeFromSuperview];
    }
    gestureLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 100)];
    gestureLabel.backgroundColor = [UIColor darkGrayColor];
    gestureLabel.alpha = 0.6;
    gestureLabel.text = [item stringByAppendingString:suffixItem];
    gestureLabel.textColor = [UIColor whiteColor];
    gestureLabel.textAlignment=NSTextAlignmentCenter;
    gestureLabel.adjustsFontSizeToFitWidth=true;
    [self.view addSubview:gestureLabel];
    
    [UIView animateWithDuration:4 animations:^{
        gestureLabel.frame = CGRectMake(100, 736, 200, 100);
    }];
    
    for (UIButton * button in buttonChooseArray) {
        if (button.backgroundColor == [UIColor purpleColor]) {
            button.backgroundColor = [UIColor orangeColor];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
