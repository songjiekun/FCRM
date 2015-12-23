//
//  MyInputView.m
//  FCRM
//
//  Created by song jiekun on 15/12/23.
//  Copyright © 2015年 song jiekun. All rights reserved.
//

#import "MyInputView.h"

@implementation MyInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        //获取nib中的view
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MyInputView" owner:self options:nil];
        
        UIView *nibView= views[0];
        
        [self addSubview:nibView];
        
        //设置autolayout
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        /*
        //设置外部view高度宽度
        CGFloat screenWidth=[[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight=[[UIScreen mainScreen] bounds].size.height;
        
        self.viewHeight=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:screenHeight/3];
        
        self.viewWidth=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:screenWidth];
        
        [self addConstraint:self.viewHeight];
        [self addConstraint:self.viewWidth];
         */
        
        
    }
    
    return self;
    
}


//让interface builder来调用的
- (id)initWithFrame:(CGRect)frame{
    
    if((self=[super initWithFrame:frame])){
        
        
        NSArray *views = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"MyInputView" owner:self options:nil];
        
        UIView *nibView= views[0];
        
        [self addSubview:nibView];
        
        //设置autolayout
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        

        
    }
    
    return self;
    
}

-(void)updateConstraints{
    
    [super updateConstraints];
    
    //设置外部view高度宽度
    CGFloat screenWidth=[[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight=[[UIScreen mainScreen] bounds].size.height;
    
    self.viewHeight.constant = screenHeight/3;
    
    self.viewWidth.constant = screenWidth;

    
}

/*!
 *@discussion 点击数字
 */
- (IBAction)clickNumber:(id)sender{
    
    NSInteger number=((UIButton*)sender).tag;
    
    [self.delegate clickNumber:number];
    
}

/*!
 *@discussion 点击后退
 */
- (IBAction)clickDelete:(id)sender{
    
    [self.delegate clickDelete];
    
}

/*!
 *@discussion 点击退出
 */
- (IBAction)clickClose:(id)sender{
    
    [self.delegate clickClose];
    
}


@end
