//
//  DuanMianShuiZhiViewController.h
//  MyBear
//
//  Created by 林立祥 on 2016/12/3.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "BaseViewController.h"

@interface DuanMianShuiZhiViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *dataSource;
@property(nonatomic,retain)NSMutableArray *information;

@end
