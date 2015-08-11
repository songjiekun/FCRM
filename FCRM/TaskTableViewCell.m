//
//  TaskTableViewCell.m
//  FCRM
//
//  Created by song jiekun on 15/8/6.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "ControlVariables.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.leftUtilityButtons = [self leftButtons];
    self.rightUtilityButtons = [self rightButtons];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:kHighColor  title:@"删除"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:kLowColor icon:[UIImage imageNamed:@"checkmark"]];
    
    return leftUtilityButtons;
}

@end
