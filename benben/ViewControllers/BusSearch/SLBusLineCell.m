//
//  SLBusLineCell.m
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLBusLineCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLBusLineCell
@synthesize lineView;

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
        
        self.lineView=[[UIImageView alloc]initWithFrame:CGRectZero];
        self.lineView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.lineView];
        
       
        
            }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateStationPoint:(CGRect )frame withTitle:(NSMutableArray *)titleArray{
    self.lineView.frame=CGRectMake(47, 5, 6, frame.size.height-20);
    self.lineView.backgroundColor=[UIColor greenColor];
    self.lineView.layer.cornerRadius=5.0f;
    self.lineView.layer.masksToBounds=YES;
    self.lineView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.lineView.layer.borderWidth=2.0f;
    UIImageView *statImg=nil;
    UILabel *titleLabel=nil;
    float temY;
    if ([titleArray count]>1) {
       temY =(frame.size.height-20)/([titleArray count]-1);
    }else{
       temY =(frame.size.height-20);
    }
    
    for (int i=0; i<[titleArray count]; i++) {
        @autoreleasepool {
            statImg=[[UIImageView alloc]initWithFrame:CGRectMake(42, i*temY, 16, 16)];
            statImg.image=[UIImage imageNamed:@"BusSearchPoint"];

            titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
            titleLabel.text=[titleArray objectAtIndex:i];
            CGSize labelSize=[titleLabel.text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(40, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
            titleLabel.numberOfLines=0;
            titleLabel.font=[UIFont systemFontOfSize:10];
            titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
            if (i==[titleArray count]-1) {
                titleLabel.frame=CGRectMake(CGRectGetMaxX(statImg.frame), CGRectGetMaxY(statImg.frame)-labelSize.height, labelSize.width, labelSize.height);
            }else{
                titleLabel.frame=CGRectMake(CGRectGetMaxX(statImg.frame), CGRectGetMinY(statImg.frame), labelSize.width, labelSize.height);
            }
            
            [self.contentView addSubview:statImg];
            [self.contentView addSubview:titleLabel];
            
        }
    }
}

@end
