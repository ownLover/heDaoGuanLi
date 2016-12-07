//
//  Net.h
//  MyBear
//
//  Created by Bears on 16/10/10.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "NetWorkSender.h"
@interface Net : NetWorkSender
+ (Net*)defaultSender;



#define URL_RegistGetToken @"get"
#define CMD_RegistGetToken @"CMD_RegistGetToken"
#pragma mark - 获取token
- (void)getToken;

#define URLsend  @"send"
#define CMDsend  @"CMDsend"
#pragma mark - 获取token
- (void)post:(NSString *)string;

#define URLUploadImg  @"riversApp/uploadFile.action"
#define cmdUploadImg  @"cmdUploadImg"
#pragma mark - 获取token
- (void)UploadImg:(NSString *)path;

#define URLappRiversList  @"riversApp/appRiversList.action"
#define cmdappRiversList  @"cmdappRiversList"
#pragma mark - 河道信息
- (void)appRiversListriversid:(NSString *)riversid chiefid:(NSString *)chiefid;


#define URLjReachesTree  @"riversApp/jReachesTree.action"
#define cmdjReachesTree  @"cmdjReachesTree"
#pragma mark - 河道信息
- (void)jReachesTreeriversid:(NSString *)riversid;

#define URLjOrderListByRivers  @"orderApp/jOrderListByRivers.action"
#define cmdjOrderListByRivers  @"cmdjOrderListByRivers"
#pragma mark - 河道信息
- (void)jOrderListByRivers:(NSString *)riversid;

#define URLjLogListByRivers  @"chiefApp/jLogListByRivers.action"
#define cmdjLogListByRivers  @"cmdjLogListByRivers"
#pragma mark - 河道信息
- (void)jLogListByRivers:(NSString *)riversid;


#define URLjWaQualityListById  @"riversApp/jWaQualityListById.action"
#define cmdjWaQualityListById  @"cmdjWaQualityListById"
#pragma mark - 河道信息
- (void)jWaQualityListById:(NSString *)riversid;



#define URLriverMapListById  @"riversApp/riverMapListById.action"
#define cmdriverMapListById  @"cmdriverMapListById"
#pragma mark - 电子公示i
- (void)riverMapListById:(NSString *)riversid;

#define URLzhengce  @"mobile/rivers/zhengce.vm"
#define cmdzhengce  @"cmdzhengce"
#pragma mark - 电子公示i 一盒一侧
- (void)zhengce:(NSString *)riversid;

#define URLjSiteList  @"riversApp/jSiteList.action"
#define cmdjSiteList  @"cmdjSiteList"
#define cmdjSiteListget  @"cmdjSiteListget"
#pragma mark - 站位点
- (void)jSiteList;
- (void)jSiteListpagecurrentpage:(NSString *)pagecurrentpage  sitename:(NSString *)sitename;


- (void)jSiteListpagecurrentpage:(NSString *)pagecurrentpage  sitename:(NSString *)sitename siteNum:(NSString *)siteNum;


#define URLtopRiversList  @"riversApp/topRiversList.action"
#define cmdtopRiversList  @"cmdtopRiversList"
#pragma mark - 河道
- (void)topRiversList;

#define URLjSQualityListById  @"riversApp/jSQualityListById.action"
#define cmdjSQualityListById  @"cmdjSQualityListById"
#pragma mark - 河道
- (void)jSQualityListById:(NSString *)siteid;

#define URLappRiversList  @"riversApp/appRiversList.action"
#define cmdappRiversList  @"cmdappRiversList"
#define cmdappRiversListmore  @"cmdappRiversListmore"
#pragma mark - 河道所有
- (void)appRiversListall;
- (void)appRiversListallWithPage:(NSString *)pagecurrentPage;


#define urlareaListById  @"riversApp/areaListById.action"
#define cmdareaListById  @"cmdareaListById"
#pragma mark - 河道区县
- (void)areaListById:(NSString *)areaid;


#define  urlchaheliu @"riversApp/appRiversList.action"
#define  cmdchaheliu @"cmdchaheliu"
- (void)chaheliu:(NSString *)riversarea_id;

#define  urlsousou @"riversApp/appRiversList.action"
#define  cmdsousou @"cmdsousou"
- (void)sousou:(NSString *)riversname;



@end
