//
//  ViewController.m
//  StageCircleView
//
//  Created by 王宗成 on 2017/12/20.
//  Copyright © 2017年 王宗成. All rights reserved.
//

#import "ViewController.h"
#import "StageCircleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    StageCircleView *view = [[StageCircleView alloc]initWithFrame:CGRectMake(100, 100, 300, 300) lineWidth:15 defaultColor:[UIColor lightGrayColor]];
    view.dataSource = @[@{@"startPoint":@1,@"endPoint":@4},@{@"startPoint":@5,@"endPoint":@10},@{@"startPoint":@15,@"endPoint":@20},@{@"startPoint":@25,@"endPoint":@31},@{@"startPoint":@32,@"endPoint":@34},@{@"startPoint":@35,@"endPoint":@46},@{@"startPoint":@47,@"endPoint":@48}];
    view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
