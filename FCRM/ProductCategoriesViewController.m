//
//  ProductCategoriesViewController.m
//  FCRM
//
//  Created by song jiekun on 15/7/29.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductCategoriesViewController.h"
#import "ProductListViewController.h"

@interface ProductCategoriesViewController ()

@end

@implementation ProductCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ProductListViewController *destinationVC=segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"BondListSegue"]) {
        
        //传递数据
        destinationVC.category=@"债券型基金";
        
    }
    
    if ([[segue identifier] isEqualToString:@"StockListSegue"]) {
        
        //传递数据
        destinationVC.category=@"股票型基金";
        
    }
    
    if ([[segue identifier] isEqualToString:@"CashListSegue"]) {
        
        //传递数据
        destinationVC.category=@"货币型基金";
        
    }
    
    if ([[segue identifier] isEqualToString:@"HedgeListSegue"]) {
        
        //传递数据
        destinationVC.category=@"对冲型基金";
        
    }
    
    if ([[segue identifier] isEqualToString:@"InsuranceListSegue"]) {
        
        //传递数据
        destinationVC.category=@"保险型理财";
        
    }
    
    if ([[segue identifier] isEqualToString:@"P2PListSegue"]) {
        
        //传递数据
        destinationVC.category=@"P2P型理财";
        
    }
    
    
}


@end
