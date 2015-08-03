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

@end
