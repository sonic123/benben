//
//  SLHomePageCell.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLHomePageCell.h"

@implementation SLHomePageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.buttonImg=[[UIImageView alloc]initWithFrame:CGRectMake(27, 0, 46, 46)];
        self.buttonImg.backgroundColor=[UIColor clearColor];
        self.buttonImg.contentMode=UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.buttonImg];
        
        self.butomLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 46, 80, 14)];
        self.butomLbl.backgroundColor=[UIColor clearColor];
        self.butomLbl.textColor=[UIColor lightGrayColor];
        self.butomLbl.font=[UIFont fontWithName:@"Avenir-Light" size:14];
        self.butomLbl.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.butomLbl];
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
