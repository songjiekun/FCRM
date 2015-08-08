//
//  ClientMore.h
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "Client.h"
#import <AVOSCloud/AVOSCloud.h>
#import "InternetImage.h"
#import "ProductT.h"

@interface ClientMore : Client

/*!
 *@discussion 互联网上获取图片
 */
@property (strong, nonatomic) InternetImage* clientProfileInternetImage;

//创建新的client
+(id)createClientWithClientName:(NSString*)clientName clientRisk:(NSNumber*)clientRisk clientID:(NSString*)oID clientIncome:(NSNumber*)clientIncome clientAge:(NSNumber*)clientAge   clientTel:(NSString*)clientTel profileUrl:(NSString*)clientProfileImageUrl createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext;


+(id)createClientWithAVObject:(AVObject*)object context:(NSManagedObjectContext *)managedObjectContext;

//从客户端提交新的client
+(void)submitClientWithClientName:(NSString*)clientName clientRisk:(NSNumber*)clientRisk clientIncome:(NSNumber*)clientIncome clientAge:(NSNumber*)clientAge   clientTel:(NSString*)clientTel profileImage:(UIImage *)profileImage context:(NSManagedObjectContext *)managedObjectContext withTarget:(id)target action:(SEL)submitSuccessfully;

//从客户端为client推荐product
-(void)recommendedWithProduct:(ProductT*)product withTarget:(id)target action:(SEL)recommendedSuccessfully;

//从intrnet载入clients
+(void)reloadClients:(id)target action:(SEL)reload context:(NSManagedObjectContext *)managedObjectContext;


@end
