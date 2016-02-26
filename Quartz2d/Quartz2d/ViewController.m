//
//  ViewController.m
//  Quartz2d
//
//  Created by 张广洋 on 16/1/29.
//  Copyright © 2016年 张广洋. All rights reserved.
//

#import "ViewController.h"

#import "MyView.h"

@interface ViewController ()
{
    MyView * _view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _view =[[MyView alloc]initWithFrame:CGRectMake(10, 30, 300, 300)];
    _view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_view];
    
    
}

- (IBAction)touched:(id)sender {
    [_view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
