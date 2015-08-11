//
//  CreateTaskViewController.m
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "XLForm.h"
#import "ViewHelper.h"
#import "TaskMore.h"
#import "MBProgressHUD.h"
#import "ControlVariables.h"

//row对应的tag  用来定位
NSString *const kTaskName = @"name";
NSString *const kTaskDetail = @"detail";
NSString *const kClientName = @"clientName";
NSString *const kClientTel = @"clientTel";
NSString *const kTaskExpiryDate = @"expiryDate";
NSString *const kTaskLevel = @"level";
NSString *const kTaskStatus = @"status";


#pragma mark - ClientTransformer用来转换value和selector上显示的数据
@interface ClientTransformer : NSValueTransformer
@end

@implementation ClientTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if (!value) return nil;
    ClientMore *client = (ClientMore *) value;
    return client.clientName;
}

@end


@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"创建任务"];
        self.form=formDescriptor;
        
        //初始化 managedObjectContext
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext=app.managedObjectContext;
        
    }
    
    return self;
    
}

#pragma mark - 初始化form
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XLFormDescriptor * formDescriptor = self.form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    //formDescriptor.assignFirstResponderOnShow = YES;
    
    // 基本信息section
    section = [XLFormSectionDescriptor formSection];
    //section.footerTitle = @"This is a long text that will appear on section footer";
    [formDescriptor addFormSection:section];
    
    // 任务名字
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTaskName rowType:XLFormRowDescriptorTypeText title:@"任务标题"];
    row.required = YES;
    [row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    [section addFormRow:row];
    
    // 任务详情
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTaskDetail rowType:XLFormRowDescriptorTypeTextView title:@"任务详情"];
    [row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    [section addFormRow:row];
    
    // 任务处理时间
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTaskExpiryDate rowType:XLFormRowDescriptorTypeDate title:@"处理日期"];
    [row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    row.required=YES;
    [section addFormRow:row];
    
    
    // 其他信息section
    section = [XLFormSectionDescriptor formSection];
    //section.footerTitle = @"This is a long text that will appear on section footer";
    [formDescriptor addFormSection:section];
    
    // 任务类型
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTaskLevel rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"任务类型"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"普通任务"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"重要任务"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"普通任务"];
    row.required=YES;
    [row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    [section addFormRow:row];
    
    // 任务对应client名字
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kClientName rowType:XLFormRowDescriptorTypeSelectorPush title:@"选择客户"];
    row.action.viewControllerNibName=@"ClientPickerViewController";
    row.valueTransformer = [ClientTransformer class];
    [row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    [section addFormRow:row];
    
    // 任务对应client 电话号码
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kClientTel rowType:XLFormRowDescriptorTypeText title:@"客户电话"];
    row.disabled=@YES;
    //[row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    [section addFormRow:row];
    
    // 任务状态
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTaskStatus rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"任务状态"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"进行中"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"已完成"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"进行中"];
    row.hidden=@YES;
    row.required=YES;
    [row.cellConfig setObject:kMainColor forKey:@"textLabel.textColor"];
    [section addFormRow:row];
    
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
    
    [ViewHelper completeLoading:self withText:@"创建成功"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 重写formRowDescriptor 代理
-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
    // super implmentation MUST be called
    [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    
    /*案例代码
    if ([rowDescriptor.tag isEqualToString:kClientName]){
        if ([[rowDescriptor.value valueData] isEqualToNumber:@(0)] == NO && [[oldValue valueData] isEqualToNumber:@(0)]){
            XLFormRowDescriptor * newRow = [rowDescriptor copy];
            [newRow setTag:@"secondAlert"];
            newRow.title = @"Second Alert";
            [self.form addFormRow:newRow afterRow:rowDescriptor];
        }
        else if ([[oldValue valueData] isEqualToNumber:@(0)] == NO && [[newValue valueData] isEqualToNumber:@(0)]){
            [self.form removeFormRowWithTag:@"secondAlert"];
        }
    }
     */
    
    //用户名发生变化
    if ([rowDescriptor.tag isEqualToString:kClientName]){
        
        XLFormRowDescriptor *clientTelRow=[self.form formRowWithTag:kClientTel];
        clientTelRow.value=((ClientMore*)rowDescriptor.value).clientTel;
        //新数据 需要reload
        [self reloadFormRow:clientTelRow];
    }
    
    
}


#pragma mark - click action方法
- (IBAction)submit:(id)sender{
    
    NSString *taskName=[self.formValues valueForKey:kTaskName];
    NSString *taskDetail=[self.formValues valueForKey:kTaskDetail];
    ClientMore *client=[self.formValues valueForKey:kClientName];
    NSNumber *taskLevel=[(XLFormOptionsObject*)[self.formValues valueForKey:kTaskLevel] valueData];
    NSNumber *taskStatus=@(1);
    NSDate *taskExpiryDate=[self.formValues valueForKey:kTaskExpiryDate];
    
    //新task发送到服务器 并保存如coredata中
    [TaskMore submitTaskWithTaskName:taskName taskDetail:taskDetail taskLevel:taskLevel taskStatus:taskStatus taskExpiryDate:taskExpiryDate client:client context:self.managedObjectContext withTarget:self action:@selector(submitSuccessfully)];
    
    //显示 处理中提示
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"服务器处理中";
    
    
}

@end
