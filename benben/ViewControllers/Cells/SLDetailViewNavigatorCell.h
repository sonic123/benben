//
//  SLDetailViewNavigatorCell.h
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMerchantsDM.h"

@interface SLDetailViewNavigatorCell : UITableViewCell

@property (strong, nonatomic) SLMerchantsDM *dataModel;
@property (strong, nonatomic) IBOutlet UIButton *busBtn;
@property (strong, nonatomic) IBOutlet UIButton *navigatorBtn;

@end
