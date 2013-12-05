//
//  SLDetailViewNavigatorCell.h
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMerchantsDM.h"

@protocol SLNavigatorDelegate;
@interface SLDetailViewNavigatorCell : UITableViewCell

@property (strong, nonatomic) id<SLNavigatorDelegate> delegate;
@property (strong, nonatomic) SLMerchantsDM *dataModel;
@property (strong, nonatomic) IBOutlet UIButton *busBtn;
@property (strong, nonatomic) IBOutlet UIButton *navigatorBtn;

@end

@protocol SLNavigatorDelegate <NSObject>

@optional
-(void)startBusSearch;
-(void)startNavigating;

@end
