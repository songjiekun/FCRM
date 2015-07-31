//
//  ProductDetailViewController.m
//  FCRM
//
//  Created by song jiekun on 15/7/31.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        self.imageCache=[[NSCache alloc] init];
        
        self.ioQueue=[[NSOperationQueue alloc] init];
        self.ioQueue.maxConcurrentOperationCount=40;
        
        self.internetQueue=[[NSOperationQueue alloc] init];
        self.internetQueue.maxConcurrentOperationCount=10;
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //为页面填充数据
    
    self.categoryLabel.text=[NSString stringWithFormat:@"类型:%@",self.product.productCategory];
    self.yieldRateLabel.text=[NSString stringWithFormat:@"%@%%",self.product.productYieldRate];
    self.productNameLabel.text=self.product.productName;
    self.periodLabel.text=[NSString stringWithFormat:@"认购期限:%@",self.product.productPeriod];
    self.minAmount.text=[NSString stringWithFormat:@"起购额:%@万",self.product.productMinAmount];
    self.investorRateLabel.text=[NSString stringWithFormat:@"用户评分:%@分",self.product.userScore];
    self.managerNameLabel.text=[NSString stringWithFormat:@"管理人:%@",self.product.managerName];
    
    //不同level的product不同的背景图
    switch ([self.product.productLevel integerValue]) {
        case 1:
            self.levelImageView.image=[UIImage imageNamed:@"high"];
            break;
            
        case 2:
            self.levelImageView.image=[UIImage imageNamed:@"middle"];
            break;
            
        case 3:
            self.levelImageView.image=[UIImage imageNamed:@"low"];
            break;
            
        default:
            self.levelImageView.image=[UIImage imageNamed:@"high"];
            break;
    }
    
    //从internet获取图片
    self.product.managerProfileInternetImage.delegate=self;
    self.managerProfileImageView.image=[self.product.managerProfileInternetImage retrieveImage:self.managerProfileImageView fromCache:self.imageCache atIOQueue:self.ioQueue atInternetQueue:self.internetQueue];
}

//此时frame已近全部计算出
- (void)viewDidLayoutSubviews{
    
    //图片圆边 此时frame已近全部计算出
    self.managerProfileImageView.layer.masksToBounds=YES;
    self.managerProfileImageView.layer.borderWidth=2;
    self.managerProfileImageView.layer.borderColor=[UIColor grayColor].CGColor;
    self.managerProfileImageView.layer.cornerRadius=self.managerProfileImageView.frame.size.height/2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - InternetImage 的代理
-(void)refreshImage:(InternetImage *)sender withImage:(UIImage *)newImage{
    
    self.managerProfileImageView.image=newImage;
    
    self.managerProfileImageView.alpha=0;
    
    
    //图片淡入淡出
    [UIView animateWithDuration:0.3 animations:^{
        
        self.managerProfileImageView.alpha=1;
        
    }];
    
}

@end
