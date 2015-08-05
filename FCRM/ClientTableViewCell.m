//
//  ClientTableViewCell.m
//  FCRM
//
//  Created by song jiekun on 15/8/4.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ClientTableViewCell.h"

@implementation ClientTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backView.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    self.backView.layer.borderWidth=1;
    self.backView.layer.cornerRadius=5;
    self.backView.clipsToBounds=TRUE;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //图片圆边 此时frame已近全部计算出
    self.clientProfileImageView.layer.masksToBounds=YES;
    self.clientProfileImageView.layer.borderWidth=2;
    self.clientProfileImageView.layer.cornerRadius=self.clientProfileImageView.frame.size.height/2;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
