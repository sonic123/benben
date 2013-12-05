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
        self.merchantAvator=[[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 80, 60)];
        self.merchantAvator.contentMode=UIViewContentModeScaleToFill;
        self.merchantAvator.backgroundColor=[UIColor clearColor];
        self.merchantAvator.layer.cornerRadius=5.0f;
        self.merchantAvator.layer.masksToBounds=YES;
        [self.contentView addSubview:self.merchantAvator];
        
        self.merchantName=[[UILabel alloc]initWithFrame:CGRectMake(96, 3, 218, 21)];
        self.merchantName.backgroundColor=[UIColor clearColor];
        self.merchantName.font=[UIFont fontWithName:@"Avenir-Light" size:15];
        [self.contentView addSubview:self.merchantName];
        
        self.merchantCost=[[UILabel alloc]initWithFrame:CGRectMake(240, 28, 100, 21)];
        self.merchantCost.backgroundColor=[UIColor clearColor];
        self.merchantCost.text=@"人均:";
        self.merchantCost.font=[UIFont fontWithName:@"Avenir-Light" size:14];
        [self.contentView addSubview:self.merchantCost];
        
        self.merchantCate=[[UILabel alloc]initWithFrame:CGRectMake(96, 52, 218, 21)];
        self.merchantCate.backgroundColor=[UIColor clearColor];
        self.merchantCate.font=[UIFont fontWithName:@"Avenir-Light" size:15];
        [self.contentView addSubview:self.merchantCate];
        
        self.rateImageView1=[[UIImageView alloc]initWithFrame:CGRectMake(96, 28, 19, 19)];
        self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
        [self.contentView addSubview:self.rateImageView1];
        
        self.rateImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(115, 28, 19, 19)];
        self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
        [self.contentView addSubview:self.rateImageView2];
        
        self.rateImageView3=[[UIImageView alloc]initWithFrame:CGRectMake(134, 28, 19, 19)];
        self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
        [self.contentView addSubview:self.rateImageView3];
        
        self.rateImageView4=[[UIImageView alloc]initWithFrame:CGRectMake(153, 28, 19, 19)];
        self.rateImageView4.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
        [self.contentView addSubview:self.rateImageView4];
        
        self.rateImageView5=[[UIImageView alloc]initWithFrame:CGRectMake(172, 28, 19, 19)];
        self.rateImageView5.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
        [self.contentView addSubview:self.rateImageView5];
    }
    return self;
}
-(void)showRateScore:(NSInteger)score withHalf:(BOOL) hasHalf{
    switch (score) {
        case 1:
            if (hasHalf) {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_half"];
            } else {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            }
            break;
        case 2:
            if (hasHalf) {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_half"];
            } else {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            }
            break;
        case 3:
            if (hasHalf) {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView4.image=[UIImage imageNamed:@"icon_rating_star_half"];
            } else {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            }
            break;
        case 4:
            if (hasHalf) {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView4.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView5.image=[UIImage imageNamed:@"icon_rating_star_half"];
            } else {
                self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_picked"];
                self.rateImageView4.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            }
            break;
        case 5:
            self.rateImageView1.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            self.rateImageView2.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            self.rateImageView3.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            self.rateImageView4.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            self.rateImageView5.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            break;
            
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
