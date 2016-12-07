//
//  YiJianFanKuiViewController.m
//  MyBear
//
//  Created by 紫平方 on 16/11/27.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "YiJianFanKuiViewController.h"
#import "KKTextView.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface YiJianFanKuiViewController ()

@end

@implementation YiJianFanKuiViewController{
    NSMutableArray *tempPathArr;
    NSInteger nowIndex;
    UIView *bgview;
    NSMutableArray *btnArr;
    KKTextView *tf;
    UIButton *addBtn;
    TPKeyboardAvoidingScrollView *myScrollView;
    UIButton *subbtn;
}
@synthesize tempUpArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"在线投诉";
    nowIndex=0;
    tempUpArr=[[NSMutableArray alloc]init];
    tempPathArr=[[NSMutableArray alloc]init];
    btnArr=[[NSMutableArray alloc]init];
    [_contentTf setBorderColor:[UIColor blackColor] width:1];
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    myScrollView=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, ApplicationWidth, ApplicationHeight)];
//    myScrollView.contentSize=CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    [self.view addSubview:myScrollView];

    
    tf=[[KKTextView alloc]initWithFrame:CGRectMake(12, 12, ApplicationWidth-24, 334/2)];
    tf.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    tf.placeholder=@"说说您的意见吧~";
    [myScrollView addSubview:tf];
    
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tf.frame)+10, ApplicationWidth, 125)];
    bgview.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:bgview];
    
    addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame=CGRectMake(11, 15, 81, 81);
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addBtn.backgroundColor=myThemeColor;
    addBtn.titleLabel.font=Lfont(20);
    [bgview addSubview:addBtn];
    [btnArr addObject:addBtn];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.font = Lfont(12);
    lab.textColor = [UIColor blackColor];
    lab.text= @"最多上传9张图片" ;
    [bgview addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset=11;
    make.bottom.offset=-9;
}];
    myScrollView.contentSize=CGSizeMake(ApplicationWidth, CGRectGetMaxY(bgview.frame)+17+40+30);
    
    subbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    subbtn.frame=CGRectMake(12, CGRectGetMaxY(bgview.frame)+17, ApplicationWidth-24, 40);
    [subbtn setTitle:@"提交" forState:UIControlStateNormal];
    [subbtn addTarget:self action:@selector(subbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [subbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    subbtn.backgroundColor=myThemeColor;
    [subbtn setCornerRadius:20];
    [myScrollView addSubview:subbtn];

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

- (void)addImgBtnClick{
    if (tempUpArr.count==9) {
        KKShowNoticeMessage(@"最多上传9张");
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"拍照"
                                  otherButtonTitles:@"相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag=3000;
    [actionSheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        if (buttonIndex == 0) {
            UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.allowsEditing = YES;
            imagePickerController.delegate = self;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else if (buttonIndex == 1) {
            NSLog(@"1");
            KKAlbumPickerController * viewController = [[KKAlbumPickerController alloc]
                                                        initWithDelegate:self
                                                        numberNeedSelected:9-tempUpArr.count
                                                        editEnable:YES
                                                        cropSize:CGSizeMake(200, 200)
                                                        pushToDefaultDirectory:YES];
            
            [self presentViewController:viewController animated:YES completion:^{
            }];
        }
    
}

- (void)reloadImgView{
    
    
    for (UIImageView *img  in [self.view subviews]) {
        if (img.tag==10000) {
            [img  removeFromSuperview];
        }
    }
    for (int i=0; i<tempUpArr.count+1; i++) {
        if (i==tempUpArr.count) {
            addBtn.frame=CGRectMake(11+(81+5)*(i%3), 15+(15+81)*(i/3), 81, 81);
        }else{
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(11+(81+5)*(i%3), 15+(15+81)*(i/3), 81, 81)];
            img.tag=10000;
            [img setImage:[[UIImage alloc]initWithContentsOfFile:tempUpArr[i]]];
            [bgview addSubview:img];

        }
        bgview.frame = CGRectMake(0, CGRectGetMaxY(tf.frame)+10, ApplicationWidth, 125+(i/3)*(15+81));
        myScrollView.contentSize=CGSizeMake(ApplicationWidth, CGRectGetMaxY(bgview.frame)+17+40+30);

    }
    subbtn.frame=CGRectMake(12, CGRectGetMaxY(bgview.frame)+17, ApplicationWidth-24, 40);

    
}

#pragma mark ==================================================
#pragma mark == KKAlbumPickerControllerDelegate【图片】
#pragma mark ==================================================
- (void)KKAlbumPickerController_DidFinishedPickImage:(NSArray*)aImageArray imageInformation:(NSArray*)aImageInformationAray
{
    if ([aImageArray count]>0) {
        [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] windows] objectAtIndex:0] animated:YES];
        
        [NSData convertImage:aImageArray toDataSize:200 convertImageOneCompleted:^(NSData *imageData, NSInteger index) {
            
            
            
            NSString *path = [NSString stringWithFormat:@"%@/Documents/PublishFinanceImage_header%ld.jpg", NSHomeDirectory(),(long)tempUpArr.count];
//            tempImgPath=path;
            BOOL result = [imageData writeToFile:path atomically:YES];
            if (result) {
                
                [tempUpArr addObject:path];
                
                [self reloadImgView];

                
            }
        } KKImageConvertImageAllCompletedBlock:^{
            [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] windows] objectAtIndex:0] animated:YES];
        }];
    }
}


#pragma mark ========================================
#pragma mark ==UIImagePickerController
#pragma mark ========================================
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSArray *arr=[NSArray arrayWithObjects:image, nil];
    [NSData convertImage:arr toDataSize:200 convertImageOneCompleted:^(NSData *imageData, NSInteger index) {
        NSString *path = [NSString stringWithFormat:@"%@/Documents/PublishFinanceImage_header%ld.jpg", NSHomeDirectory(),(long)tempUpArr.count];
//        tempImgPath=path;
        
        BOOL result = [imageData writeToFile:path atomically:YES];
        if (result) {
            
            [tempUpArr addObject:path];
            [self reloadImgView];
//            [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
//            lObserveNet(cmdUploadImg);
//            [lSender postImg:path];
            //            [information setObject:path forKey:touxiang];
            //            [myTableView reloadData];
        }
        
    } KKImageConvertImageAllCompletedBlock:^{
        [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] windows] objectAtIndex:0] animated:YES];
    }];
}

#pragma mark ==================================================
#pragma mark == 【网络】与【数据处理】
#pragma mark ==================================================
- (void)KKRequestRequestFinished:(NSDictionary *)requestResult
                  httpInfomation:(NSDictionary *)httpInfomation
               requestIdentifier:(NSString *)requestIdentifier
{
    [MBProgressHUD hideAllHUDsForView:Window0 animated:YES];
 
    if ([requestIdentifier isEqualToString: cmdUploadImg]) {
        [self unobserveKKRequestNotificaiton:requestIdentifier];
        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
            NSString *code = [requestResult stringValueForKey:@"result"];
            NSString *data = [requestResult objectForKey:@"data"];
            NSString *msg = [requestResult objectForKey:@"msg"];
            if ([code isEqualToString:@"1"]) {
                [tempPathArr addObject:data];
                nowIndex=nowIndex+1;
                if (nowIndex<tempUpArr.count) {
                    NSLog(@"%ld",nowIndex);

                    [self upImg];
                }else{
//                    [MBProgressHUD showHUDAddedTo:Window0 animated:YES];
//                    
//                    lObserveNet(cmdfeedBack);
//                    
//                    NSString *tempStringa=@"";
//                    
//                    for (int i=0; i<tempPathArr.count; i++) {
//                        if (i==0) {
//                            tempStringa=[tempPathArr objectAtIndex:i];
//                            
//                        }else{
//                            tempStringa=[tempStringa stringByAppendingString:[NSString stringWithFormat:@",%@",[tempPathArr objectAtIndex:i]]];
//                        }
                    }
                    
//                    [lSender feedBackWithfeed_content:tf.text feed_pictures:tempStringa];
                

                }
                
                
                
//                [information setObject:data forKey:touxiang];
//                [myTableView reloadData];
                
                //                [self.navigationController popViewControllerAnimated:YES];
            }
//            KKShowNoticeMessage(msg);
        }else{
            KKShowNoticeMessage(@"网络错误，请检查网络");
            
        }
    
//    if ([requestIdentifier isEqualToString: cmdfeedBack]) {
//        [self unobserveKKRequestNotificaiton:requestIdentifier];
//        if (requestResult && [requestResult isKindOfClass:[NSDictionary class]]) {
//            NSString *code = [requestResult stringValueForKey:@"status"];
//            NSString *data = [requestResult objectForKey:@"data"];
//            NSString *msg = [requestResult objectForKey:@"msg"];
//            if ([code isEqualToString:@"1"]) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            KKShowNoticeMessage(msg);
//        }else{
//            KKShowNoticeMessage(@"网络错误，请检查网络");
//            
//        }
//    }

}

- (void)upImg{
    NSString *path=[tempUpArr objectAtIndex:nowIndex];

    [MBProgressHUD showNoticeMessage:[NSString stringWithFormat:@"正在上传第%ld张图片",(long)nowIndex+1]];
    lObserveNet(cmdUploadImg);
    [lSender UploadImg:path];

}

- (void)subbtnClick{
    if ([[tf.text trimLeftAndRightSpace]isEqualToString:@""]) {
        KKShowNoticeMessage(@"请填写反馈内容");
        return;
    }
    
    [self upImg];
}
@end
