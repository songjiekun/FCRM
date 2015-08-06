//
//  ClientMore.m
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ClientMore.h"

@implementation ClientMore

@synthesize clientProfileInternetImage=_clientProfileInternetImage;

-(InternetImage*)clientProfileInternetImage{
    
    if (_clientProfileInternetImage) {
        
        return _clientProfileInternetImage;
    }
    else{
        
        _clientProfileInternetImage=[InternetImage createImageWithUrl:self.clientProfileImageUrl];
        
        return _clientProfileInternetImage;
        
    }
    
}


+(id)createClientWithClientName:(NSString*)clientName clientRisk:(NSNumber*)clientRisk clientID:(NSString*)oID clientIncome:(NSNumber*)clientIncome clientAge:(NSNumber*)clientAge   clientTel:(NSString*)clientTel profileUrl:(NSString*)clientProfileImageUrl createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext{
    
    // Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:managedObjectContext];

    // Initialize Record
    ClientMore *newClient = (ClientMore *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    
    newClient.clientName=clientName;
    newClient.clientAge=clientAge;
    newClient.clientIncome=clientIncome;
    newClient.clientProfileImageUrl=clientProfileImageUrl;
    newClient.clientRisk=clientRisk;
    newClient.clientTel=clientTel;
    newClient.oID=oID;
    newClient.createdAt=createdAt;
    newClient.updatedAt=updatedAt;
    newClient.clientProfileInternetImage=[InternetImage createImageWithUrl:clientProfileImageUrl];
    
    return newClient;

    
    
}


+(id)createClientWithAVObject:(AVObject*)object context:(NSManagedObjectContext *)managedObjectContext{
    
    AVFile *clientProfile=[object objectForKey:@"profile"];
    
    NSString* oID=[object objectForKey:@"objectId"];
    NSNumber* clientAge=[object objectForKey:@"clientAge"];
    NSString* clientName=[object objectForKey:@"clientName"];
    NSString* clientProfileImageUrl=clientProfile.url;
    NSNumber* clientIncome=[object objectForKey:@"clientIncome"];
    NSNumber* clientRisk=[object objectForKey:@"clientRisk"];
    NSString* clientTel=[object objectForKey:@"clientTel"];
    NSDate* updatedAt=[object objectForKey:@"updatedAt"];
    NSDate* createdAt=[object objectForKey:@"createdAt"];
    
    
    //生成新的product
    ClientMore *newClient = [ClientMore createClientWithClientName:clientName clientRisk:clientRisk clientID:oID clientIncome:clientIncome clientAge:clientAge   clientTel:clientTel profileUrl:clientProfileImageUrl createdDate:createdAt updatedDate:updatedAt context:managedObjectContext];
    
    return newClient;
    
}

+(void)submitClientWithClientName:(NSString*)clientName clientRisk:(NSNumber*)clientRisk clientIncome:(NSNumber*)clientIncome clientAge:(NSNumber*)clientAge   clientTel:(NSString*)clientTel profileImage:(UIImage *)profileImage context:(NSManagedObjectContext *)managedObjectContext withTarget:(id)target action:(SEL)submitSuccessfully{
    
    AVObject *clientObject = [AVObject objectWithClassName:@"Client"];
    [clientObject setObject:clientName forKey:@"clientName"];
    [clientObject setObject:clientRisk forKey:@"clientRisk"];
    [clientObject setObject:clientIncome forKey:@"clientIncome"];
    [clientObject setObject:clientTel forKey:@"clientTel"];
    [clientObject setObject:clientAge forKey:@"clientAge"];
    
    //关联profile图片文件
    NSData *data=UIImageJPEGRepresentation(profileImage, 0.2);
    AVFile *profile=[AVFile fileWithName:@"test.jpg" data:data];
    [clientObject setObject:profile forKey:@"profile"];
    
    //关联advisor
    [clientObject setObject:[AVUser currentUser] forKey:@"advisor"];
    
    //存入cloudlean服务器
    [clientObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            //存入coredata
            [ClientMore createClientWithAVObject:clientObject context:managedObjectContext];

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

-(void)recommendedWithProduct:(ProductT*)product withTarget:(id)target action:(SEL)recommendedSuccessfully{
    
    AVObject *recommendationObject = [AVObject objectWithClassName:@"Recommendation"];
    //关联client product 和 当前的用户
    [recommendationObject setObject:[AVUser currentUser] forKey:@"recommendedBy"];
    [recommendationObject setObject:[AVObject objectWithoutDataWithClassName:@"Client" objectId:self.oID] forKey:@"recommendedTo"];
    [recommendationObject setObject:[AVObject objectWithoutDataWithClassName:@"Product" objectId:product.oID] forKey:@"recommendedWith"];
    
    //存入cloudlean服务器
    [recommendationObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            //回到发送界面，显示推荐成功信息
            [target performSelector:recommendedSuccessfully];
              
        }
        else{
#warning 提示出错信息
            NSLog(@"%@",error);
        }
        
    }];

    
}

//从intrnet载入clients
+(void)reloadClients:(id)target action:(SEL)reload byUser:(AVUser*)currentUser context:(NSManagedObjectContext *)managedObjectContext{
    
    AVQuery *query = [AVUser query];

    
    //筛选与排序
    [query whereKey:@"advisor" equalTo:currentUser];
    
    [query orderByDescending:@"createdAt"];


    //查询products
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            
            
        }
        else{
            
            
            //将获取的数据加入coredata中
            for(AVObject *object in objects) {
                
                //生成新的client
                ClientMore *newClient = [ClientMore createClientWithAVObject:object context:managedObjectContext];
                
            }
            
            //这里使用target action 可以保证所有的AVObject的调用都在product里面完成
            
            if ([target respondsToSelector:reload]) {
                
                [target performSelector:reload];
                
            }
            
        }
        
    }];
    
}

@end
