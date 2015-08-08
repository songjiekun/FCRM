//
//  TaskMore.h
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "Task.h"
#import <AVOSCloud/AVOSCloud.h>
#import "InternetImage.h"
#import "ClientMore.h"

@interface TaskMore : Task

//创建新的task
+(id)createTaskWithTaskName:(NSString*)taskName taskDetail:(NSString*)taskDetail taskLevel:(NSNumber*)taskLevel taskStatus:(NSNumber*)taskStatus taskExpiryDate:(NSDate*)taskExpiryDate  clientID:(NSString*)clientOID taskID:(NSString*)oID   clientTel:(NSString*)clientTel clientName:(NSString*)clientName createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext;


+(id)createTaskWithAVObject:(AVObject*)object context:(NSManagedObjectContext *)managedObjectContext;

//从客户端提交新的task
+(void)submitTaskWithTaskName:(NSString*)taskName taskDetail:(NSString*)taskDetail taskLevel:(NSNumber*)taskLevel taskStatus:(NSNumber*)taskStatus taskExpiryDate:(NSDate*)taskExpiryDate  client:(ClientMore*)client context:(NSManagedObjectContext *)managedObjectContext withTarget:(id)target action:(SEL)submitSuccessfully;


//从intrnet载入tasks
+(void)reloadTasks:(id)target action:(SEL)reload context:(NSManagedObjectContext *)managedObjectContext;

@end
