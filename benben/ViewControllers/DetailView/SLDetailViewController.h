//
//  SLDetailViewController.h
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLRootViewController.h"
#import "SLMerchantsDM.h"
#import "SLDetailViewNavigatorCell.h"
#import "SLNavigatorViewController.h"
@class SLSearchBusListViewController;

@interface SLDetailViewController : SLRootViewController<UITableViewDataSource,UITableViewDelegate,SLNavigatorDelegate>

@property (strong, nonatomic) SLMerchantsDM *dataModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SLSearchBusListViewController *busListController;
@property (strong, nonatomic) SLNavigatorViewController *navigatorController;

@end
