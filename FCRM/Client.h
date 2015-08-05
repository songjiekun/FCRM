//
//  Client.h
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Client : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * oID;
@property (nonatomic, retain) NSString * clientProfileImageUrl;
@property (nonatomic, retain) NSString * clientTel;
@property (nonatomic, retain) NSString * clientName;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSNumber * clientAge;
@property (nonatomic, retain) NSNumber * clientRisk;
@property (nonatomic, retain) NSNumber * clientIncome;

@end
