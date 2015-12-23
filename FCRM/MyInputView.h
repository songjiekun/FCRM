//
//  MyInputView.h
//  FCRM
//
//  Created by song jiekun on 15/12/23.
//  Copyright © 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInputView;
@protocol MyInputViewDelegate <NSObject>

//点击数字
-(void)clickNumber:(NSInteger)number;

//点击后退
-(void)clickDelete;

//点击退出
-(void)clickClose;

@end

@interface MyInputView : UIView

@property (strong, nonatomic) NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) NSLayoutConstraint *viewWidth;

@property (nonatomic,weak) id <MyInputViewDelegate> delegate;

/*!
 *@discussion 点击数字
 */
- (IBAction)clickNumber:(id)sender;

/*!
 *@discussion 点击后退
 */
- (IBAction)clickDelete:(id)sender;

/*!
 *@discussion 点击退出
 */
- (IBAction)clickClose:(id)sender;

@end
