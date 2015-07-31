//
//  InternetImage.h
//  FCRM
//
//  Created by song jiekun on 15/7/31.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//图片的状态
typedef NS_ENUM(NSInteger, ImageState){
    
    ImageStateNew,
    ImageStateCached,
    ImageStateDisked,
    ImageStateDownloaded,
    ImageStateFailed
    
};

@class InternetImage;

@protocol InternetImageDelegate <NSObject>

//代理将更新UI
-(void)refreshImage:(InternetImage *)sender withImage:(UIImage *)newImage;

@end


/**
 InternetImage是一个图片载入的类
 分三步来载入图片
 1.检查nscache中是否有内存缓存
 2.检查磁盘中是否有文件已经存在
 3.从互联网下载图片
 **/
@interface InternetImage : NSObject

/**图片载入状态
 **/
@property (nonatomic,readonly) ImageState theState;

@property (nonatomic, retain) NSString * imageUrl;

@property (nonatomic,weak) id <InternetImageDelegate> delegate;

//通过url来初始化
+(id)createImageWithUrl:(NSString *)imageUrl;

/**
 获取图片 在方法中调用代理对ui进行更新
 返回一张placeholder图片
 sender用来获取是哪个view调用了这个方法，以便在ui更新时能找到这个view
 cache是整个程序的memory NSCache
 **/
-(UIImage *)retrieveImage:(id)sender fromCache:(NSCache *)cache atIOQueue:(NSOperationQueue *)ioQueue atInternetQueue:(NSOperationQueue *)internetQueue;

//取消图片的下载等操作
-(void)cancel;


@end
