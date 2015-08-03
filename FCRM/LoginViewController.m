//
//  LoginViewController.m
//  FCRM
//
//  Created by song jiekun on 15/8/2.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //如果没有安装qq或微信  就不显示
    if (![AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSQQ]) {
        self.qqLoginButton.hidden=YES;
    }
    
    if (![AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSWeiXin]) {
        self.weixinLoginButton.hidden=YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 用户登录
- (IBAction)login:(id)sender{
    
    __weak LoginViewController* wSelf=self;
    NSString* username=self.usernameTextField.text;
    NSString* password=self.passwordTextField.text;
    
    
    [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
        
        if (user !=nil) {
            
            [wSelf dismissViewControllerAnimated:YES completion:nil];
            
        }
        else {
            
#warning 提示出错信息
            
        }
    }];
    
}

- (IBAction)qqLogin:(id)sender{
    
    //用户通过微博登录
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"100512940" andAppSecret:@"afbfdff94b95a2fb8fe58a8e24c4ba5f" andRedirectURI:nil];
    
    __weak LoginViewController *wSelf=self;
    
    //调用qq登录
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
     
        //qq数据获取成功
        if (object && error==nil) {
     
            //与用户数据库绑定
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                
                if (user && error==nil){
                    
                    //登录成功 关闭登录界面
                    [wSelf dismissViewControllerAnimated:YES completion:nil];
                    
                }
                else{
                    
#warning 提示出错信息
                    //登录失败
                    
                }
                
                

            }];
     
        }
        else {
            
            
#warning 提示出错信息
            //授权失败

     
        }
     

     } toPlatform:AVOSCloudSNSQQ];
     
    
}

- (IBAction)wechatLogin:(id)sender{
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSWeiXin withAppKey:@"wxa3eacc1c86a717bc" andAppSecret:@"b5bf245970b2a451fb8cebf8a6dff0c1" andRedirectURI:nil];
    
    __weak LoginViewController *wSelf=self;
    
    //调用qq登录
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        
        //qq数据获取成功
        if (object && error==nil) {
            
            //与用户数据库绑定
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiXin block:^(AVUser *user, NSError *error) {
                
                if (user && error==nil){
                    
                    //登录成功 关闭登录界面
                    [wSelf dismissViewControllerAnimated:YES completion:nil];
                    
                }
                else{
                    
#warning 提示出错信息
                    //登录失败
                    
                }
                
                
                
            }];
            
        }
        else {
            
            
#warning 提示出错信息
            //授权失败
            
            
        }
        
        
    } toPlatform:AVOSCloudSNSWeiXin];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
