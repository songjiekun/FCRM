//
//  ClientPickerViewController.h
//  FCRM
//
//  Created by song jiekun on 15/8/8.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XLFormRowDescriptor.h>
#import "ClientListViewController.h"

@interface ClientPickerViewController :  ClientListViewController<UIAlertViewDelegate,XLFormRowDescriptorViewController>

@property (weak,nonatomic) IBOutlet NSLayoutConstraint *searchBarLayoutConstraint;

/*!
 *@discussion 设置是否为“XLForm模式”
 */
@property (nonatomic) BOOL isXLForm;

/*!
 *@discussion product数据
 */
@property (nonatomic, strong) ProductT* product;
/*!
 *@discussion 选中的client数据，用来在alertview中使用
 */
@property (nonatomic, strong) ClientMore* selectedClient;

/*!
 *@discussion XLFormRowDescriptorViewController 协议 存储选择数据
 */
@property (nonatomic) XLFormRowDescriptor *rowDescriptor;

@end

