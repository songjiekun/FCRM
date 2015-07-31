//
//  ProductListViewController.h
//  FCRM
//
//  Created by song jiekun on 15/7/30.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductT.h"
#import "SimpleFilterPicker.h"

@interface ProductListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SimpleFilterPickerDelegate>

@property (nonatomic, strong) NSMutableArray* products;
@property (nonatomic, strong) NSString* category;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SimpleFilterPicker *levelFilterView;
@property (weak, nonatomic) IBOutlet SimpleFilterPicker *sortFilterView;
@property (weak, nonatomic) IBOutlet UIView *grayView;

/*!
 *@discussion 打开或关闭filter
 */
- (IBAction)clickLevelFilter:(id)sender;
/*!
 *@discussion 打开或关闭filter
 */
- (IBAction)clickSortFilter:(id)sender;
/*!
 *@discussion 点击灰色view将关闭所有filter
 */
- (IBAction)hideAllFilter:(UITapGestureRecognizer*)recognizer;

@end
