//
//  HeDaoSouSuoViewController.h
//  MyBear
//
//  Created by 林立祥 on 2016/12/5.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "BaseViewController.h"
#import "KKRefreshFooterAutoView.h"
#import "KKDataPickerView.h"
@interface HeDaoSouSuoViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,KKRefreshFooterAutoViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,KKDataPickerViewDelegate>
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *dataSource;
@property(nonatomic,retain)NSMutableDictionary *information;
@end
