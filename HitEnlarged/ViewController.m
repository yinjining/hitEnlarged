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
    [button setTitle:@"我是button，超出我50个点内，我还能响应" forState:UIControlStateNormal];
    button.enlargedMargin = 50;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 250, 30)];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是label，超出我30个点内，我还能响应";
    label.enlargeEdge = UIEdgeInsetsMake(30, 30, 30, 30);
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [label addGestureRecognizer:tap1];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 350, 200, 150)];
    [view setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:view];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(-20,50, 250, 30)];
    label2.backgroundColor = [UIColor redColor];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"父试图困不住我，超出30个点内，我都能响应";
    label2.userInteractionEnabled = YES;
    [view addSubview:label2];
    label2.enlargeEdge = UIEdgeInsetsMake(30, 30, 30, 30);
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick2:)];
    [label2 addGestureRecognizer:tap2];
}


-(void)buttonClick:(UIButton *)button{
    NSLog(@"我是button，我被点击了");
}

-(void)tapClick:(UIGestureRecognizer *)gesture{
    NSLog(@"我是view，我被点击了");
}

-(void)tapClick2:(UIGestureRecognizer *)gesture{
    NSLog(@"我比较吊，超出父视图我还能响应");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
