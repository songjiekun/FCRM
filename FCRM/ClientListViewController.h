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



//helper 方法
/*!
 *@discussion 根据tableview来选择fetchedResultsController
 */
- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView;

/*!
 *@discussion 根据fetchedResultsController来选择tableview
 */
- (UITableView *)tableViewForFetchedResultsController:(NSFetchedResultsController *)controller;

@end
