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

@property (nonatomic, retain) NSMutableArray* products;
@property (nonatomic, retain) NSString* category;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SimpleFilterPicker *levelFilterView;

- (IBAction)clickLevelFilter:(id)sender;

@end
