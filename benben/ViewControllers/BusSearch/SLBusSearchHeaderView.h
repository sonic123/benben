//
//  SLBusSearchHeaderView.h
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBusSearchHeaderView : UITableViewHeaderFooterView
@property (strong, nonatomic) UILabel *lineNum;
//@property (strong, nonatomic) UILabel *dist;
//@property (strong, nonatomic) UILabel *foot_dist;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIButton *showDetailBtn;
@property (strong, nonatomic) UILabel *lineName;

@end
