//
//  ViewController.m
//  FCRM
//
//  Created by song jiekun on 15/7/22.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ViewController.h"
#import "ProductCategoriesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToProductList:(id)sender {
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ProductList" bundle:nil];
    
    UINavigationController *productListNavigationController=[storyboard instantiateViewControllerWithIdentifier:@"ProductListNavigationController"];
    
    ProductCategoriesViewController *productCategoriesViewController=((ProductCategoriesViewController *)[productListNavigationController.viewControllers objectAtIndex:0]);
    
   
    //[self presentViewController:productCategoriesViewController animated:YES completion:nil];
    [self addChildViewController:productListNavigationController];
    [self.view addSubview:productListNavigationController.view];
    [productListNavigationController didMoveToParentViewController:self];
    
}
@end
