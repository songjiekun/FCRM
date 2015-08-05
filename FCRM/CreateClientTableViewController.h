//
//  CreateClientTableViewController.h
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CreateClientTableViewController : UITableViewController<UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientIncomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientRiskTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientTelTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientAgeTextField;

//core data相关
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/*!
 *@discussion 获取图片
 */
- (IBAction)takePhoto:(id)sender;
/*!
 *@discussion 向服务器发送新client
 */
- (IBAction)submit:(id)sender;

@end
