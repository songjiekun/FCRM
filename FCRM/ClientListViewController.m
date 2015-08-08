//
//  ClientListViewController.m
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ClientListViewController.h"
#import "ClientTableViewCell.h"
#import "ViewHelper.h"
#import "MBProgressHUD.h"

@interface ClientListViewController ()

@end

@implementation ClientListViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        [self initData];
        
    }
    
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if((self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        
        [self initData];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ////原始tableview
    //注册 custom tableviewcell
    UINib *nib = [UINib nibWithNibName:@"ClientTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ClientTableViewCell"];
    
    
    //ios 8设置tableview的高度
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        self.tableView.rowHeight= UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight=65+20+10;
        
    }
    
    //去掉系统默认分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    //////search tableview
    nib = [UINib nibWithNibName:@"ClientTableViewCell" bundle:nil];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"ClientTableViewCell"];
    
    //ios 8设置tableview的高度
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        self.searchDisplayController.searchResultsTableView.rowHeight= UITableViewAutomaticDimension;
        self.searchDisplayController.searchResultsTableView.estimatedRowHeight=65+20+10;
    }
    
    //去掉系统默认分割线
    self.searchDisplayController.searchResultsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //背景设置成淡灰色
    self.searchDisplayController.searchResultsTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - target action回调方法
/*!
 *@discussion 从互联网刷新列表 更新tableview
 */
/*
 -(void)reloadProductList:(NSMutableArray*)reloadedProducts{
 
 //重新载入tableview数据
 self.products=reloadedProducts;
 [self.tableView reloadData];
 
 //灰色view隐藏掉
 self.grayView.hidden=YES;
 
 }
 */

#pragma mark - InternetImage 的代理
-(void)refreshImage:(InternetImage *)sender withImage:(UIImage *)newImage{
    
    //在原始tableview中查找
    for (ClientMore *client in self.fetchedResultsController.fetchedObjects) {
        
        InternetImage *clientProfileImage=client.clientProfileInternetImage;
        
        //找到图片对应的cell
        if (clientProfileImage==sender) {
            
            NSInteger productIndex = [self.fetchedResultsController.fetchedObjects indexOfObject:client];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:productIndex inSection:0];
            
            ClientTableViewCell *cell = (ClientTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            if (cell) {
                
                cell.clientProfileImageView.image=newImage;
                
                cell.clientProfileImageView.alpha=0;
                
                
                //图片淡入淡出
                [UIView animateWithDuration:0.3 animations:^{
                    
                    cell.clientProfileImageView.alpha=1;
                    
                }];
                
                
            }
            

            return;
            
        }
        
    }
    
    //在原始search tableview中查找
    for (ClientMore *client in self.searchFetchedResultsController.fetchedObjects) {
        
        InternetImage *clientProfileImage=client.clientProfileInternetImage;
        
        //找到图片对应的cell
        if (clientProfileImage==sender) {
            
            NSInteger productIndex = [self.searchFetchedResultsController.fetchedObjects indexOfObject:client];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:productIndex inSection:0];
            
            ClientTableViewCell *cell = (ClientTableViewCell *)[self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
            
            if (cell) {
                
                cell.clientProfileImageView.image=newImage;
                
                cell.clientProfileImageView.alpha=0;
                
                
                //图片淡入淡出
                [UIView animateWithDuration:0.3 animations:^{
                    
                    cell.clientProfileImageView.alpha=1;
                    
                }];
                
                
            }
            
            
            return;
            
        }
        
    }

    
}


#pragma mark UISearchDisplayController 代理
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView;
{
    // search is done so get rid of the search FRC and reclaim memory
    self.searchFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - fetchedResultsController 代理
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView beginUpdates];
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
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

            
            //根据普通fetchedResultsController  还是searchFetchedResultsController 来获取 tableview
            UITableView *tv=[self tableViewForFetchedResultsController:controller];
            ClientMore *client = [controller objectAtIndexPath:indexPath];
            
            [ViewHelper configureClientCell:(ClientTableViewCell *)[tv cellForRowAtIndexPath:indexPath] client:client fromCache:self.imageCache atIOQueue:self.ioQueue atInternetQueue:self.internetQueue controller:self];
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
    
    //根据普通tableview 还是search tableview来获取fetchedResultsController
    NSFetchedResultsController *frc= [self fetchedResultsControllerForTableView:tableView];
    
    // Return the number of sections.
    return [[frc sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //根据普通tableview 还是search tableview来获取fetchedResultsController
    NSFetchedResultsController *frc= [self fetchedResultsControllerForTableView:tableView];
    
    // Return the number of rows in the section.
    NSArray *sections = [frc sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientTableViewCell" forIndexPath:indexPath];
    
    //根据普通tableview 还是search tableview来获取fetchedResultsController
    NSFetchedResultsController *frc= [self fetchedResultsControllerForTableView:tableView];
    ClientMore *client = [frc objectAtIndexPath:indexPath];
    
    [ViewHelper configureClientCell:cell client:client fromCache:self.imageCache atIOQueue:self.ioQueue atInternetQueue:self.internetQueue controller:self];
    
    return cell;
}

//通过xib来定义的cell 必须通过didSelectRowAtIndexPath来触发segue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //查看用户详细页面
    [self performSegueWithIdentifier:@"ClientDetailSegue" sender:tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        return UITableViewAutomaticDimension;
    }
    else {
        
        return 65+20+10;//图片大小65x65 上下空挡各10;
    }
    
}




#pragma mark - prepareForSegue传递数据

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ProductDetailViewController *destinationVC=segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"ProductDetailSegue"]) {
        
        NSIndexPath *indexPath= [self.tableView indexPathForSelectedRow];
        
        //传递数据
        destinationVC.product=self.products[indexPath.row];
        
    }
}
*/

#pragma mark - helper 方法
/*!
 *@discussion 根据tableview来选择fetchedResultsController
 */
- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
    return tableView == self.tableView ? self.fetchedResultsController : self.searchFetchedResultsController;
}

/*!
 *@discussion 根据fetchedResultsController来选择tableview
 */
- (UITableView *)tableViewForFetchedResultsController:(NSFetchedResultsController *)controller
{
    return controller == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
}

/*!
 *@discussion 更新搜索结果
 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSInteger)scope
{
    //清空frc
    self.searchFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController = nil;
    
    ////初始化searchFetchedResultsController
    //初始化 Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    
    //排序
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO]]];
    
    //筛选
    NSPredicate *predict=nil;
    if(searchText.length)
    {
        predict=[NSPredicate predicateWithFormat:@"clientName CONTAINS[cd] %@",searchText];
        [fetchRequest setPredicate:predict];
    }
    
    fetchRequest.fetchBatchSize=20;
    //无需限定数量
    //fetchRequest.fetchLimit=20;
    
    
    //初始化 Fetched Results Controller
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext=app.managedObjectContext;
    
    //不需要缓存
    self.searchFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    //fetchedResultsController设置代理
    self.searchFetchedResultsController.delegate=self;
    
    // Perform Fetch
    NSError *error = nil;
    [self.searchFetchedResultsController performFetch:&error];
    
#warning 提示出错信息
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    
}

-(void)initData{
    
    //默认为非选择模式
    //self.isSelectionMod=NO;
    
    //多线程,图片缓存 初始化
    self.imageCache=[[NSCache alloc] init];
    
    self.ioQueue=[[NSOperationQueue alloc] init];
    self.ioQueue.maxConcurrentOperationCount=40;
    
    self.internetQueue=[[NSOperationQueue alloc] init];
    self.internetQueue.maxConcurrentOperationCount=10;
    
    ////初始化fetchedResultsController
    //初始化 Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    
    //排序
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO]]];
    
    //初始化 Fetched Results Controller
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext=app.managedObjectContext;
    
    //缓存client
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"client"];
    
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
    
    ////初始化searchFetchedResultsController
    self.searchFetchedResultsController=nil;
    self.searchFetchedResultsController.delegate=self;
    
}


@end
