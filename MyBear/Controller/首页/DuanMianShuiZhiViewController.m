//
//  DuanMianShuiZhiViewController.m
//  MyBear
//
//  Created by 林立祥 on 2016/12/3.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "DuanMianShuiZhiViewController.h"
#import "DuanMianTableViewCell.h"
#import "ZhanDianJianCeViewController.h"
@interface DuanMianShuiZhiViewController ()

@end

@implementation DuanMianShuiZhiViewController
@synthesize myTableView;
@synthesize information;
@synthesize dataSource;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"断面水质";
    // Do any additional setup after loading the view from its nib.
    dataSource=[[NSMutableArray alloc]init];
    information=[[NSMutableArray alloc]init];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, ApplicationHeight-44)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    //myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //myTableView.estimatedRowHeight = 1000;
    
    //myTableView.rowHeight = UITableViewAutomaticDimension;
    
    [myTableView setTableFooterView:[[UIView alloc]init]];
    
    [self.view addSubview:myTableView];
    [myTableView registerNib:[UINib nibWithNibName:@"DuanMianTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    
    lObserveNet(cmdjSiteListget);
    
    [lSender jSiteListpagecurrentpage:nil sitename:nil];

    [self web];
}

- (void)web{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, 300)];
//    head.backgroundColor = <##>;
    [myTableView setTableHeaderView:head];
    UIWebView *webView=[[UIWebView alloc]init];
    [head addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.offset=0;
    }];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://114.55.88.18:8090/pc/site_map.vm"]]];
    

}

#pragma mark ========================================
#pragma mark ==UITableView
#pragma mark ========================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return information.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier01=@"cell";
    DuanMianTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
    if (!cell) {
        cell=[[DuanMianTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
    }
    NSDictionary *Dic=[information objectAtIndex:indexPath.section];
    [cell.namelab setTitle:[Dic validStringForKey:@"name"] forState:UIControlStateNormal];
    cell.gaomeng.text=[[Dic objectForKey:@"qualityUi"] validStringForKey:@"water_data_KMnO3"];
    cell.andan.text=[[Dic objectForKey:@"qualityUi"] validStringForKey:@"water_data_NCl"];
    cell.zongling.text=[[Dic objectForKey:@"qualityUi"] validStringForKey:@"water_data_P"];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *Dic=[information objectAtIndex:indexPath.section];
    NSString *name=[Dic validStringForKey:@"name"];
    NSString *siteNum=[Dic validStringForKey:@"siteNum"];
    NSString *ID=[Dic validStringForKey:@"id"];
    ZhanDianJianCeViewController *viewController = [[ZhanDianJianCeViewController alloc]init];
    viewController.ID=ID;
    viewController.name=name;
    viewController.siteNum=siteNum;
    viewController.heliuName= [Dic validStringForKey:@"name"];
    [self.navigationController pushViewController:viewController animated:YES];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, 10)];
    headerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

    
    return headerView;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//    }
//}

#pragma mark ==================================================
#pragma mark == 【网络】与【数据处理】
#pragma mark ==================================================
- (void)KKRequestRequestFinished:(NSDictionary *)requestResult
                  httpInfomation:(NSDictionary *)httpInfomation
               requestIdentifier:(NSString *)requestIdentifier
{
    [MBProgressHUD hideAllHUDsForView:Window0 animated:YES];
    if ([requestIdentifier isEqualToString: cmdjSiteListget]) {
//        [myTableView stopRefreshHeader];
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            [information addObjectsFromArray:[requestResult objectForKey:@"sui_list"]];
            [myTableView reloadData];
        }else{
            
            KKShowNoticeMessage(@"网络错误");
        }
    }
    
    
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
