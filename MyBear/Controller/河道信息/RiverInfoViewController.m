//
//  RiverInfoViewController.m
//  MyBear
//
//  Created by Bears on 16/11/21.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "RiverInfoViewController.h"
#import "HedaoTableViewCell1.h"
#import "cell2.h"
#import "xinxigognkaiTableViewCell.h"
#import "jiancedianTableViewCell.h"




@interface RiverInfoViewController ()
@property (retain, nonatomic)MKMapView *mapView;
@property (strong, nonatomic) MKPolyline *myPolyline;

@end

@implementation RiverInfoViewController{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    NSMutableArray *btnArr;
    
    NSMutableArray *xiajiArr;
    
    NSInteger nowType;
    
    NSMutableDictionary *xinxiGongKaiDic;
    
    NSMutableDictionary *xunHeJiLuDic;
    NSMutableDictionary *shuiZhiXinXiDic;
    
    NSMutableArray *zhiBiaoArr;
    
    
    UIButton *tempBtn;
    
    NSMutableArray *arr1;
    NSMutableArray *arr2;
    NSMutableArray *arr3;
    NSMutableArray *arr4;
    NSMutableArray *dateArr;
    
    NSMutableArray *showDataArr;
    NSDictionary *hedaoZiLiaoDic;;
    
    
    NSDictionary *gongshidituDic;;;
    NSDictionary *yiheyiceDic;;;

    
}
@synthesize mapView;
@synthesize riverID;

- (void)NavRightButtonClick{
    
}

- (PNLineChart *)zhexiantu{
    PNLineChart * lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,200.0)];
    //X轴数据
    lineChart.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [lineChart setXLabels:dateArr];
    lineChart.showCoordinateAxis = YES;

    //Y轴数据
    NSArray * data01Array =showDataArr;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"河道信息";
    [self setNavRightButtonTitle:@"搜索" selector:@selector(NavRightButtonClick)];
    zhiBiaoArr=[[NSMutableArray alloc]init];
    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
    [self observeKKRequestNotificaiton:cmdappRiversList];

    if (riverID) {
        [[Net defaultSender]appRiversListriversid:riverID chiefid:@"4"];

    }else{
        [[Net defaultSender]appRiversListriversid:@"1" chiefid:@"4"];

    }
    xiajiArr=[[NSMutableArray alloc]init];
    dataSource=[[NSMutableArray alloc]init];
    btnArr=[[NSMutableArray alloc]init];
    showDataArr=[[NSMutableArray alloc]init];
    
}

- (void)initUI{
    self.automaticallyAdjustsScrollViewInsets=NO;
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ApplicationWidth, ApplicationHeight-64-22)];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    
    
    [myTableView registerNib:[UINib nibWithNibName:@"HedaoTableViewCell1" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [myTableView registerNib:[UINib nibWithNibName:@"cell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [myTableView registerNib:[UINib nibWithNibName:@"xinxigognkaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    [myTableView registerNib:[UINib nibWithNibName:@"jiancedianTableViewCell" bundle:nil] forCellReuseIdentifier:@"celll4"];
}

- (void)setHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, lsize(60))];
    //    <##>.backgroundColor = <##>;
    [myTableView setTableHeaderView:headerView];;
    
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(lsize(15), lsize(15), ApplicationWidth-lsize(15)*2, lsize(30))];
    //    <##>.backgroundColor = <##>;
    [headerView addSubview:aview];
    [aview setBorderColor:myblue width:1];
    [aview setCornerRadius:3];
    
    [btnArr removeAllObjects];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*CGRectGetWidth(aview.frame)/4, 0, CGRectGetWidth(aview.frame)/4, lsize(30));
        if (i==0) {
            btn.selected=YES;
        }
        NSArray *arr=@[@"河道基础",@"电子公告",@"河道水质",@"信息公开"];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        [btn setTitleColor:myblue forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:myblue forState:UIControlStateSelected];
        [aview addSubview:btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(aview.frame)/4-0.5, 0, 1, lsize(30))];
        line.backgroundColor = myblue;
        [aview addSubview:line];
        
        
        [btnArr addObject:btn];
    }
    
}

- (void)setHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, lsize(360))];
//    <##>.backgroundColor = <##>;
    [myTableView setTableHeaderView:headerView];;

    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(lsize(15), lsize(15), ApplicationWidth-lsize(15)*2, lsize(30))];
//    <##>.backgroundColor = <##>;
    [headerView addSubview:aview];
    [aview setBorderColor:myblue width:1];
    [aview setCornerRadius:3];
    
    [btnArr removeAllObjects];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*CGRectGetWidth(aview.frame)/4, 0, CGRectGetWidth(aview.frame)/4, lsize(30));
        if (i==nowType) {
            btn.selected=YES;
        }else{
            btn.selected=NO;

        }
        NSArray *arr=@[@"河道基础",@"电子公告",@"河道水质",@"信息公开"];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        [btn setTitleColor:myblue forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:myblue forState:UIControlStateSelected];
        [aview addSubview:btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(aview.frame)/4-0.5, 0, 1, lsize(30))];
        line.backgroundColor = myblue;
        [aview addSubview:line];

        
        [btnArr addObject:btn];
    }
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(aview.frame)+5, ApplicationWidth, lsize(290))];
    img.backgroundColor=[UIColor lightGrayColor];
//    [img setImage:<#(UIImage *)#>];
    img.userInteractionEnabled=YES;
    [headerView addSubview:img];
    
    
    UIButton *tousuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tousuBtn.frame=CGRectMake(0, 0, 80, 20);
    [tousuBtn setTitle:@"投诉" forState:UIControlStateNormal];
    [tousuBtn addTarget:self action:@selector(tousuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tousuBtn.backgroundColor=[UIColor colorWithRed:0.95 green:0.26 blue:0.08 alpha:1];
    [tousuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [img addSubview:tousuBtn];
    
    UIButton *jianyiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    jianyiBtn.frame=CGRectMake(100, 0, 80, 20);
    [jianyiBtn setTitle:@"建议" forState:UIControlStateNormal];
    [jianyiBtn addTarget:self action:@selector(tousuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    jianyiBtn.backgroundColor=[UIColor colorWithRed:0.44 green:0.77 blue:0.59 alpha:1];
    [jianyiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [img addSubview:jianyiBtn];
    
    if (nowType==3) {
        jianyiBtn.hidden=YES;
        tousuBtn.hidden=YES;
    }

}

- (void)setHeaderView1{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, lsize(60))];
    //    <##>.backgroundColor = <##>;
    [myTableView setTableHeaderView:headerView];;
    
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(lsize(15), lsize(15), ApplicationWidth-lsize(15)*2, lsize(30))];
    //    <##>.backgroundColor = <##>;
    [headerView addSubview:aview];
    [aview setBorderColor:myblue width:1];
    [aview setCornerRadius:3];
    
    [btnArr removeAllObjects];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*CGRectGetWidth(aview.frame)/4, 0, CGRectGetWidth(aview.frame)/4, lsize(30));
        if (i==nowType) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
            
        }
        NSArray *arr=@[@"河道基础",@"电子公告",@"河道水质",@"信息公开"];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        [btn setTitleColor:myblue forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:myblue forState:UIControlStateSelected];
        [aview addSubview:btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(aview.frame)/4-0.5, 0, 1, lsize(30))];
        line.backgroundColor = myblue;
        [aview addSubview:line];
        
        
        [btnArr addObject:btn];
    }
  
}


- (void)tousuBtnClick:(UIButton *)btn{
    
}

- (void)titleBtnClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    for (UIButton *abtn in btnArr) {
        if (abtn==btn) {
            
        }else{
            abtn.selected=NO;
        }
    }
    NSInteger index=btn.tag-100;
    nowType=index;
    [myTableView reloadData];

    if (nowType==0) {
        [self setHeaderView];
    }
    if (nowType==3) {
        [self setHeaderView];

    }
    if (nowType==2) {

        [self setHeaderView1];
        
    }else if(nowType==1){
        
        [self setHeaderView1];
    }
    
//    @[@"河道基础",@"电子公告",@"河道水质",@"信息公开"]
}

#pragma mark ========================================
#pragma mark ==UITableView
#pragma mark ========================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (nowType==0) {
        return 1;
    }
    if (nowType==3) {
        return 1;
    }
    if (nowType==2) {
        return 1;
    }
    if (nowType==1) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (nowType==0) {
        return xiajiArr.count+1 ;
    }
    if (nowType==2) {
        return 3;
    }
    
    if (nowType==1) {
        return 2;
    }
    
    if (nowType==3) {
        if (section==0) {
            return [[xinxiGongKaiDic objectForKey:@"order_list"]count];

        }else{
            return 1;
        }
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSMutableArray *aaa=[[NSMutableArray alloc]init];
    //    for (int i=0; i<dataSource1.count; i++) {
    //        [aaa addObject:[NSString stringWithFormat:@"cell%ld",indexPath.row]];
    //    }
    if (nowType==0) {
        if (indexPath.row==0) {
            static NSString *cellIdentifier01=@"cell1";
            HedaoTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
            if (!cell) {
                cell=[[HedaoTableViewCell1 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
                
            }
            NSDictionary *dic=[dataSource objectAtIndex:0];
            cell.bianhao.text=[NSString stringWithFormat:@"|河道编号:%@",[dic validStringForKey:@"rivers_num"]];
            NSString *string=@"";
            if ([[dic validStringForKey:@"r_level"] integerValue]==1) {
                string=@"省级";
            }
            if ([[dic validStringForKey:@"r_level"] integerValue]==1) {
                string=@"市级";
            }
            if ([[dic validStringForKey:@"r_level"] integerValue]==1) {
                string=@"县级";
            }
            if ([[dic validStringForKey:@"r_level"] integerValue]==1) {
                string=@"镇级";
            }
            if ([[dic validStringForKey:@"r_level"] integerValue]==1) {
                string=@"村级";
            }
            cell.dengji.text=[NSString stringWithFormat:@"|河道等级%@:",string];//级 1省级 2市级 3县级 4镇级 5村级
            cell.mingcheng.text=[NSString stringWithFormat:@"|河道名称:%@",[dic validStringForKey:@"name"]];
            cell.shuizhi.text=[NSString stringWithFormat:@"|河道水质:%@",[dic validStringForKey:@"wq_level"]];
            cell.qidian.text=[NSString stringWithFormat:@"|河道起点:%@",[dic validStringForKey:@"start_name"]];
            cell.changdu.text=[NSString stringWithFormat:@"|河道长度:%@",[dic validStringForKey:@"r_length"]];
            cell.zhongdian.text=[NSString stringWithFormat:@"|河道终点:%@",[dic validStringForKey:@"end_name"]];
            cell.quxiasn.text=[NSString stringWithFormat:@"|河道区县:%@",[dic validStringForKey:@""]];
            cell.xingming.text=[NSString stringWithFormat:@"姓名:%@",[dic validStringForKey:@"chief_name"]];
            cell.zhiwei.text=[NSString stringWithFormat:@"职位:%@",[dic validStringForKey:@"chief_name"]];
            cell.jignzhangname.text=[NSString stringWithFormat:@"姓名:%@",[dic validStringForKey:@"police_name"]];
            cell.fanwei.text=[NSString stringWithFormat:@"管辖范围:%@",[dic validStringForKey:@""]];
            cell.call1Btn.tag=[[dic validStringForKey:@"police_phone"] integerValue];
            cell.call2btn.tag=[[dic validStringForKey:@"police_phone"] integerValue];
            
            [cell.call1Btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
            [cell.call2btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
            return cell;
            
        }
        
        
        static NSString *cellIdentifier01=@"cell2";
        cell2 *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
        if (!cell) {
            cell=[[cell2 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
            
            
        }
        NSDictionary *dic=[xiajiArr objectAtIndex:indexPath.row-1];
        cell.xinxi.text=[NSString stringWithFormat:@"%@河长信息",[dic validStringForKey:@"areaName"]];
        cell.migniz.text=[dic validStringForKey:@"police_name"];
        cell.zhiwei.text=[dic objectForKey:@"chief"][@"post"];
        
        cell.callBtn.tag=[[dic objectForKey:@"chief"][@"police_phone"] integerValue];
        [cell.callBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
        return cell;

    }

    if (nowType==3) {
        static NSString *cellIdentifier01=@"cell3";
        xinxigognkaiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
        if (!cell) {
            cell=[[xinxigognkaiTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
            
            
        }
        NSDictionary *dic=[[xinxiGongKaiDic objectForKey:@"order_list"] objectAtIndex:indexPath.row];
        cell.img.backgroundColor=[UIColor lightGrayColor];
        
        cell.title.text=[dic validStringForKey:@"title"];
        cell.subtitle.text=[dic validStringForKey:@"content"];
        cell.bianhao.text=[NSString stringWithFormat:@"编号：%@",[dic validStringForKey:@"orders_num"]];
        cell.deal.text=[dic validStringForKey:@"state_name"];
        cell.shijian.text=[dic validStringForKey:@"create_date"];
//        NSDictionary *dic=[xiajiArr objectAtIndex:indexPath.row-1];
//        cell.xinxi.text=[NSString stringWithFormat:@"%@河长信息",[dic validStringForKey:@"areaName"]];
//        cell.migniz.text=[dic validStringForKey:@"police_name"];
//        cell.zhiwei.text=[dic objectForKey:@"chief"][@"post"];
//        
//        cell.callBtn.tag=[[dic objectForKey:@"chief"][@"police_phone"] integerValue];
//        [cell.callBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
        return cell;

    }

    int  a;
    if (nowType==2) {
        if (indexPath.row==0) {
            static NSString *cellIdentifier01=@"cell4";
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
                [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn1.backgroundColor=myblue;
                [cell.contentView addSubview:btn1];
                
                UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn1.frame)+7, ApplicationWidth, 10)];
                [img setImage:Limage(@"未标题-1.png")];
                [cell.contentView addSubview:img];

                
                
                [zhiBiaoArr removeAllObjects];
                NSArray *arr=@[@"Do",@"CODmn",@"NH3-N",@"TP"];
                CGFloat aW=ApplicationWidth-15-4*lsize(60);
                
                UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(aW, CGRectGetMaxY(img.frame)+15, 4*lsize(60), lsize(30))];
                [bView setBorderColor:myblue width:1];
                [cell.contentView addSubview:bView];
                
                for (int i=0; i<4; i++) {
                    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame=CGRectMake(aW+i*60, CGRectGetMaxY(img.frame)+15, lsize(60), lsize(30));
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
                lab2.tag=400;
                lab2.textColor = [UIColor grayColor];
                lab2.text= @"南塘路段侧监测点" ;
                [cell.contentView addSubview:lab2];
                
                
            }
            UILabel *lab=ltag(100);
            lab.text=[hedaoZiLiaoDic validStringForKey:@"name"];
            
            UILabel *lab1=ltag(200);
//            lab1.text=[hedaoZiLiaoDic validStringForKey:@""];
            lab1.text=@"";
            
            
            UIButton *btn1=ltag(300);
            
            UILabel *lab2=ltag(400);
            lab2.text=[NSString stringWithFormat:@"%@路段监测点",[hedaoZiLiaoDic validStringForKey:@"name"]];
            
            [btn1 setTitle:[NSString stringWithFormat:@"%@路段",[hedaoZiLiaoDic validStringForKey:@"name"]] forState:UIControlStateNormal];

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
            NSDictionary *dic=[[shuiZhiXinXiDic objectForKey:@"qui_list"] objectAtIndex:0];
            cell.lab1.text=[dic validStringForKey:@"water_data_O2"];
            cell.lab2.text=[dic validStringForKey:@"water_data_KMnO3"];
            cell.lab3.text=[dic validStringForKey:@"water_data_O2"];
            cell.lab4.text=[dic validStringForKey:@"water_data_P"];
            
//                    cell.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.5];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
            return cell;

        }
        if (indexPath.row==2) {
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
    
    if (nowType==1) {
        if (indexPath.row==0) {
            static NSString *cellIdentifier01=@"cell6";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
                mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, 300)];
                [self map];
                [cell.contentView addSubview:self.mapView];
            }
            cell.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
            return cell;
            

        }else{
            static NSString *cellIdentifier01=@"cell7";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
                UIWebView *webView=[[UIWebView alloc]init];
                [cell.contentView addSubview:webView];
                webView.frame=CGRectMake(0, 0, ApplicationWidth, 300);
                webView.tag=400;
            }
            UIWebView *webView=ltag(400);
    
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.88.18:8090/riversMobile/zhengce.action?rivers.id=%@",[[dataSource objectAtIndex:0] validStringForKey:@"id"]]]]];


            
            cell.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
            return cell;
            

        }
    }
    
    static NSString *cellIdentifier01=@"cell2";
    cell2 *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
    if (!cell) {
        cell=[[cell2 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier01];
        
        
    }
    NSDictionary *dic=[xiajiArr objectAtIndex:indexPath.row-1];
    cell.xinxi.text=[NSString stringWithFormat:@"%@河长信息",[dic validStringForKey:@"areaName"]];
    cell.migniz.text=[dic validStringForKey:@"police_name"];
    cell.zhiwei.text=[dic objectForKey:@"chief"][@"post"];
    
    cell.callBtn.tag=[[dic objectForKey:@"chief"][@"police_phone"] integerValue];
    [cell.callBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = myBackgroundColor;
    return cell;

    
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
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D pointToUse[2];
   NSArray *arr = [gongshidituDic validArrayForKey:@"river_map_list"];
    for (NSInteger i = 0; i < arr.count-2; i++) {
        NSDictionary *ddic=arr[i];
        NSString *lon = [ddic validStringForKey:@"bdx"];
        NSString *lat =[ddic validStringForKey:@"bdy"] ;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
        pointToUse[0] = coordinate;
        
        NSDictionary *ddic1=arr[i+1];
        NSString *lon2 = [ddic1 validStringForKey:@"bdx"];
        NSString *lat2 = [ddic1 validStringForKey:@"bdy"];
        CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake([lat2 doubleValue], [lon2 doubleValue]);
        pointToUse[1] = coordinate2;
        
        self.myPolyline = [MKPolyline polylineWithCoordinates:pointToUse count:2];
        [self.mapView addOverlay:self.myPolyline];
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
        showDataArr=arr1;
        
    }
    if (index==1) {
        showDataArr=arr2;
        
    }
    if (index==3) {
        showDataArr=arr3;
        
    }
    if (index==4) {
        showDataArr=arr4;
        
    }
    
    [myTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (nowType==2) {
        if (indexPath.row==0) {
            return lsize(160);

        }else if(indexPath.row==1){
            return lsize(110+15);
        }
        else if(indexPath.row==2){
            return 200;
        }
    }
    
    if (nowType==0) {
        if (indexPath.row==0) {
            return 300;
        }
        else{
            return 78;
        }

    }
    if (nowType==1) {
        if (indexPath.row==0) {
            return 300;
        }
        else{
            return 300;
        }
    }
    
    if(nowType==3){
        return 126;
    }else{
        return 100;
    }
}

-  (void)call:(UIButton *)btn{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",LString(btn.tag)];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

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
//            NSString *code = [requestResult stringValueForKey:@"result"];
//            NSString *data = [requestResult objectForKey:@"data"];
//            NSString *msg = [requestResult objectForKey:@"msg"];
//            if ([code isEqualToString:@"1"]) {
//
//            
//            
//            
//            }else{
//                
//            }
            
            [dataSource removeAllObjects] ;
            [dataSource addObjectsFromArray:[requestResult objectForKey:@"rivers_list"]];
            
            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
            
            lObserveNet(cmdjReachesTree);
            
            [lSender jReachesTreeriversid:[[dataSource objectAtIndex:0] validStringForKey:@"id"]];


            
        }else{
        KKShowNoticeMessage(@"网络错误，请检查网络");
        
    }
    
        }
    
    
    
    if ([requestIdentifier isEqualToString: cmdjReachesTree]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            
            [xiajiArr removeAllObjects];
            [xiajiArr addObjectsFromArray:[requestResult objectForKey:@"rivers_list"]];

            
            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
            
            lObserveNet(cmdjOrderListByRivers);
            
            [lSender jOrderListByRivers:[[dataSource objectAtIndex:0] validStringForKey:@"id"]];


        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
        }
        
    }
    
    if ([requestIdentifier isEqualToString: cmdjOrderListByRivers]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            
            xinxiGongKaiDic=[[NSMutableDictionary alloc]initWithDictionary:requestResult];
            
            
//            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
//            
//            lObserveNet(cmdjLogListByRivers);
//            
//            [lSender jLogListByRivers:[[dataSource objectAtIndex:0] validStringForKey:@"id"]];
//            

            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
            
            lObserveNet(cmdjWaQualityListById);
            
            [lSender jWaQualityListById:[[dataSource objectAtIndex:0] validStringForKey:@"id"]];
            

            
        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
        }
        
    }

    if ([requestIdentifier isEqualToString: cmdjLogListByRivers]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            xunHeJiLuDic=[[NSMutableDictionary alloc]initWithDictionary:requestResult];

            
            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
            
            lObserveNet(cmdjWaQualityListById);
            
            [lSender jWaQualityListById:[[dataSource objectAtIndex:0] validStringForKey:@"id"]];
            

            
            
            
            
            
        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
        }
        
    }
    if ([requestIdentifier isEqualToString: cmdjWaQualityListById]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            shuiZhiXinXiDic=[[NSMutableDictionary alloc]initWithDictionary:requestResult];
            
            
            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
            
            lObserveNet(cmdriverMapListById);
            
            [lSender riverMapListById:[[dataSource objectAtIndex:0] validStringForKey:@"id"]];

            

            
            
            
        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
        }
        
    }
    if ([requestIdentifier isEqualToString: cmdriverMapListById]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            gongshidituDic=[[NSMutableDictionary alloc]initWithDictionary:requestResult];
            
       
            
            
            NSMutableArray *array =[[NSMutableArray alloc]initWithArray:[shuiZhiXinXiDic validArrayForKey:@"qui_list"]]; ;
            
            dateArr=[[NSMutableArray alloc]init];
            arr1=[[NSMutableArray alloc]init];
            arr2=[[NSMutableArray alloc]init];
            arr3=[[NSMutableArray alloc]init];
            arr4=[[NSMutableArray alloc]init];
            for (int i=0;i<array.count; i++) {
                NSDictionary *dic=[array objectAtIndex:i];
                [arr1 addObject:[dic validStringForKey:@"water_data_O2"]];
                [arr2 addObject:[dic validStringForKey:@"water_data_KMnO3"]];
                [arr3 addObject:[dic validStringForKey:@"water_data_NCl"]];
                [arr4 addObject:[dic validStringForKey:@"water_data_P"]];
                
                [dateArr addObject:[NSDate getStringFromOldDateString:[dic validStringForKey:@"update_date"] withOldFormatter:KKDateFormatter04 newFormatter:KKDateFormatter06]];
                
                if ([[shuiZhiXinXiDic validArrayForKey:@"area_list"] isNotEmptyArray]) {
                    hedaoZiLiaoDic=[[NSMutableDictionary alloc]initWithDictionary:[[shuiZhiXinXiDic validArrayForKey:@"area_list"] objectAtIndex:0]];
                    
                }
            }
            showDataArr=arr1;
            
            [self initUI];
            [myTableView reloadData];
            [self setHeaderView];

        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
        }
        
    }
    if ([requestIdentifier isEqualToString: cmdzhengce]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            yiheyiceDic=[[NSMutableDictionary alloc]initWithDictionary:requestResult];
            
            

            
            
            
        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
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
