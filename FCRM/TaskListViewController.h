//
//  TaskListViewController.h
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <DZNSegmentedControl.h>
#import "AppDelegate.h"
#import "TaskMore.h"

@interface TaskListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segmentedControl;

//core data
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
