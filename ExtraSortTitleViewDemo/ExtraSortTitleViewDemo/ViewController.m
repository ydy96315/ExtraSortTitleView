//
//  ViewController.m
//  ExtraSortTitleViewDemo
//
//  Created by 叶达逸 on 2018/7/29.
//  Copyright © 2018年 叶达逸. All rights reserved.
//

#import "ViewController.h"
#import "ExtraSortTitleView.h"
@interface ViewController ()<ExtraSortTitleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    ExtraSortTitleView *sortTitleViewDefaultStyle = [[ExtraSortTitleView alloc] initWithDefaultStyleAndFrame:CGRectMake(0, 64, 300, 42) AndTitles:@[@"新闻1",@"新闻2"]];
    [self.view addSubview:sortTitleViewDefaultStyle];
    
    
    
    // 相关的一些属性调整都在这个类中
    ExtraSortTitleViewStyle *style =  [[ExtraSortTitleViewStyle alloc] init];
    style.normalColor = [UIColor yellowColor];
    style.selectColor = [UIColor redColor];
    style.bottomLineColor = [UIColor blueColor];
//    style.isScrollEnable = NO;
    
    // 建议使用该方式创建  可以根据业务自由设置style
    ExtraSortTitleView *sortTitleView = [[ExtraSortTitleView alloc] initWithFrame:CGRectMake(0, 200, 300, 42) AndStyle:style AndTitles:@[@"新闻1",@"新闻2",@"新闻3",@"新闻4",@"新闻5",@"新闻6",@"新闻7",@"新闻8"]];
    sortTitleView.delegate = self;
    [self.view addSubview:sortTitleView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)titleLabelClickedWithCurrentIndex:(NSInteger)currentIndex{
    NSLog(@"点击了----%ld",(long)currentIndex);
}

@end
