//
//  ZNet.m
//  MyBear
//
//  Created by Bears on 16/11/21.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "ZNet.h"

@implementation ZNet
+ (ZNet *)defaultSender{
    static ZNet *NetWorkSender_Report_defaultSender = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NetWorkSender_Report_defaultSender = [[self alloc] init];
    });
    return NetWorkSender_Report_defaultSender;
}


@end
