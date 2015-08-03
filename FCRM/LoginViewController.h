//
//  LoginViewController.h
//  FCRM
//
//  Created by song jiekun on 15/8/2.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <LeanCloudSocial/AVOSCloudSNS.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *weixinLoginButton;

/*!
 *@discussion 点击登录按钮
 */
- (IBAction)login:(id)sender;

/*!
 *@discussion 点击qq登录按钮
 */
- (IBAction)qqLogin:(id)sender;

/*!
 *@discussion 点击微信登录按钮
 */
- (IBAction)wechatLogin:(id)sender;

@end
