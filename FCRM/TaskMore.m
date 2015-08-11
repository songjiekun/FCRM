//
//  TaskMore.m
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "TaskMore.h"

@implementation TaskMore

+(id)createTaskWithTaskName:(NSString*)taskName taskDetail:(NSString*)taskDetail taskLevel:(NSNumber*)taskLevel taskStatus:(NSNumber*)taskStatus taskExpiryDate:(NSDate*)taskExpiryDate  clientID:(NSString*)clientOID taskID:(NSString*)oID   clientTel:(NSString*)clientTel clientName:(NSString*)clientName createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext{
    
    // Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext];
    
    // Initialize Record
    TaskMore *newTask = (TaskMore *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    
    newTask.clientName=clientName;
    newTask.clientTel=clientTel;
    newTask.oID=oID;
    newTask.taskName=taskName;
    newTask.taskDetail=taskDetail;
    newTask.taskExpiryDate=taskExpiryDate;
    newTask.taskLevel=taskLevel;
    newTask.taskStatus=taskStatus;
    newTask.updatedAt=updatedAt;
    newTask.createdAt=createdAt;
    newTask.clientOID=clientOID;
    
    return newTask;
    
    
}


+(id)createTaskWithAVObject:(AVObject*)object context:(NSManagedObjectContext *)managedObjectContext{
    
    AVObject *client=[object objectForKey:@"createdTo"];
    
    NSString* clientName=[client objectForKey:@"clientName"];
    NSString* clientOID=[client objectForKey:@"objectId"];
    NSString* clientTel=[client objectForKey:@"clientTel"];
    NSString* oID=[object objectForKey:@"objectId"];
    NSDate* taskExpiryDate=[object objectForKey:@"taskExpiryDate"];
    NSString* taskDetail=[object objectForKey:@"taskDetail"];
    NSNumber* taskLevel=[object objectForKey:@"taskLevel"];
    NSNumber* taskStatus=[object objectForKey:@"taskStatus"];
    NSString* taskName=[object objectForKey:@"taskName"];
    NSDate* updatedAt=[object objectForKey:@"updatedAt"];
    NSDate* createdAt=[object objectForKey:@"createdAt"];
    
    
    //生成新的task
    TaskMore *newTask = [TaskMore createTaskWithTaskName:taskName taskDetail:taskDetail taskLevel:taskLevel taskStatus:taskStatus taskExpiryDate:taskExpiryDate clientID:clientOID taskID:oID clientTel:clientTel clientName:clientName createdDate:createdAt updatedDate:updatedAt context:managedObjectContext];
    
    return newTask;
    
}


+(void)submitTaskWithTaskName:(NSString*)taskName taskDetail:(NSString*)taskDetail taskLevel:(NSNumber*)taskLevel taskStatus:(NSNumber*)taskStatus taskExpiryDate:(NSDate*)taskExpiryDate  client:(ClientMore*)client context:(NSManagedObjectContext *)managedObjectContext withTarget:(id)target action:(SEL)submitSuccessfully{
    
    AVObject *taskObject = [AVObject objectWithClassName:@"Task"];
    [taskObject setObject:taskName forKey:@"taskName"];
    [taskObject setObject:taskDetail forKey:@"taskDetail"];
    [taskObject setObject:taskLevel forKey:@"taskLevel"];
    [taskObject setObject:taskExpiryDate forKey:@"taskExpiryDate"];
    [taskObject setObject:taskStatus forKey:@"taskStatus"];
    
    //关联client
    AVObject *clientObject =[AVObject objectWithoutDataWithClassName:@"Client" objectId:client.oID];
    [taskObject setObject:clientObject forKey:@"createdTo"];
    
    //关联advisor
    [taskObject setObject:[AVUser currentUser] forKey:@"createdBy"];
    
    //存入cloudlean服务器
    [taskObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            //填充clientobject
            [clientObject setObject:client.clientName forKey:@"clientName"];
            [clientObject setObject:client.clientTel forKey:@"clientTel"];
            
            //存入coredata
            [TaskMore createTaskWithAVObject:taskObject context:managedObjectContext];
            
            NSError *error = nil;
            
            //调用save后 会强行调用fetchedResultsController的delegate
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            else{
                
                //回到发送界面，显示发送成功信息
                [target performSelector:submitSuccessfully];
                
            }
            
            
            
        }
        else{
#warning 提示出错信息
            NSLog(@"%@",error);
        }
        
    }];

    
}

-(void)deletedWithTarget:(id)target action:(SEL)deletedSuccessfully context:(NSManagedObjectContext *)managedObjectContext{
    
    //设置task
    AVObject *taskObject =[AVObject objectWithoutDataWithClassName:@"Task" objectId:self.oID];
    
    __weak TaskMore *wSelf=self;
    
    //存入cloudlean服务器
    [taskObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            //从coredata删除
            [managedObjectContext deleteObject:wSelf];
            
            //调用save后 会强行调用fetchedResultsController的delegate
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            else{
                
                //回到发送界面，显示发送成功信息
                [target performSelector:deletedSuccessfully];
                
            }
            
            
            
        }
        else{
#warning 提示出错信息
            NSLog(@"%@",error);
        }
        
    }];

    
}

-(void)completedWithTarget:(id)target action:(SEL)completedSuccessfully context:(NSManagedObjectContext *)managedObjectContext{
    
    //设置task
    AVObject *taskObject =[AVObject objectWithoutDataWithClassName:@"Task" objectId:self.oID];
    [taskObject setObject:@(2) forKey:@"taskStatus"];
    
    __weak TaskMore *wSelf=self;
    
    //存入cloudlean服务器
    [taskObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            //从coredata中更新
            wSelf.taskStatus=@(2);
            
            //调用save后 会强行调用fetchedResultsController的delegate
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            else{
                
                //回到发送界面，显示发送成功信息
                [target performSelector:completedSuccessfully];
                
            }
            
            
            
        }
        else{
#warning 提示出错信息
            NSLog(@"%@",error);
        }
        
    }];

    
}


+(void)reloadTasks:(id)target action:(SEL)reload context:(NSManagedObjectContext *)managedObjectContext{
    
    AVQuery *query = [AVUser query];
    
    //筛选与排序
    [query whereKey:@"createdBy" equalTo:[AVUser currentUser]];
    
    [query orderByDescending:@"taskExpiryDate"];
    
    //查询products
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            
            
        }
        else{
            
            
            //将获取的数据加入coredata中
            for(AVObject *object in objects) {
                
                //生成新的client
                TaskMore *newTask = [TaskMore createTaskWithAVObject:object context:managedObjectContext];
                
            }
            
            //这里使用target action 可以保证所有的AVObject的调用都在product里面完成
            
            if ([target respondsToSelector:reload]) {
                
                [target performSelector:reload];
                
            }
            
        }
        
    }];

    
}

@end
