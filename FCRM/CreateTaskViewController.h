//
//  CreateTaskViewController.h
//  FCRM
//
//  Created by song jiekun on 15/8/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "XLFormViewController.h"
#import "ClientMore.h"

@interface CreateTaskViewController : XLFormViewController

//core data相关
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/*!
 *@discussion 向服务器发送新task
 */
- (IBAction)submit:(id)sender;

@end
