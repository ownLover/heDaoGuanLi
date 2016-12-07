//
//  Net.m
//  MyBear
//
//  Created by Bears on 16/10/10.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "Net.h"

@implementation Net
+ (Net *)defaultSender{
    static Net *NetWorkSender_Report_defaultSender = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NetWorkSender_Report_defaultSender = [[self alloc] init];
    });
    return NetWorkSender_Report_defaultSender;
}

#pragma mark - 获取
- (void)getToken{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URL_RegistGetToken];
    parm.method = HTTPMethod_GET;
    [self sendRequestWithParam:parm requestIndentifier:CMD_RegistGetToken];
    
}

#pragma mark - 发送
- (void)post:(NSString *)string{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLsend];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"data" withValue:string];
    [self sendRequestWithParam:parm requestIndentifier:CMDsend];
    
}

#pragma mark - 获取token
- (void)UploadImg:(NSString *)path{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLUploadImg];
    parm.method = HTTPMethod_POST;
    [parm addFile:path forKey:@"image"];
    [self sendRequestWithParam:parm requestIndentifier:cmdUploadImg];

}

#pragma mark - 河道信息
- (void)appRiversListriversid:(NSString *)riversid chiefid:(NSString *)chiefid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLappRiversList];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.id" withValue:riversid];
    [parm addParam:@"chief.id" withValue:chiefid];
    [self sendRequestWithParam:parm requestIndentifier:cmdappRiversList];

}

#pragma mark - 河道信息
- (void)jReachesTreeriversid:(NSString *)riversid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjReachesTree];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.id" withValue:riversid];
    [self sendRequestWithParam:parm requestIndentifier:cmdjReachesTree];
    

}


- (void)jOrderListByRivers:(NSString *)riversid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjOrderListByRivers];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"order.river_id" withValue:riversid];
    [self sendRequestWithParam:parm requestIndentifier:cmdjOrderListByRivers];
    

}

#define cmdjLogListByRivers  @"cmdjLogListByRivers"
#pragma mark - 河道信息
- (void)jLogListByRivers:(NSString *)riversid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjLogListByRivers];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"order.river_id" withValue:riversid];
    [self sendRequestWithParam:parm requestIndentifier:cmdjLogListByRivers];

}

- (void)jWaQualityListById:(NSString *)riversid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjWaQualityListById];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.id" withValue:riversid];
    [self sendRequestWithParam:parm requestIndentifier:cmdjWaQualityListById];

}

#pragma mark - 电子公示i
- (void)riverMapListById:(NSString *)riversid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLriverMapListById];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.id" withValue:riversid];
    [self sendRequestWithParam:parm requestIndentifier:cmdriverMapListById];

}

#pragma mark - 电子公示i 一盒一侧
- (void)zhengce:(NSString *)riversid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLzhengce];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.id" withValue:riversid];
    [self sendRequestWithParam:parm requestIndentifier:cmdzhengce];
}

#pragma mark - 河道
- (void)topRiversList{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLtopRiversList];
    parm.method = HTTPMethod_POST;
    [self sendRequestWithParam:parm requestIndentifier:cmdtopRiversList];

}

- (void)jSiteList{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjSiteList];
    parm.method = HTTPMethod_POST;
    [self sendRequestWithParam:parm requestIndentifier:cmdjSiteList];

}
- (void)jSiteListpagecurrentpage:(NSString *)pagecurrentpage  sitename:(NSString *)sitename{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjSiteList];
    parm.method = HTTPMethod_GET;
    [parm addParam:@"pagecurrentpage" withValue:pagecurrentpage];
    [parm addParam:@"sitename" withValue:sitename];

    [self sendRequestWithParam:parm requestIndentifier:cmdjSiteListget];

}

- (void)jSiteListpagecurrentpage:(NSString *)pagecurrentpage  sitename:(NSString *)sitename siteNum:(NSString *)siteNum{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjSiteList];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"pagecurrentpage" withValue:pagecurrentpage];
    [parm addParam:@"name" withValue:sitename];
    [parm addParam:@"siteNum" withValue:siteNum];
    
    [self sendRequestWithParam:parm requestIndentifier:cmdjSiteListget];

}


#pragma mark - 河道
- (void)jSQualityListById:(NSString *)siteid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLjSQualityListById];
    parm.method = HTTPMethod_GET;
    [parm addParam:@"site.id" withValue:siteid];
    [self sendRequestWithParam:parm requestIndentifier:cmdjSQualityListById];

}


#pragma mark - 河道所有
- (void)appRiversListall{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLappRiversList];
    parm.method = HTTPMethod_GET;
    [self sendRequestWithParam:parm requestIndentifier:cmdappRiversList];

}

- (void)appRiversListallWithPage:(NSString *)pagecurrentPage{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:URLappRiversList];
    parm.method = HTTPMethod_GET;
    [parm addParam:@"page.currentPage" withValue:pagecurrentPage];

    [self sendRequestWithParam:parm requestIndentifier:cmdappRiversListmore];
    

}

#pragma mark - 河道区县
- (void)areaListById:(NSString *)areaid{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:urlareaListById];
    parm.method = HTTPMethod_GET;
    [parm addParam:@"area.id" withValue:areaid];
    
    [self sendRequestWithParam:parm requestIndentifier:cmdareaListById];

}

- (void)chaheliu:(NSString *)riversarea_id{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:urlchaheliu];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.area_id=" withValue:riversarea_id];
    
    [self sendRequestWithParam:parm requestIndentifier:cmdchaheliu];

}

- (void)sousou:(NSString *)riversname{
    BaseRequestParam *parm = [[BaseRequestParam alloc] init];
    parm.urlString = [self requestURLForInterface:urlsousou];
    parm.method = HTTPMethod_POST;
    [parm addParam:@"rivers.name=" withValue:riversname];
    
    [self sendRequestWithParam:parm requestIndentifier:cmdsousou];

}

@end
