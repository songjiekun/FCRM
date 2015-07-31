//
//  InternetImage.m
//  FCRM
//
//  Created by song jiekun on 15/7/31.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "InternetImage.h"

@interface InternetImage ()

@property (strong, nonatomic) NSBlockOperation *internetOperation;
@property (nonatomic,readwrite) ImageState theState;

@end

@implementation InternetImage

//设置默认值
-(ImageState)theState{
    
    if (!_theState) {
        
        _theState=ImageStateNew;
        
    }
    
    return _theState;
}


//添加新的ManagedObject
+(id)createImageWithUrl:(NSString *)imageUrl{
    
    // Create imageWith
    InternetImage* internetImage=[[InternetImage alloc] init];
    
    internetImage.imageUrl=imageUrl;
    internetImage.theState=ImageStateNew;
    internetImage.internetOperation=nil;
    
    return internetImage;
    
}


-(UIImage *)retrieveImage:(id)sender fromCache:(NSCache *)cache atIOQueue:(NSOperationQueue *)ioQueue  atInternetQueue:(NSOperationQueue *)internetQueue{
    
    
    if (self.theState==ImageStateFailed) {
        
        //如果图片是失败的状态，直接返回默认图片
        return [UIImage imageNamed:@"high"];
        
    }
    
    
    //首先尝试获取内存缓存中的图片
    UIImage *cachedImage = [cache objectForKey:self.imageUrl];
    
    if (cachedImage) {
        
        //设置图片状态为从缓存读取
        self.theState=ImageStateCached;
        
        //如果内存缓存中已经存有此图片
        return cachedImage;
        
    }
    else{
        
        //图片是否存在磁盘中
        NSFileManager *fm=[NSFileManager defaultManager];
        NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        NSString  *filePath = [documentsDirectory stringByAppendingPathComponent:self.imageUrl];
        
        BOOL isImageExists=[fm fileExistsAtPath:filePath];
        
        if (isImageExists) {
            
            //避免retain cycle
            __weak InternetImage *wSelf=self;
            
            //如果图片存在于磁盘中
            //将文件读取以及解压任务 加入io队列
            [ioQueue addOperationWithBlock:^{
                
                //从磁盘读取图片
                UIImage *diskedImage=[[UIImage alloc] initWithContentsOfFile:filePath];
                
                if (diskedImage) {
                    
                    //解压缩图片
                    UIGraphicsBeginImageContextWithOptions(diskedImage.size, NO, diskedImage.scale);
                    [diskedImage drawAtPoint:CGPointZero];
                    diskedImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    //图片放到内存缓存中
                    [cache setObject:diskedImage forKey:wSelf.imageUrl];
                    
                    //设置图片状态为从磁盘读取
                    wSelf.theState=ImageStateDisked;
                    
                    //更新ui
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        [wSelf.delegate refreshImage:wSelf withImage:diskedImage];
                        
                    }];
                    
                    
                }
                else{
                    
                    //从磁盘读取失败
                    wSelf.theState=ImageStateFailed;
                    
                }
                
            }];
            
            //先返回placeholder图片
            return [UIImage imageNamed:@"high"];
            
        }
        else {
            
            //避免retain cycle
            __weak InternetImage *wSelf=self;
            
            
            //设置下载图片的任务
            self.internetOperation=[NSBlockOperation blockOperationWithBlock:^{
                
                //检查任务是否已经被取消
                if (wSelf.internetOperation.isCancelled) {
                    
                    return;
                    
                }
                
                //从互联网获取图片的data
                NSURL *imageUrl=[NSURL URLWithString:self.imageUrl];
                NSData *data=[NSData dataWithContentsOfURL:imageUrl];
                
                if (data) {
                    
                    UIImage *internetImage=[UIImage imageWithData:data];
                    
                    //保存图片到磁盘
                    [data writeToFile:filePath atomically:YES];
                    
                    //图片放到内存缓存中
                    [cache setObject:internetImage forKey:wSelf.imageUrl];
                    
                    //设置图片状态为被下载
                    wSelf.theState=ImageStateDownloaded;
                    
                    //更新ui
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        [wSelf.delegate refreshImage:wSelf withImage:internetImage];
                        
                    }];
                    
                }
                else{
                    
                    //从网络读取失败
                    wSelf.theState=ImageStateFailed;
                    
                }
                
            }];
            
            //任务加入队列
            [internetQueue addOperation:self.internetOperation];
            
            //先返回placeholder图片
            return [UIImage imageNamed:@"high"];
            
        }
        
    }
    
}

-(void)cancel{
    
    if (self.internetOperation!=nil) {
        
        [self.internetOperation cancel];
        
    }
    
}


@end
