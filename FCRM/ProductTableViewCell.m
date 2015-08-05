//
//  ProductTableViewCell.m
//  FCRM
//
//  Created by song jiekun on 15/7/29.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backView.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    self.backView.layer.borderWidth=1;
    self.backView.layer.cornerRadius=5;
    self.backView.clipsToBounds=TRUE;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
