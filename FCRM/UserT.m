//
//  UserT.m
//  FCRM
//
//  Created by song jiekun on 15/8/2.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "UserT.h"


@implementation UserT

+(BOOL)isUserLogin{
    
    if ([AVUser currentUser]!=nil) {
        
        return YES;
        
    }
    
    else{
        
        return NO;
        
    }
    
}



+(void)userLogout{
    
    [AVUser logOut];
}



@end
