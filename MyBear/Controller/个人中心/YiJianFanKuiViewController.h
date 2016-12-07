//
//  YiJianFanKuiViewController.h
//  MyBear
//
//  Created by 紫平方 on 16/11/27.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "BaseViewController.h"
#import "KKAlbumPickerController.h"
@interface YiJianFanKuiViewController : BaseViewController<UIActionSheetDelegate,KKAlbumPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic)  UITextView *contentTf;
@property (weak, nonatomic)  UIButton *addImgBtn;
@property (weak, nonatomic)  UIButton *submitBtn;


@property (nonatomic, retain) NSMutableArray *tempUpArr;;

@end
