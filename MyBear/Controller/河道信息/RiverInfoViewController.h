//
//  RiverInfoViewController.h
//  MyBear
//
//  Created by Bears on 16/11/21.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "BaseViewController.h"

@interface RiverInfoViewController : BaseViewController
<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate>
@property(nonatomic,retain)NSString *riverID;
@end
