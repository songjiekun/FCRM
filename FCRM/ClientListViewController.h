//
//  ClientListViewController.h
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InternetImage.h"
#import "ProductT.h"
#import "ClientMore.h"

@interface ClientListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,InternetImageDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/*!
 *@discussion 设置clientlistcontroller是否为“选择模式”
 */
@property (nonatomic) BOOL isSelectionMod;
/*!
 *@discussion product数据
 */
@property (nonatomic, strong) ProductT* product;
/*!
 *@discussion 选中的client数据，用来在alertview中使用
 */
@property (nonatomic, strong) ClientMore* selectedClient;
//core data相关
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//search使用的core data
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;

//图片异步获取相关
@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) NSOperationQueue *ioQueue;
@property (strong, nonatomic) NSOperationQueue *internetQueue;



@end
