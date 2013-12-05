//
//  SLBusSearchHeaderView.m
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLBusSearchHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLBusSearchHeaderView
@synthesize lineNum;
//@synthesize dist;
//@synthesize foot_dist;
@synthesize time;
@synthesize showDetailBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //line num
        self.lineNum=[[UILabel alloc]initWithFrame:CGRectMake(4, 10, 20, 20)];
        self.lineNum.textColor=[UIColor whiteColor];
        self.lineNum.backgroundColor=[UIColor colorWithRed:101/255.0f green:150/255.0f blue:148/255.0f alpha:1];
        self.lineNum.text=@"";
        self.lineNum.textAlignment=NSTextAlignmentCenter;
        self.lineNum.layer.cornerRadius=10.0;
        self.lineNum.layer.masksToBounds=YES;
        [self.contentView addSubview:self.lineNum];
        //time
        self.time=[[UILabel alloc]initWithFrame:CGRectMake(255, 10, 80, 30)];
        self.time.textColor=[UIColor blackColor];
        self.time.backgroundColor=[UIColor clearColor];
        self.time.text=@"约:";
        self.time.font=[UIFont fontWithName:@"Avenir-Light" size:14];
        self.time.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.time];
        //line name
        self.lineName=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 230, 30)];
        self.lineName.textColor=[UIColor blackColor];
        self.lineName.backgroundColor=[UIColor clearColor];
        self.lineName.text=@"";
        self.lineName.font=[UIFont fontWithName:@"Avenir-Light" size:15];
        self.lineName.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.lineName];
        
        self.showDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.showDetailBtn.titleLabel.text=@"";
        self.showDetailBtn.frame=CGRectMake(0, 0, 320, 500);
        [self.contentView addSubview:self.showDetailBtn];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
