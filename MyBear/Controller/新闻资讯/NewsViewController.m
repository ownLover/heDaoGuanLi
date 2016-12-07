//
//  NewsViewController.m
//  MyBear
//
//  Created by Bears on 16/11/21.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "NewsViewController.h"
#import "HeDaoSouSuoViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    HeDaoSouSuoViewController *viewController = [[HeDaoSouSuoViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
