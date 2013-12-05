//
//  SLBusLineCell.h
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBusLineCell : UITableViewCell
@property (strong, nonatomic) UILabel *lineDesc;
@property (strong, nonatomic) UIImageView *lineView;

-(void)updateStationPoint:(CGRect )frame withTitle:(NSMutableArray *)titleArray;
@end
