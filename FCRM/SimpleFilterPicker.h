//
//  SimpleFilterPicker.h
//  FCRM
//
//  Created by song jiekun on 15/7/30.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimpleFilterPickerDelegate <NSObject>

//将选择的项目传递给代理
-(void)selectRowAtIndexPath:(NSIndexPath *)indexPath sender:(id)sender;

@end

IB_DESIGNABLE

@interface SimpleFilterPicker : UIView <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@property (strong, nonatomic) NSMutableArray *filterArray;

/*!
 *@discussion 用来设置filter的高度
 */
@property (strong, nonatomic) NSLayoutConstraint *viewHeight;
/*!
 *@discussion 用来记录filter的高度
 */
@property (nonatomic) NSInteger height;

@property (nonatomic,weak) id <SimpleFilterPickerDelegate> delegate;

/*!
 *@discussion 关闭filter
 */
- (void)toggleOffView;
/*!
 *@discussion 打开filter
 */
- (void)toggleOnView;
/*!
 *@discussion 根据现在的view高度状态 开或者关filter
 *@param grayView 背景灰色view
 */
- (void)switchView:(UIView*)grayView;
/*!
 *@discussion 没有动画 直接关闭filter
 */
- (void)hideView;

@end
