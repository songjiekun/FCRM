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

@interface ClientListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,InternetImageDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
