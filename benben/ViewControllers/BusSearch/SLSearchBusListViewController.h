//
//  SLSearchBusListViewController.h
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AibangApi.h"
#import "SLRootViewController.h"
#import "SLBusSearchHeaderView.h"

@interface SLSearchBusListViewController : SLRootViewController<UITableViewDataSource,UITableViewDelegate>{
    AibangApi *_aiBang;
}
@property (strong, nonatomic) NSMutableArray *busArray;
@property (strong, nonatomic) IBOutlet UITableView *busTable;
@property (strong, nonatomic) SLBusSearchHeaderView *headerView;
@property (strong, nonatomic) NSIndexPath *currentStretchIndexPath;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@end
