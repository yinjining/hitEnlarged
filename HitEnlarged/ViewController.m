//
//  ViewController.m
//  HitEnlarged
//
//  Created by yinjn on 2018/8/6.
//  Copyright © 2018年 殷继宁. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JNHitEnlarged.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 250, 30);
    [button setTitle:@"我是button，超出我50个点，我还能响应" forState:UIControlStateNormal];
    button.enlargedMargin = 50;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button];
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 250, 30)];
//    label.backgroundColor = [UIColor redColor];
//    label.font = [UIFont systemFontOfSize:12];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"我是label，超出我30个点，我还能响应";
//    label.enlargeEdge = UIEdgeInsetsMake(30, 30, 30, 30);
//    label.userInteractionEnabled = YES;
//    [self.view addSubview:label];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 300, 200, 40)];
    [view setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是label，超出我30个点，我还能响应";
    label.enlargeEdge = UIEdgeInsetsMake(30, 30, 30, 30);
    label.userInteractionEnabled = YES;
    [view addSubview:label];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [label addGestureRecognizer:tap1];
}


-(void)buttonClick:(UIButton *)button{
    NSLog(@"我是button，我被点击了");
}

-(void)tapClick:(UIGestureRecognizer *)gesture{
    NSLog(@"我是view，我被点击了");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
