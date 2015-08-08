//
//  DataHelper.m
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper

+(NSDate*)getDateMidnight:(NSDate*)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; // gets default calendar
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit) fromDate:date]; // gets the year, month, and day for  date
    return [calendar dateFromComponents:components];
    
}

+(NSDate*)getNextDateMidnight:(NSDate*)date{
    
    NSDateComponents *dayComponent=[[NSDateComponents alloc] init];
    dayComponent.day=1;
    
    NSDate *today=[DataHelper getDateMidnight:date];
    NSDate *nextDay=[[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:today options:0];

    return nextDay;
    
}

@end
