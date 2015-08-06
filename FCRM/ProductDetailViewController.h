//
//  ProductDetailViewController.h
//  FCRM
//
//  Created by song jiekun on 15/7/31.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductT.h"
#import "InternetImage.h"

@interface ProductDetailViewController : UIViewController<InternetImageDelegate>

@property (nonatomic, strong) ProductT* product;

@property (weak, nonatomic) IBOutlet UILabel *yieldRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *minAmount;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UIImageView *managerProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *managerNameLabel;

@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) NSOperationQueue *ioQueue;
@property (strong, nonatomic) NSOperationQueue *internetQueue;

/*!
 *@discussion 显示推荐客户列表
 */
- (IBAction)recommendToClient:(id)sender;

@end
