//
//  SLDetailViewDescriptionCell.h
//  benben
//
//  Created by Sonic Lin on 12/6/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDetailViewDescriptionCell : UITableViewCell
@property (strong, nonatomic) UILabel *description;

-(CGRect )getCellRect;

@end
