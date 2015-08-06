//
//  ViewHelper.m
//  FCRM
//
//  Created by song jiekun on 15/8/2.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ViewHelper.h"



@implementation ViewHelper

+(void)popoutLoginWithController:(UIViewController *)vc{
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"UserLogin" bundle:nil];
    
    UINavigationController *loginNavigationController=[storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    
    
    [vc presentViewController:loginNavigationController animated:YES completion:nil];
    
}

+(ClientListViewController*)popoutClientListControllerToSelect:(UIViewController *)vc{
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ClientList" bundle:nil];
    
    ClientListViewController *clientListViewController=[storyboard instantiateViewControllerWithIdentifier:@"ClientListViewController"];
    
    [vc.navigationController pushViewController:clientListViewController animated:YES];
    
    return clientListViewController;
    
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

@end
