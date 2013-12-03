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

@interface SLDetailViewController : SLRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) SLMerchantsDM *dataModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
