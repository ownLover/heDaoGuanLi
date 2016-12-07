//
//  BaseViewController.m
//  MyBaseProject
//
//  Created by Bear on 16/1/6.
//  Copyright (c) 2016年 Bear. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property(nonatomic,strong)UIButton *centerBtn;

@end

@implementation BaseViewController
@synthesize centerBtn;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    self.view.backgroundColor=[UIColor whiteColor];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%ld.png",(long)arc4random()%5]]];
    
}

- (void)setNav

{
    
    //背景颜色
    if(CA_IOS_VERSION(7))
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.27 green:0.73 blue:0.98 alpha:1];
    else
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.27 green:0.73 blue:0.98 alpha:1];
    
    
    
    //字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

        
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
