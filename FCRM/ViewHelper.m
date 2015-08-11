//
//  ViewHelper.m
//  FCRM
//
//  Created by song jiekun on 15/8/2.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ViewHelper.h"
#import "MBProgressHUD.h"
#import "ControlVariables.h"


@implementation ViewHelper

+(void)popoutLoginWithController:(UIViewController *)vc{
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"UserLogin" bundle:nil];
    
    UINavigationController *loginNavigationController=[storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    
    
    [vc presentViewController:loginNavigationController animated:YES completion:nil];
    
}

+(ClientPickerViewController*)popoutClientPickerControllerToSelect:(UIViewController *)vc{
    
    ClientPickerViewController *clientPickerViewController=[[ClientPickerViewController alloc] initWithNibName:@"ClientPickerViewController" bundle:nil];
    
    [vc.navigationController pushViewController:clientPickerViewController animated:YES];
    
    return clientPickerViewController;
    
}

+(void)configureProductCell:(ProductTableViewCell *)cell product:(ProductT *)product {
    
    //更新Cell
    cell.categoryLabel.text=[NSString stringWithFormat:@"类型:%@",product.productCategory];
    cell.yieldRateLabel.text=[NSString stringWithFormat:@"%@%%",product.productYieldRate];
    cell.productNameLabel.text=product.productName;
    cell.periodLabel.text=[NSString stringWithFormat:@"认购期限:%@",product.productPeriod];
    cell.minAmount.text=[NSString stringWithFormat:@"起购额:%@万",product.productMinAmount];
    cell.investorRateLabel.text=[NSString stringWithFormat:@"用户评分:%@分",product.userScore];
    
    //不同level的product不同的背景图
    switch ([product.productLevel integerValue]) {
        case 1:
            cell.levelImageView.image=[UIImage imageNamed:@"high"];
            break;
            
        case 2:
            cell.levelImageView.image=[UIImage imageNamed:@"middle"];
            break;
            
        case 3:
            cell.levelImageView.image=[UIImage imageNamed:@"low"];
            break;
            
        default:
            cell.levelImageView.image=[UIImage imageNamed:@"high"];
            break;
    }
    
}

+(void)configureTaskCell:(TaskTableViewCell *)cell task:(TaskMore *)task{
    
    //日期转换为string
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *taskExpiryDate=[formatter stringFromDate:task.taskExpiryDate];
    
    //更新Cell
    cell.taskNameLabel.text=task.taskName;
    cell.taskExpiryDateLabel.text=[NSString stringWithFormat:@"截止日期:%@",taskExpiryDate];
    cell.clientNameLabel.text=[NSString stringWithFormat:@"客户姓名:%@",task.clientName];
    
    //不同level的task不同的提示颜色
    switch ([task.taskLevel integerValue]) {
        case 1:
            cell.taskLevelImageView.image=[UIImage imageNamed:@"low"];
            cell.taskLevelImageView.backgroundColor=kLowColor;
            break;
            
        case 2:
            cell.taskLevelImageView.image=[UIImage imageNamed:@"high"];
            cell.taskLevelImageView.backgroundColor=kHighColor;
            break;
            
        default:
            cell.taskLevelImageView.image=[UIImage imageNamed:@"high"];
            cell.taskLevelImageView.backgroundColor=kHighColor;
            break;
    }
    
}


+(void)configureClientCell:(ClientTableViewCell *)cell  client:(ClientMore *)client fromCache:(NSCache *)cache atIOQueue:(NSOperationQueue *)ioQueue atInternetQueue:(NSOperationQueue *)internetQueue controller:(UIViewController *)controller{
    
    //更新Cell
    cell.incomeLabel.text=[NSString stringWithFormat:@"收入:%@万",client.clientIncome];
    cell.clientNameLabel.text=client.clientName;
    cell.telLabel.text=[NSString stringWithFormat:@"联系电话:%@",client.clientTel];
    cell.ageLabel.text=[NSString stringWithFormat:@"年龄:%@",client.clientAge];
    //异步获取用户头像图片
    cell.clientProfileImageView.image=[client.clientProfileInternetImage retrieveImage:cell.clientProfileImageView fromCache:cache atIOQueue:ioQueue atInternetQueue:internetQueue];
    
    client.clientProfileInternetImage.delegate=controller;
    
    //不同level的product不同的背景图
    switch ([client.clientRisk integerValue]) {
        case 1:
            cell.clientProfileImageView.layer.borderColor=[UIColor redColor].CGColor;
            cell.riskLabel.text=@"风险偏好:高度风险";
            break;
            
        case 2:
            cell.clientProfileImageView.layer.borderColor=[UIColor yellowColor].CGColor;
            cell.riskLabel.text=@"风险偏好:中度风险";
            break;
            
        case 3:
            cell.clientProfileImageView.layer.borderColor=[UIColor greenColor].CGColor;
            cell.riskLabel.text=@"风险偏好:低度风险";
            break;
            
        default:
            cell.clientProfileImageView.layer.borderColor=[UIColor redColor].CGColor;
            cell.riskLabel.text=@"风险偏好:高度风险";
            break;
    }
    
}

+(void)popoutImageLibraryController:(UIViewController*)vc{
    
    //确定可以访问照片集
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO)
        return;
    
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    //imagePickerController.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    imagePickerController.allowsEditing=YES;
    imagePickerController.delegate=vc;
    [vc presentViewController:imagePickerController animated:YES completion:nil];
    
}

+(void)popoutCameraController:(UIViewController*)vc{
    
    //确定可以相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        return;
    
    UIImagePickerController *cameraController=[[UIImagePickerController alloc] init];
    
    cameraController.sourceType=UIImagePickerControllerSourceTypeCamera;
    //imagePickerController.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    cameraController.allowsEditing=YES;
    cameraController.delegate=vc;
    [vc presentViewController:cameraController animated:YES completion:nil];
    
}

+(void)completeLoading:(UIViewController*)vc withText:(NSString*)text{
    
    //隐藏之前的hud
    [MBProgressHUD hideAllHUDsForView:vc.view animated:NO];
    
    //显示成功信息
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.mode=MBProgressHUDModeCustomView;
    hud.labelText=text;
    hud.customView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark"]];
    [hud hide:YES afterDelay:1];
    //消失后 回退
    hud.completionBlock=^{
        
        if (vc.navigationController) {
            
            [vc.navigationController popViewControllerAnimated:YES];
        }
        
        
    };
    
    
}

@end
