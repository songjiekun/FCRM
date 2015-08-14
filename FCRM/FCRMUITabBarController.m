//
//  FCRMUITabBarController.m
//  FCRM
//
//  Created by song jiekun on 15/8/14.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "FCRMUITabBarController.h"
#import "ControlVariables.h"
#import "UserT.h"
#import "ProductListViewController.h"
#import "ViewHelper.h"

@implementation FCRMUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //颜色
    self.tabBar.tintColor=kMainColor;
    
    //代理
    self.delegate=self;
    
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard1=[UIStoryboard storyboardWithName:@"ProductList" bundle:nil];
    
    UINavigationController *productListNavigationController=[storyboard1 instantiateViewControllerWithIdentifier:@"ProductListNavigationController"];
    
    UIStoryboard *storyboard2=[UIStoryboard storyboardWithName:@"ClientList" bundle:nil];
    
    UINavigationController *clientListNavigationController=[storyboard2 instantiateViewControllerWithIdentifier:@"ClientListNavigationController"];
    
    UIStoryboard *storyboard3=[UIStoryboard storyboardWithName:@"TaskList" bundle:nil];
    
    UINavigationController *taskListNavigationController=[storyboard3 instantiateViewControllerWithIdentifier:@"TaskListNavigationController"];
    
    
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    [tabViewControllers addObject:productListNavigationController];
    [tabViewControllers addObject:clientListNavigationController];
    [tabViewControllers addObject:taskListNavigationController];
    
    [self setViewControllers:tabViewControllers];
    
    //can't set this until after its added to the tab bar
    productListNavigationController.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"产品列表"
                                  image:[UIImage imageNamed:@"Image-1"]
                                    tag:1];
    clientListNavigationController.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"客户列表"
                                  image:[UIImage imageNamed:@"Image"]
                                    tag:2];
    taskListNavigationController.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"任务管理"
                                  image:[UIImage imageNamed:@"Image-3"]
                                    tag:3];
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if (![viewController isKindOfClass:[ProductListViewController class]]) {
        //非产品页面需要登录
        if ([UserT isUserLogin]) {
            
            return YES;
            
        }
        else{
            
            [ViewHelper popoutLoginWithController:tabBarController.selectedViewController];
            return NO;
            
        }
    }
    else{
        //产品页面
        return YES;
    }
    
    
    
}
@end
