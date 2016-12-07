//
//  ZhanDianJianCeViewController.h
//  MyBear
//
//  Created by 林立祥 on 2016/12/3.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "BaseViewController.h"

@interface ZhanDianJianCeViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *dataSource;
@property(nonatomic,retain)NSMutableDictionary *information;
@property(nonatomic,retain)NSString  *name;
@property(nonatomic,retain)NSString *siteNum;
@property(nonatomic,retain)NSString *ID;
@property(nonatomic,retain)NSString *heliuName;

@end
