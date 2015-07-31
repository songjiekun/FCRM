//
//  SimpleFilterPicker.m
//  FCRM
//
//  Created by song jiekun on 15/7/30.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "SimpleFilterPicker.h"

@interface SimpleFilterPicker ()



@end

@implementation SimpleFilterPicker

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
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SimpleFilterPicker" owner:self options:nil];
        
        UIView *nibView= views[0];
        
        [self addSubview:nibView];
        
        //设置autolayout
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        
        //设置内部view高度
        //NSLayoutConstraint* height=[NSLayoutConstraint constraintWithItem:nibView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        
        //[self addConstraint:height];
        
        //设置外部view高度
        self.viewHeight=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
        
        [self addConstraint:self.viewHeight];
        
        
    }
    
    return self;
    
}


//让interface builder来调用的
- (id)initWithFrame:(CGRect)frame{
    
    if((self=[super initWithFrame:frame])){
        
        
        NSArray *views = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"SimpleFilterPicker" owner:self options:nil];
        
        UIView *nibView= views[0];
        
        [self addSubview:nibView];
        
        //设置autolayout
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        
        //设置内部view高度
        //NSLayoutConstraint* height=[NSLayoutConstraint constraintWithItem:nibView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        
        //[self addConstraint:height];
        
        //设置外部view高度
        self.viewHeight=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
        
        [self addConstraint:self.viewHeight];
        
        //为了在IB中展现，设置原始数据
        self.filterArray=@[@"足球",@"蓝球",@"足球",@"排球",@"网球",@"羽毛球",@"乒乓球",@"足球",@"蓝球",@"足球"];
        
    }
    
    return self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.filterArray  count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleFilterPickerCellIdentifier=@"SimpleFilterPickerCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleFilterPickerCellIdentifier];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleFilterPickerCellIdentifier];
    }
    
    cell.textLabel.text=self.filterArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate selectRowAtIndexPath:indexPath sender:self];
    
    [self toggleOffView];
    
}

//单行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    
}

- (void)toggleOffView{
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.viewHeight.constant=0;
        
        [self layoutIfNeeded];
        
    }];
    
    
}

- (void)toggleOnView{
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.viewHeight.constant=self.height;
        
        [self layoutIfNeeded];
        
    }];
    
    
}

- (void)switchView:(UIView*)grayView{
    
    if(self.viewHeight.constant==0){
        
        [self toggleOnView];
        
        grayView.hidden=NO;
        
    }
    else if(self.viewHeight.constant==self.height){
        
        [self toggleOffView];
        
        grayView.hidden=YES;
        
    }
    
};

- (void)hideView{
    
    self.viewHeight.constant=0;
    
    [self layoutIfNeeded];
    
}

#pragma mark - setter and getter


@end
