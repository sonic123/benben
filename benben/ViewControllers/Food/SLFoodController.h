//
//  SLViewController.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLRootViewController.h"
#import "AibangApi.h"
#import "RNFrostedSidebar.h"

@interface SLFoodController : SLRootViewController<UITableViewDataSource,UITableViewDataSource,RNFrostedSidebarDelegate>{
    AibangApi *_aiBang;
}
@property (strong, nonatomic) NSMutableArray *merchantsArray;

@property (strong, nonatomic) IBOutlet UITableView *mechantTable;
@end
