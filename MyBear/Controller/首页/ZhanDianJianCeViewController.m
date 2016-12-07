//
//  ZhanDianJianCeViewController.m
//  MyBear
//
//  Created by 林立祥 on 2016/12/3.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "ZhanDianJianCeViewController.h"
#import "jiancedianTableViewCell.h"
@interface ZhanDianJianCeViewController ()

@end

@implementation ZhanDianJianCeViewController{
    NSMutableArray *zhiBiaoArr;
    NSMutableArray *dateArr;
    NSMutableArray *showDataArr1;
    NSMutableArray *showDataArr2;
    NSMutableArray *showDataArr3;
    NSMutableArray *showDataArr;
    
    
    
    UIButton *tempBtn;
    
    NSInteger nowtypel;
}
@synthesize myTableView;
@synthesize information;
@synthesize dataSource;
@synthesize name;
@synthesize siteNum;
@synthesize ID;
@synthesize heliuName;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    nowtypel=1;
    [self showNavigationDefaultBackButton_ForNavPopBack];
    self.title=@"站位监测";
    zhiBiaoArr =[[NSMutableArray alloc]init];;
    dataSource=[[NSMutableArray alloc]init];
    information=[[NSMutableDictionary alloc]init];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, ApplicationHeight-44)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //myTableView.estimatedRowHeight = 1000;
    
    //myTableView.rowHeight = UITableViewAutomaticDimension;
    
    [myTableView setTableFooterView:[[UIView alloc]init]];
    
    [self.view addSubview:myTableView];

    
    [myTableView registerNib:[UINib nibWithNibName:@"jiancedianTableViewCell" bundle:nil] forCellReuseIdentifier:@"celll4"];
    
//    
//    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
//    
//    lObserveNet(cmdjSiteListget);
//    
//    [lSender jSiteListpagecurrentpage:@"1" sitename:name siteNum:siteNum];
//
    
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    
    lObserveNet(cmdjSQualityListById);
    
    [lSender jSQualityListById:ID];

//    [self header];
}

- (void)header{
    UIView *headerVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, 200)];
//    headerVIew.backgroundColor = <##>;

    UIWebView *webView=[[UIWebView alloc]init];
    [headerVIew addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.offset=0;
    }];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://114.55.88.18:8090/pc/site_map.vm"]]];
    

    
    [myTableView setTableHeaderView:headerVIew];
}

#pragma mark ========================================
#pragma mark ==UITableView
#pragma mark ========================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([dataSource isNotEmptyArray]) {
        return 3;

    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        static NSString *cellIdentifier01=@"cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
            
            CGFloat height=lsize(40);
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, height, ApplicationWidth/2, 15)];
            lab.font = Lfont(15);
            //            lab.textColor = <##>;
            lab.text= @"南塘河道" ;
            lab.tag=100;
            [cell.contentView addSubview:lab];
            
            height=height+lsize(30);
            
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, height, ApplicationWidth/2, 15)];
            lab1.font = Lfont(15);
            //            lab.textColor = <##>;
            lab1.tag=200;
            lab1.text= @"市级河道" ;
            [cell.contentView addSubview:lab1];
            
            UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame=CGRectMake(ApplicationWidth-15-lsize(125), lsize(50), lsize(125), lsize(30));
            btn1.tag=300;
            [btn1 setTitle:@"南塘路段" forState:UIControlStateNormal];
            [btn1 setCornerRadius:3];
            //            [btn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
            btn1.hidden=YES;
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.backgroundColor=myblue;
            [cell.contentView addSubview:btn1];
            
            [zhiBiaoArr removeAllObjects];
            NSArray *arr=@[@"CODmn",@"NH3-N",@"TP"];
            CGFloat aW=ApplicationWidth-15-3*lsize(60);
            
            UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(aW, CGRectGetMaxY(btn1.frame)+15, 3*lsize(60), lsize(30))];
            [bView setBorderColor:myblue width:1];
            [cell.contentView addSubview:bView];
            
            for (int i=0; i<3; i++) {
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(aW+i*60, CGRectGetMaxY(btn1.frame)+15, lsize(60), lsize(30));
                if (i==0) {
                    btn.selected=YES;
                }
                [btn setTitle:arr[i] forState:UIControlStateNormal];
                btn.tag=123+i;
                [btn addTarget:self action:@selector(zhibiaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [cell.contentView addSubview:btn];
                [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setBackgroundColor:myblue forState:UIControlStateSelected];
                [btn setBorderColor:myblue width:0.5];
                btn.titleLabel.adjustsFontSizeToFitWidth=YES;
                [zhiBiaoArr addObject:btn];
                
            }
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(btn1.frame)+15+lsize(30+15), ApplicationWidth-30, 20)];
            lab2.font = Lfont(15);
            lab2.tag=500;
            lab2.textColor = [UIColor grayColor];
            lab2.text= @"南塘路段侧监测点" ;
            [cell.contentView addSubview:lab2];
            
            
        }
        NSDictionary *dci=[dataSource objectAtIndex:indexPath.row];
        
        
        UILabel *lab=ltag(100);
        lab.text=heliuName;
        
        UILabel *lab1=ltag(200);
        //            lab1.text=[hedaoZiLiaoDic validStringForKey:@""];
        lab1.text=@"";
        
        
        UILabel *lab2=ltag(500);
        lab2.text=[dci validStringForKey:@"riversName"];
        
        UIButton *btn1=ltag(300);
        
//        [btn1 setTitle:[NSString stringWithFormat:@"%@路段",[hedaoZiLiaoDic validStringForKey:@"name"]] forState:UIControlStateNormal];
        
        //        cell.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.5];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
        return cell;
        
    }
    if (indexPath.row==1) {
        static NSString *cellIdentifier01=@"celll4";
        jiancedianTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
        if (!cell) {
            cell=[[jiancedianTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
            
            
        }
        
        NSDictionary *dic=[[information objectForKey:@"qui_list"] objectAtIndex:0];
        cell.lab1.text=[dic validStringForKey:@"water_data_KMnO3"];
        cell.lab2.text=[dic validStringForKey:@"water_data_NCl"];
        cell.lab3.text=[dic validStringForKey:@"water_data_P"];
        cell.lab4.text=@"";

        cell.lab11.text=@"CODmn";
        cell.lab22.text=@"NH3-N";
        cell.lab33.text=@"TP";
        cell.lab44.text=@"";
        
        cell.lab111.text=@"高锰酸钾";
        cell.lab222.text=@"氨氮";
        cell.lab333.text=@"总磷";
        cell.lab444.text=@"";
        
        //                    cell.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.5];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
        return cell;
        
    }
    else {
        static NSString *cellIdentifier01=@"celll5";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
            
        }
        
        [[cell.contentView viewWithTag:1000]removeFromSuperview];
        if ([showDataArr isNotEmptyArray]) {
            [cell.contentView addSubview: [self zhexiantu]];;
            
        }
        
        
        
        //                    cell.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.5];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
        return cell;
        
    }
    
}

- (PNLineChart *)zhexiantu{
    PNLineChart * lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,200.0)];
    //X轴数据
    [lineChart setXLabels:dateArr];
    
    //Y轴数据
    NSArray * data01Array =showDataArr;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    lineChart.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    lineChart.showCoordinateAxis = YES;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    //    //可以添加多条折线
    //    NSArray * data02Array =showDataArr;
    //    PNLineChartData *data02 = [PNLineChartData new];
    //    data02.color = PNTwitterColor;
    //    data02.itemCount = lineChart.xLabels.count;
    //    data02.getData = ^(NSUInteger index) {
    //        CGFloat yValue = [data02Array[index] floatValue];
    //        return [PNLineChartDataItem dataItemWithY:yValue];
    //    };
    
    //    lineChart.chartData = @[data01, data02];
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    //加载在视图上
    return lineChart;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return lsize(160);
        
    }else if(indexPath.row==1){
        return lsize(110);
    }
    else{
        return 200;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return <#expression#>;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, <#CGFloat height#>)];
//    headerView.backgroundColor = <##>;
//
//
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return <#expression#>;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, <#CGFloat height#>)];
//    footerView.backgroundColor = <##>;
//
//
//    return footerView;
//
//}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ==================================================
#pragma mark == 【网络】与【数据处理】
#pragma mark ==================================================
- (void)KKRequestRequestFinished:(NSDictionary *)requestResult
                  httpInfomation:(NSDictionary *)httpInfomation
               requestIdentifier:(NSString *)requestIdentifier
{
    [MBProgressHUD hideAllHUDsForView:Window0 animated:YES];
    if ([requestIdentifier isEqualToString: cmdjSQualityListById]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            [information addEntriesFromDictionary:requestResult];
            [dataSource addObjectsFromArray:[information objectForKey:@"qui_list"]];
            dateArr=[[NSMutableArray alloc]init];
            showDataArr1=[[NSMutableArray alloc]init];
            showDataArr2=[[NSMutableArray alloc]init];
            showDataArr3=[[NSMutableArray alloc]init];
            for (int i=0; i<dataSource.count; i++) {
                NSDictionary *dic=[dataSource objectAtIndex:i];
                
                NSString *Date=[dic validStringForKey:@"update_date"];
               NSString *string = [NSDate getStringFromOldDateString:Date withOldFormatter:KKDateFormatter04 newFormatter:KKDateFormatter06];
                [dateArr addObject:string];
                
                NSString *stirng1=[dic validStringForKey:@"water_data_KMnO3"];
                NSString *stirng2=[dic validStringForKey:@"water_data_NCl"];
                NSString *stirng3=[dic validStringForKey:@"water_data_P"];

                [showDataArr1 addObject:stirng1];
                [showDataArr2 addObject:stirng2];
                [showDataArr3 addObject:stirng3];
                
                
            }
            
            showDataArr=showDataArr1;
            [myTableView reloadData];
            
            
        }
            else{
                KKShowNoticeMessage(@"网络错误");
            }
        }else{
            
            KKShowNoticeMessage(@"网络错误");
        }
    
    
    
}

- (void)zhibiaoBtnClick:(UIButton *)btn{
    if (tempBtn&&tempBtn==btn) {
        return;
    }
    btn.selected=!btn.selected;
    for (UIButton *abtn in zhiBiaoArr) {
        if (abtn==btn) {
            
        }else{
            abtn.selected=NO;
        }
    }
    
    tempBtn=btn;
    
    
    NSInteger index=btn.tag-123;
    if (index==0) {
        showDataArr=showDataArr1;
        
    }
    if (index==1) {
        showDataArr=showDataArr2;
        
    }
    if (index==3) {
        showDataArr=showDataArr3;
        
    }
    
    [myTableView reloadData];
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
