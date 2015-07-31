//
//  ProductT.m
//  FCRM
//
//  Created by song jiekun on 15/7/29.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductT.h"


@implementation ProductT

+(id)createProductWithProductName:(NSString*)productName category:(NSString*)productCategory productID:(NSString*)oID level:(NSNumber*)productLevel minAmount:(NSNumber*)productMinAmount yieldRate:(NSNumber*)productYieldRate userScore:(NSNumber*)userScore  period:(NSString*)productPeriod createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt profileUrl:(NSString*)managerProfileImageUrl managerName:(NSString*)managerName{
    
    ProductT* newProduct=[[ProductT alloc] init];
    newProduct.productName=productName;
    newProduct.productCategory=productCategory;
    newProduct.oID=oID;
    newProduct.productLevel=productLevel;
    newProduct.productMinAmount=productMinAmount;
    newProduct.productYieldRate=productYieldRate;
    newProduct.productPeriod=productPeriod;
    newProduct.createdAt=createdAt;
    newProduct.updatedAt=updatedAt;
    newProduct.managerProfileImageUrl=managerProfileImageUrl;
    newProduct.managerName=managerName;
    newProduct.userScore=userScore;
    newProduct.managerProfileInternetImage=[InternetImage createImageWithUrl:managerProfileImageUrl];
    
    return newProduct;
    
}

+(id)createProductWithAVObject:(AVObject*)object{
    
    AVObject* manager=[object objectForKey:@"manager"];
    AVFile *managerProfile=[manager objectForKey:@"profile"];
    
    NSString* oID=[object objectForKey:@"objectId"];
    NSNumber* productLevel=[object objectForKey:@"productLevel"];
    NSString* managerName=[manager objectForKey:@"managerName"];
    NSString* managerProfileImageUrl=managerProfile.url;
    NSNumber* productMinAmount=[object objectForKey:@"productMinAmount"];
    NSString* productPeriod=[object objectForKey:@"productPeriod"];
    NSString* productName=[object objectForKey:@"productName"];
    NSString* productCategory= [object objectForKey:@"productCategory"];
    NSDate* updatedAt=[object objectForKey:@"updatedAt"];
    NSDate* createdAt=[object objectForKey:@"createdAt"];
    NSNumber* productYieldRate=[object objectForKey:@"productYieldRate"];
    NSNumber* userScore=[object objectForKey:@"userScore"];
    
    
    //生成新的product
    ProductT *newProduct = [ProductT createProductWithProductName:productName category:productCategory productID:oID level:productLevel minAmount:productMinAmount yieldRate:productYieldRate userScore:userScore period:productPeriod createdDate:createdAt updatedDate:updatedAt profileUrl:managerProfileImageUrl managerName:managerName];
    
    return newProduct;
    
}

+(void)reloadProducts:(id)target action:(SEL)reload category:(NSString*)productCategory{
    
    [ProductT reloadProducts:target action:reload category:(NSString*)productCategory level:nil sort:nil];
    
}

+(void)reloadProducts:(id)target action:(SEL)reload category:(NSString*)productCategory level:(NSNumber*)productLevel sort:(NSString*)productSort{
    
    AVQuery *query = [AVQuery queryWithClassName:@"Product"];
    
    //包含 manager对象 包含profile的avfile对象
    [query includeKey:@"manager"];
    
    [query includeKey:@"manager.profile"];
    
    
    //筛选与排序
    //筛选
    if (productCategory) {
        
        [query whereKey:@"productCategory" equalTo:productCategory];
        
    }
    
    if (productLevel) {
        
        [query whereKey:@"productLevel" equalTo:productLevel];
        
    }
    
    //排序
    if (productSort) {
        
        if ([productSort isEqualToString:@"productYieldRate"]) {
            
            [query orderByDescending:@"productYieldRate"];
            
        }else if ([productSort isEqualToString:@"productMinAmount"]) {
            
            [query orderByAscending:@"productMinAmount"];
            
        }else if ([productSort isEqualToString:@"userScore"]) {
            
            [query orderByDescending:@"userScore"];
            
        }
 
    }
    
    
    
    

    /*
    //查询products的条件
    query.limit=2;
    query.skip=0;
     */
    
    //查询products
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            
            
        }
        else{
            
            NSMutableArray *reloadedProducts=[[NSMutableArray alloc] initWithCapacity:objects.count];
            
            //将获取的数据填充入product数组中
            for(AVObject *object in objects) {

                //生成新的product
                ProductT *newProduct = [ProductT createProductWithAVObject:object];
                
                [reloadedProducts addObject:newProduct];
                
            }
            
            //这里使用target action 可以保证所有的AVObject的调用都在product里面完成
            
            if ([target respondsToSelector:reload]) {
                
                [target performSelector:reload withObject:reloadedProducts];
                
            }
            
        }
        
    }];
    
}

@end
