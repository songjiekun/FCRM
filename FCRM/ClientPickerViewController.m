//
//  ClientPickerViewController.m
//  FCRM
//
//  Created by song jiekun on 15/8/8.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ClientPickerViewController.h"
#import "ClientTableViewCell.h"
#import "ViewHelper.h"
#import "MBProgressHUD.h"

@interface ClientListViewController ()

@end

@implementation ClientPickerViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        self.isXLForm=YES;
        
    }
    
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if((self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        
        self.isXLForm=YES;
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    //对齐上线
    self.searchBarLayoutConstraint.constant=[self.topLayoutGuide length];
    
}

#pragma mark - target action回调方法
/*!
 *@discussion submit成功 显示成功信息
 */
-(void)recommendedSuccessfully{
    
    [ViewHelper completeTask:self];
    
    
}

#pragma mark 重写tableview 的select代理
//通过xib来定义的cell 必须通过didSelectRowAtIndexPath来触发segue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据普通tableview 还是search tableview来获取fetchedResultsController
    NSFetchedResultsController *frc= [self fetchedResultsControllerForTableView:tableView];
    self.selectedClient = [frc objectAtIndexPath:indexPath];
    
    if (!self.isXLForm) {
        
        //选择client，给client推荐product
        //ios 8下  使用UIAlertController
        if ([UIAlertController class])
        {
            //使用UIAlertController
            UIAlertController *actionSheet= [UIAlertController alertControllerWithTitle:@"推荐" message:[NSString stringWithFormat:@"推荐产品 %@ 给用户%@",self.product.productName,self.selectedClient.clientName] preferredStyle:UIAlertControllerStyleAlert];
            
            //确认按钮
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                //向服务器添加recommendation
                [self.selectedClient recommendedWithProduct:self.product withTarget:self action:@selector(recommendedSuccessfully)];
                
                //显示 处理中提示
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.labelText=@"服务器处理中";
                
            }];
            
            
            //取消按钮
            UIAlertAction* cancel= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                [actionSheet dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            //添加按钮
            [actionSheet addAction:yes];
            [actionSheet addAction:cancel];
            
            //弹出 UIAlertController
            [self presentViewController:actionSheet animated:YES completion:nil];
            
        }
        else
        {
            //<ios8
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"推荐" message:[NSString stringWithFormat:@"推荐产品 %@ 给用户%@",self.product.productName,self.selectedClient.clientName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];
            
            [alertView show];
            
            
        }
        
    }else{
        
        //XLForm
        self.rowDescriptor.value=self.selectedClient;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

#pragma mark - alertview 代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        //向服务器添加recommendation
        [self.selectedClient recommendedWithProduct:self.product withTarget:self action:@selector(recommendedSuccessfully)];
        
        //显示 处理中提示
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"服务器处理中";
        
    }
    if (buttonIndex==1) {
        
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
    }
    
}


@end
