//
//  TaskListViewController.m
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "TaskListViewController.h"
#import "MBProgressHUD.h"
#import "TaskTableViewCell.h"
#import "ViewHelper.h"
#import "DataHelper.h"
#import "ControlVariables.h"


@interface TaskListViewController ()

@end

@implementation TaskListViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        ////初始化fetchedResultsController
        //初始化 Fetch Request
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
        
        //排序
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"taskExpiryDate" ascending:NO]]];
        
        //筛选
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"taskStatus == 1"]];
        
        //初始化 Fetched Results Controller
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext=app.managedObjectContext;
        
        //缓存client
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        //fetchedResultsController设置代理
        self.fetchedResultsController.delegate=self;
        
        // Perform Fetch
        NSError *error = nil;
        [self.fetchedResultsController performFetch:&error];
        
#warning 提示出错信息
        if (error) {
            NSLog(@"Unable to perform fetch.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        
    }
    
    return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ////原始tableview
    //注册 custom tableviewcell
    UINib *nib = [UINib nibWithNibName:@"TaskTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TaskTableViewCell"];
    
    
    //ios 8设置tableview的高度
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        self.tableView.rowHeight= UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight=65+20+10;
        
    }
    
    //去掉系统默认分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    ////DZNSegmentedControl
    NSArray *items = @[@"全部任务", @"今天任务", @"明天任务",@"已完成"];
    
    self.segmentedControl.items=items;
    self.segmentedControl.tintColor = kMainColor;
    //self.segmentedControl.delegate = self;
    self.segmentedControl.selectedSegmentIndex = 0;
    
    [self.segmentedControl addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    //设置顶端数字
    [self configureSegmentedcontrolCounts];
    
    
    
}

#pragma mark - DZNSegmentedControl 处理方法
- (void)selectedSegment:(DZNSegmentedControl *)control
{
    
    //清空frc
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
    
    ////初始化searchFetchedResultsController
    NSFetchRequest *fetchRequest= [self configureFetchrequest:control.selectedSegmentIndex];
    
    //初始化 Fetched Results Controller
    //不需要缓存
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    //fetchedResultsController设置代理
    self.fetchedResultsController.delegate=self;
    
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
#warning 提示出错信息
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetchedResultsController 代理
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView beginUpdates];
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self configureSegmentedcontrolCounts];
    [self.tableView endUpdates];
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            
            TaskMore *task = [controller objectAtIndexPath:indexPath];
            
            [ViewHelper configureTaskCell:(TaskTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] task:task];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell" forIndexPath:indexPath];
    
    TaskMore *task = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [ViewHelper configureTaskCell:cell task:task];
    
    return cell;
}

//通过xib来定义的cell 必须通过didSelectRowAtIndexPath来触发segue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //查看Task详细页面
    [self performSegueWithIdentifier:@"TaskDetailSegue" sender:tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        return UITableViewAutomaticDimension;
    }
    else {
        
        return 65+20+10;//图片大小65x65 上下空挡各10;
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - helper 方法

/*!
 *@discussion 获取segmentedControl任务的数量
 */
-(void)configureSegmentedcontrolCounts{
    
    
    //第一个
    NSFetchRequest *fetchRequest=[self configureFetchrequest:0];
    
    NSError *error = nil;
    NSUInteger count=[self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
#warning 提示出错信息
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    else{
        
        [self.segmentedControl setCount:@(count) forSegmentAtIndex:0];
        
    }
    
    //第二个
    fetchRequest=[self configureFetchrequest:1];
    
    error = nil;
    count=[self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
#warning 提示出错信息
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    else{
        
        [self.segmentedControl setCount:@(count) forSegmentAtIndex:1];
        
    }
    
    //第三个
    fetchRequest=[self configureFetchrequest:2];
    
    error = nil;
    count=[self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
#warning 提示出错信息
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    else{
        
        [self.segmentedControl setCount:@(count) forSegmentAtIndex:2];
        
    }
 
    //第四个
    fetchRequest=[self configureFetchrequest:3];
    
    error = nil;
    count=[self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
#warning 提示出错信息
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    else{
        
        [self.segmentedControl setCount:@(count) forSegmentAtIndex:3];
        
    }
    
}

-(NSFetchRequest*)configureFetchrequest:(NSInteger)selectedSegmentIndex{
    
    //初始化 Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    fetchRequest.fetchBatchSize=20;
    //无需限定数量
    //fetchRequest.fetchLimit=20;
    
    //根据segment的不同设置不同的排序和筛选条件
    //排序
    NSSortDescriptor *sort=nil;
    
    //筛选
    NSPredicate *predict=nil;
    
    //获取今天午夜和明天午夜的时间
    NSDate *today=[DataHelper getDateMidnight:[NSDate date]];
    NSDate *tomorrow=[DataHelper getNextDateMidnight:[NSDate date]];
    NSDate *dayAfterTomorrow=[DataHelper getNextDateMidnight:tomorrow];
    
    switch (selectedSegmentIndex) {
            //全部
        case 0:
            sort=[NSSortDescriptor sortDescriptorWithKey:@"taskExpiryDate" ascending:NO];
            predict=[NSPredicate predicateWithFormat:@"taskStatus == 1"];
            break;
            //今天
        case 1:
            sort=[NSSortDescriptor sortDescriptorWithKey:@"taskLevel" ascending:NO];
            predict=[NSPredicate predicateWithFormat:@"(taskStatus == 1) AND (taskExpiryDate>=%@) AND (taskExpiryDate<%@)",today,tomorrow];
            break;
            //明天
        case 2:
            sort=[NSSortDescriptor sortDescriptorWithKey:@"taskLevel" ascending:NO];
            predict=[NSPredicate predicateWithFormat:@"(taskStatus == 1) AND (taskExpiryDate>=%@) AND (taskExpiryDate<%@)",tomorrow,dayAfterTomorrow];
            break;
            //已完成
        case 3:
            sort=[NSSortDescriptor sortDescriptorWithKey:@"taskExpiryDate" ascending:NO];
            predict=[NSPredicate predicateWithFormat:@"taskStatus == 2"];
            break;
            
        default:
            sort=[NSSortDescriptor sortDescriptorWithKey:@"taskExpiryDate" ascending:NO];
            predict=[NSPredicate predicateWithFormat:@"taskStatus == 1"];
            break;
    }
    
    //排序
    [fetchRequest setSortDescriptors:@[sort]];
    
    //筛选
    [fetchRequest setPredicate:predict];
    
    return fetchRequest;

    
}

@end
