//
//  HeDaoSouSuoViewController.m
//  MyBear
//
//  Created by 林立祥 on 2016/12/5.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "HeDaoSouSuoViewController.h"
#import "HeDaoSOUSUOTableViewCell.h"
#import "RiverInfoViewController.h"

@interface HeDaoSouSuoViewController ()
@property (retain, nonatomic)MKMapView *mapView;
@property (strong, nonatomic) MKPolyline *myPolyline;

@end

@implementation HeDaoSouSuoViewController{
    UITextField *textField;
    UIButton *sousouBtn;
    NSInteger nowPage;
    NSMutableArray *quXianArr;
    UILabel *lab1;
    
    
    NSMutableArray *showArr;
}
@synthesize myTableView;
@synthesize information;
@synthesize dataSource;
@synthesize mapView;
@synthesize myPolyline;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    nowPage=1;
    quXianArr=[[NSMutableArray alloc]init];
    showArr=[[NSMutableArray alloc]init];
    [self showNavigationDefaultBackButton_ForNavPopBack];
    self.title=@"河道搜索";
    dataSource=[[NSMutableArray alloc]init];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, ApplicationHeight-22)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //myTableView.estimatedRowHeight = 1000;
    
    //myTableView.rowHeight = UITableViewAutomaticDimension;
    
    [myTableView setTableFooterView:[[UIView alloc]init]];
    
    [self.view addSubview:myTableView];

    [myTableView registerNib:[UINib nibWithNibName:@"HeDaoSOUSUOTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self header];
    
    
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    
    lObserveNet(cmdappRiversList);
    
    [lSender appRiversListall];

    
}

- (void)header{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, 45+60+200)];
//    headerView.backgroundColor = <##>;
    [myTableView setTableHeaderView:headerView];
    
    UIView *circle = [[UIView alloc]initWithFrame:CGRectMake(20, 15, ApplicationWidth-20-15*2-80, 30)];
    [headerView addSubview:circle];
    [circle setBorderColor:myblue width:1];
    [circle setCornerRadius:3];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.frame=CGRectMake(5, 2.5, 25, 25);
    [img setImage:Limage(@"搜索")];
    [circle addSubview:img];

    textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+5, 0, CGRectGetWidth(circle.frame)-CGRectGetMaxX(img.frame)-5, 30)];
    textField.placeholder = @"输入河道名称...";
    [circle addSubview:textField];

    sousouBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sousouBtn.frame=CGRectMake(CGRectGetMaxX(circle.frame)+15, 15, 80, 30);
    [sousouBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [sousouBtn addTarget:self action:@selector(sousouBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sousouBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sousouBtn.backgroundColor=myblue;
    [sousouBtn setCornerRadius:3];
    [headerView addSubview:sousouBtn];

    mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 60, ApplicationWidth, 200)];
    [self map];
    [headerView addSubview:self.mapView];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(mapView.frame)+10, ApplicationWidth/2, 16)];
    lab.font = Lfont(15);
//    lab.textColor = <##>;
    lab.text= @"区域切换" ;
    [headerView addSubview:lab];
    
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(mapView.frame)+10, ApplicationWidth/2, 16)];
    lab1.font = Lfont(15);
//    lab1.textColor = <##>;
    lab1.text= @"温州市" ;
    [headerView addSubview:lab1];


    UILabel *lab2 = [[UILabel alloc]init];
//    lab2.font = <##>;
    lab2.frame=CGRectMake(ApplicationWidth-15-30, CGRectGetMaxY(mapView.frame)+10, 30, 16);
    lab2.text= @">" ;
    lab2.textAlignment=NSTextAlignmentRight;
    [headerView addSubview:lab2];

    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, CGRectGetMaxY(mapView.frame), ApplicationWidth, 45);
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changgeBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerView addSubview:btn];


}

-(void)changgeBtnCLick{

    NSMutableArray  *array = [[NSMutableArray alloc]init];;
    for (int i=0; i<quXianArr.count; i++) {
        NSDictionary *dic=[quXianArr objectAtIndex:i];
        NSDictionary *dic01 = [NSDictionary dictionaryWithObjectsAndKeys:
                               dic[@"name"],@"title",
                               dic[@"id"],@"id",nil];
        [array addObject:dic01];
    }
    
    [KKDataPickerView showWithDelegate:self dataSource:array textKey:@"title" identifierKey:nil];

    
}

#pragma mark ===========================================
#pragma mark == KKDataPickerViewDelegate
#pragma mark ===========================================
- (void)KKDataPickerView:(KKDataPickerView *)dataPickerView didSelectedInformation:(id)aInformation identifierKey:(NSString *)aIdentifierKey
{
    ;
    ;
    lab1.text=[aInformation objectForKey:@"title"];
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    
    lObserveNet(cmdchaheliu);
    
    [lSender chaheliu:[aInformation objectForKey:@"id"]];

}



- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *lineview = [[MKPolylineView alloc] initWithOverlay:overlay];
        lineview.strokeColor = [UIColor redColor];
        lineview.lineWidth = 2;
        
        return lineview;
    }
    return nil;
}

- (void)map{
//    self.mapView.delegate = self;
//    
//    CLLocationCoordinate2D pointToUse[2];
////    NSArray *arr = [gongshidituDic validArrayForKey:@"river_map_list"];
//    for (NSInteger i = 0; i < arr.count-2; i++) {
//        NSDictionary *ddic=arr[i];
//        NSString *lon = [ddic validStringForKey:@"bdx"];
//        NSString *lat =[ddic validStringForKey:@"bdy"] ;
//        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
//        pointToUse[0] = coordinate;
//        
//        NSDictionary *ddic1=arr[i+1];
//        NSString *lon2 = [ddic1 validStringForKey:@"bdx"];
//        NSString *lat2 = [ddic1 validStringForKey:@"bdy"];
//        CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake([lat2 doubleValue], [lon2 doubleValue]);
//        pointToUse[1] = coordinate2;
//        
//        self.myPolyline = [MKPolyline polylineWithCoordinates:pointToUse count:2];
//        [self.mapView addOverlay:self.myPolyline];
//    }
    
}


- (void)sousouBtnClick{
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    
    lObserveNet(cmdsousou);
    
    [lSender sousou:textField.text];;

}

#pragma mark ========================================
#pragma mark ==UITableView
#pragma mark ========================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier01=@"cell";
    HeDaoSOUSUOTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
    if (!cell) {
        cell=[[HeDaoSOUSUOTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
    }
    [cell.btn setBorderColor:[UIColor blackColor] width:0.8];
    NSDictionary *dic=showArr[indexPath.row];
    cell.name.text=[dic validStringForKey:@"name"];
    cell.name1.text=[dic validStringForKey:@"areaName"];
    cell.img.backgroundColor=[UIColor lightGrayColor];

    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RiverInfoViewController *viewController = [[RiverInfoViewController alloc]init];
    NSDictionary *dic=showArr[indexPath.row];

    viewController.riverID=[dic validStringForKey:@"id"];
    [self.navigationController pushViewController:viewController animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
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



#pragma mark ==================================================
#pragma mark == 刷新数据
#pragma mark ==================================================
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.refreshFooterAuto) {
        [scrollView.refreshFooterAuto refreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.refreshFooterAuto) {
        [scrollView.refreshFooterAuto refreshScrollViewDidEndDragging:scrollView];
    }
}


- (void)refreshTableFooterAutoViewDidTriggerRefresh:(KKRefreshFooterAutoView*)view{
    nowPage=nowPage+1;
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    
    lObserveNet(cmdappRiversListmore);
    
    [lSender appRiversListallWithPage:LString(nowPage)];
    
    
}


#pragma mark ==================================================
#pragma mark == 【网络】与【数据处理】
#pragma mark ==================================================
- (void)KKRequestRequestFinished:(NSDictionary *)requestResult
                  httpInfomation:(NSDictionary *)httpInfomation
               requestIdentifier:(NSString *)requestIdentifier
{
    [MBProgressHUD hideAllHUDsForView:Window0 animated:YES];
    if ([requestIdentifier isEqualToString: cmdappRiversList]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            
            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
            
            lObserveNet(cmdareaListById);
            
            [lSender areaListById:@"1"];

            
            
            NSDictionary *dic=[requestResult objectForKey:@"Page"];
            if ([[dic objectForKey:@"currentPage"]integerValue]<[[dic objectForKey:@"pageSize"]integerValue]) {
                [myTableView showRefreshFooterAutoWithDelegate:self];
            }else{
                [myTableView hideRefreshFooterAuto];

            }
            
            NSArray *arr=[requestResult objectForKey:@"rivers_list"];
            
            [showArr addObjectsFromArray:arr];
            [dataSource addObjectsFromArray:arr];
            [myTableView reloadData];
            
        }else{
            
            KKShowNoticeMessage(@"网络错误");
        }
    }
    
    if ([requestIdentifier isEqualToString: cmdappRiversListmore]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic=[requestResult objectForKey:@"Page"];
            if ([[dic objectForKey:@"currentPage"]integerValue]<[[dic objectForKey:@"pageSize"]integerValue]) {
                [myTableView showRefreshFooterAutoWithDelegate:self];
            }else{
                [myTableView hideRefreshFooterAuto];
                
            }
            
            NSArray *arr=[requestResult objectForKey:@"rivers_list"];
            [showArr addObjectsFromArray:arr];

            [dataSource addObjectsFromArray:arr];
            [myTableView reloadData];
            
        }else{
            
            KKShowNoticeMessage(@"网络错误");
        }
    }
    if ([requestIdentifier isEqualToString: cmdareaListById]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            [quXianArr removeAllObjects];
            [quXianArr addObjectsFromArray:[requestResult objectForKey:@"area_list"]];

            
        }else{
            
            KKShowNoticeMessage(@"网络错误");
        }
    }
    
    if ([requestIdentifier isEqualToString: cmdchaheliu]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            [showArr removeAllObjects];
            [showArr addObjectsFromArray:[requestResult objectForKey:@"rivers_list"]];
            
            [myTableView reloadData];
        }else{
            
            KKShowNoticeMessage(@"网络错误");
        }
    }
    if ([requestIdentifier isEqualToString: cmdsousou]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            [showArr removeAllObjects];
            [showArr addObjectsFromArray:[requestResult objectForKey:@"rivers_list"]];
            
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
