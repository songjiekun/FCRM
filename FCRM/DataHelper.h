//
//  DataHelper.h
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject

+(NSDate*)getDateMidnight:(NSDate*)date;

+(NSDate*)getNextDateMidnight:(NSDate*)date;

@end
