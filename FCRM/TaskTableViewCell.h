//
//  TaskTableViewCell.h
//  FCRM
//
//  Created by song jiekun on 15/8/6.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell.h>

@interface TaskTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskExpiryDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *taskLevelImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
