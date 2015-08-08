//
//  CreateClientTableViewController.m
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "CreateClientTableViewController.h"
#import "ClientMore.h"
#import "MBProgressHUD.h"
#import "ViewHelper.h"

@interface CreateClientTableViewController ()

@end

@implementation CreateClientTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        
        //初始化 managedObjectContext
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext=app.managedObjectContext;

        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - target action回调方法
/*!
 *@discussion submit成功 显示成功信息
 */
-(void)submitSuccessfully{
    
    [ViewHelper completeTask:self];
     
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 5;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePhoto:(id)sender{
    
    //ios 8下  使用UIAlertController
    if ([UIAlertController class])
    {
        //使用UIAlertController
        UIAlertController *actionSheet= [UIAlertController alertControllerWithTitle:@"图片" message:@"选择来源" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
            [ViewHelper popoutImageLibraryController:self];
            
         }];
        
        UIAlertAction* camera = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
            [ViewHelper popoutCameraController:self];
            
        }];
        
        //取消按钮
        UIAlertAction* cancel= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
        
        }];
        
        //添加三个按钮
        [actionSheet addAction:album];
        [actionSheet addAction:camera];
        [actionSheet addAction:cancel];
        
        //弹出 UIAlertController
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
    else
    {
        //<ios8
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"分享图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机",nil];
        
        [actionSheet showInView:self.view];
        
        
        
    }

    
}

#pragma mark - actionsheet 代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        [ViewHelper popoutImageLibraryController:self];
        
    }
    else if (buttonIndex==1) {
        
        [ViewHelper popoutCameraController:self];
        
    }
    
    
    
}

#pragma mark - imagePicker 代理
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        
        UIImage *pickedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        [self.profileButton setBackgroundImage:pickedImage forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    else{
        
        UIImage *pickedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        //拍的照片存入相册中
        UIImageWriteToSavedPhotosAlbum (pickedImage, nil, nil , nil);
        [self.profileButton setBackgroundImage:pickedImage forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)submit:(id)sender{
    
    NSString *clientName=self.clientNameTextField.text;
    NSString *clientTel=self.clientTelTextField.text;
    NSNumber *clientIncome=@([self.clientIncomeTextField.text integerValue]);
    NSNumber *clientAge=@([self.clientAgeTextField.text integerValue]);
    NSNumber *clientRisk=@([self.clientRiskTextField.text integerValue]);
    
    //新client发送到服务器 并保存如coredata中
    [ClientMore submitClientWithClientName:clientName clientRisk:clientRisk clientIncome:clientIncome clientAge:clientAge clientTel:clientTel profileImage:self.profileButton.currentBackgroundImage context:self.managedObjectContext withTarget:self action:@selector(submitSuccessfully)];
    
    //显示 处理中提示
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"服务器处理中";
    
    
}




@end
