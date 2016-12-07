//
//  ViewController.m
//  MyBear
//
//  Created by Bears on 16/9/30.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "ViewController.h"
#import "NewsViewController.h"
#import "RiverInfoViewController.h"
#import "MainViewController.h"
#import "ComplainOptionViewController.h"
#import "PersonalCenterViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [LUITabBarController LUITabBarController:@[[NewsViewController new],[RiverInfoViewController new],[MainViewController new],[ComplainOptionViewController new],[PersonalCenterViewController new]] titleArr:@[@"新闻资讯",@"河道信息",@"首页",@"投诉公示",@"个人中心"] imageArr:@[@"wo",@"wo",@"wo",@"wo",@"wo"]];
}

- (void)centerBtnClick{
    UITabBarController *tab = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    tab.selectedIndex=3;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
