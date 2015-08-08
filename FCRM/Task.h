//
//  Task.h
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSString * clientTel;
@property (nonatomic, retain) NSString * oID;
@property (nonatomic, retain) NSString * taskDetail;
@property (nonatomic, retain) NSNumber * taskLevel;
@property (nonatomic, retain) NSNumber * taskStatus;
@property (nonatomic, retain) NSString * clientName;
@property (nonatomic, retain) NSDate * taskExpiryDate;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * clientOID;

@end
