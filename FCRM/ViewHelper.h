//
//  ViewHelper.h
//  FCRM
//
//  Created by song jiekun on 15/8/2.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductT.h"
#import "ProductTableViewCell.h"
#import "ClientMore.h"
#import "ClientTableViewCell.h"
#import "ClientPickerViewController.h"
#import "TaskTableViewCell.h"
#import "TaskMore.h"

@interface ViewHelper : NSObject

+(void)popoutLoginWithController:(UIViewController*)vc;

/*!
 *@discussion 填充product tableviewcell
 */
+(void)configureProductCell:(ProductTableViewCell *)cell product:(ProductT *)product;

/*!
 *@discussion 填充task tableviewcell
 */
+(void)configureTaskCell:(TaskTableViewCell *)cell task:(TaskMore *)task;

/*!
 *@discussion 填充client tableviewcell
 */
+(void)configureClientCell:(ClientTableViewCell *)cell client:(ClientMore *)client fromCache:(NSCache *)cache atIOQueue:(NSOperationQueue *)ioQueue atInternetQueue:(NSOperationQueue *)internetQueue controller:(UIViewController *)controller;

/*!
 *@discussion 弹出图片选取界面
 */
+(void)popoutImageLibraryController:(UIViewController*)vc;

/*!
 *@discussion 弹出照相界面
 */
+(void)popoutCameraController:(UIViewController*)vc;

/*!
 *@discussion 弹出用户选择列表
 */
+(ClientPickerViewController*)popoutClientPickerControllerToSelect:(UIViewController *)vc;

/*!
 *@discussion 任务完成后回退
 */
+(void)completeTask:(UIViewController*)vc;

@end
