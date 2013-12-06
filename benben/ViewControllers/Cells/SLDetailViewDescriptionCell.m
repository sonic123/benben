//
//  SLDetailViewDescriptionCell.m
//  benben
//
//  Created by Sonic Lin on 12/6/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLDetailViewDescriptionCell.h"

@implementation SLDetailViewDescriptionCell
@synthesize description;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.description=[[UILabel alloc]initWithFrame:CGRectZero];
        self.description.backgroundColor=[UIColor clearColor];
        self.description.numberOfLines=0;
        self.description.lineBreakMode=NSLineBreakByWordWrapping;
        self.description.font=[UIFont fontWithName:@"Avenir-Light" size:14.0f];
        [self.contentView addSubview:self.description];
    }
    return self;
}

-(CGRect )getCellRect{
    CGSize descSize=[self.detailTextLabel.text sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:14.0f] constrainedToSize:CGSizeMake(300, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    self.description.frame=CGRectMake(10, 5, descSize.width, descSize.height);
    CGRect rect=CGRectMake(0, 0, 320, descSize.height+20);
    return rect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
