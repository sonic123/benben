//
//  SLDetailViewNavigatorCell.m
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLDetailViewNavigatorCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLDetailViewNavigatorCell
@synthesize busBtn;
@synthesize navigatorBtn;
@synthesize dataModel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.busBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.busBtn setTitle:@"公共交通" forState:UIControlStateNormal];
        [self.busBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.busBtn.titleLabel.font=[UIFont fontWithName:@"Avenir-Light" size:14.0f];
        [self.busBtn addTarget:self action:@selector(actBusSearch:) forControlEvents:UIControlEventTouchUpInside];
        self.busBtn.frame=CGRectMake(35, 7, 100, 30);
        self.busBtn.layer.cornerRadius=5.0f;
        self.busBtn.layer.masksToBounds=YES;
        self.busBtn.backgroundColor=[UIColor colorWithRed:265/255.0 green:117/255.0 blue:147/255.0 alpha:1];
        [self.contentView addSubview:self.busBtn];
        
        self.navigatorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.navigatorBtn setTitle:@"路径导航" forState:UIControlStateNormal];
        [self.navigatorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.navigatorBtn.titleLabel.font=[UIFont fontWithName:@"Avenir-Light" size:14.0f];
        [self.navigatorBtn addTarget:self action:@selector(actNavigator:) forControlEvents:UIControlEventTouchUpInside];
        self.navigatorBtn.frame=CGRectMake(181, 7, 100, 30);
        self.navigatorBtn.layer.cornerRadius=5.0f;
        self.navigatorBtn.layer.masksToBounds=YES;
        self.navigatorBtn.backgroundColor=[UIColor colorWithRed:265/255.0 green:117/255.0 blue:147/255.0 alpha:1];
        [self.contentView addSubview:self.navigatorBtn];
        
        UIView *selectedView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        selectedView.backgroundColor=[UIColor clearColor];
        self.selectedBackgroundView=selectedView;
    }
    return self;
}
-(IBAction)actBusSearch:(id)sender{
    [self.delegate startBusSearch];
}
-(IBAction)actNavigator:(id)sender{
    [self.delegate startNavigating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
