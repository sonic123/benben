//
//  SLMerchantCell.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLMerchantCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLMerchantCell
@synthesize merchantCate;
@synthesize merchantAvator;
@synthesize merchantCost;
@synthesize merchantName;
@synthesize merchantDistance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.merchantAvator=[[UIImageView alloc]initWithFrame:CGRectMake(8, 3, 80, 70)];
        self.merchantAvator.contentMode=UIViewContentModeScaleToFill;
        self.merchantAvator.backgroundColor=[UIColor clearColor];
        self.merchantAvator.layer.cornerRadius=5.0f;
        self.merchantAvator.layer.masksToBounds=YES;
        [self.contentView addSubview:self.merchantAvator];
        
        self.merchantName=[[UILabel alloc]initWithFrame:CGRectMake(96, 3, 218, 21)];
        self.merchantName.backgroundColor=[UIColor clearColor];
        self.merchantName.font=[UIFont fontWithName:@"Avenir-Light" size:15];
        [self.contentView addSubview:self.merchantName];
        
        self.merchantCost=[[UILabel alloc]initWithFrame:CGRectMake(221, 20, 93, 21)];
        self.merchantCost.backgroundColor=[UIColor clearColor];
        self.merchantCost.text=@"人均:";
        self.merchantCost.font=[UIFont fontWithName:@"Avenir-Light" size:15];
        [self.contentView addSubview:self.merchantCost];
        
        self.merchantCate=[[UILabel alloc]initWithFrame:CGRectMake(96, 52, 218, 21)];
        self.merchantCate.backgroundColor=[UIColor clearColor];
        self.merchantCate.font=[UIFont fontWithName:@"Avenir-Light" size:15];
        [self.contentView addSubview:self.merchantCate];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
