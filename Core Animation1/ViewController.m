//
//  ViewController.m
//  Core Animation1
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 贺亚飞. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"

@interface ViewController ()
@property (nonatomic,strong) AnimationView *animaview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animaview = [[AnimationView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
//    _animaview.backgroundColor=[UIColor lightGrayColor];
    
    [self.view addSubview:self.animaview];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    [btn setTitle:@"成功" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
    [btn1 setTitle:@"失败" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
}
-(void)btnClick:(UIButton *)button
{
    [self.animaview starAnimationWithState:YES];
}
-(void)btnClick1:(UIButton *)but{

    [self.animaview starAnimationWithState:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
