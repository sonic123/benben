//
//  SLBusLineCell.m
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLBusLineCell.h"

@implementation SLBusLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.lineDesc=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 50)];
        self.lineDesc.text=@"";
        self.lineDesc.backgroundColor=[UIColor clearColor];
        self.lineDesc.textColor=[UIColor blackColor];
        self.lineDesc.font=[UIFont fontWithName:@"Avenir-Light" size:14];
        [self.contentView addSubview:self.lineDesc];
        
            }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
