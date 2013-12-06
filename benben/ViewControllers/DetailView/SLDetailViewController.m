//
//  SLDetailViewController.m
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLDetailViewController.h"
#import "SLDetailViewMapCell.h"
#import "SLDetailViewNavigatorCell.h"
#import "SLDetailViewDescriptionCell.h"
#import "SLSearchBusListViewController.h"


static NSString *detailViewMapCellID = @"SLDetailViewMapCell";
static NSString *detailViewNavigatorCellID = @"SLDetailViewNavigatorCell";
static NSString *detailViewDescriptionCellID = @"LDetailViewDescriptionCell";

@interface SLDetailViewController ()

@end

@implementation SLDetailViewController
@synthesize tableView;
@synthesize dataModel;
@synthesize busListController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerClass:[SLDetailViewMapCell class] forCellReuseIdentifier:detailViewMapCellID];
    [self.tableView registerClass:[SLDetailViewNavigatorCell class] forCellReuseIdentifier:detailViewNavigatorCellID];
    [self.tableView registerClass:[SLDetailViewDescriptionCell class] forCellReuseIdentifier:detailViewDescriptionCellID];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *titleLabel=nil;
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=[NSString stringWithFormat:@"%@",self.dataModel.name];
    titleLabel.font=[UIFont fontWithName:@"Avenir-Light" size:20];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLabel;
    if (self.navigationController.isNavigationBarHidden ) {
        [self.navigationController setNavigationBarHidden:NO];
    }
  
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.dataModel) {
        [self.tableView reloadData];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITabLeViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataModel) {
        return 3;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 133;
            break;
        case 1:
            return 44;
            break;
        case 2:{
            SLDetailViewDescriptionCell *cell=(SLDetailViewDescriptionCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
            NSLog(@"hight:%f",cell.frame.size.height);
            return cell.frame.size.height;
        }
            break;
        default:
            return 0;
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            SLDetailViewMapCell *cell=[self.tableView dequeueReusableCellWithIdentifier:detailViewMapCellID];
            if (!cell) {
                cell=[[SLDetailViewMapCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:detailViewMapCellID];
            }
            cell.dataModel=self.dataModel;
            cell.backgroundColor=[UIColor clearColor];
            [cell retrieveCoordinate];
            return cell;
        }
            break;
        case 1:
        {
            SLDetailViewNavigatorCell *cell=[self.tableView dequeueReusableCellWithIdentifier:detailViewNavigatorCellID];
            if (!cell) {
                cell=[[SLDetailViewNavigatorCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:detailViewNavigatorCellID];
               
                
            }
            cell.delegate=self;
            cell.dataModel=self.dataModel;
            cell.backgroundColor=[UIColor clearColor];

            return cell;
        }
            break;
        case 2:
        {
            SLDetailViewDescriptionCell *cell=[self.tableView dequeueReusableCellWithIdentifier:detailViewDescriptionCellID];
            if (!cell) {
                cell=[[SLDetailViewDescriptionCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:detailViewDescriptionCellID];
            }
            cell.description.text=[NSString stringWithFormat:@"简介：\n\t%@\n\n地址：\n\t%@\n电话：\n\t%@",self.dataModel.desc,self.dataModel.addr,self.dataModel.tel];
            CGSize descSize=[cell.description.text sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:14.0f] constrainedToSize:CGSizeMake(280, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
            cell.description.frame=CGRectMake(20, 10, descSize.width, descSize.height);
            cell.frame=CGRectMake(0, 0, 320, descSize.height+20);
            cell.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default:{
            UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"testCell"];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
            }
            return cell;
        }
            break;
    }
    
}
#pragma mark -
#pragma mark UITabLeViewDelegate

#pragma mark -
#pragma mark SLNavigatorDelegate
-(void)startBusSearch{
    if (!self.busListController) {
        self.busListController=[[SLSearchBusListViewController alloc]initWithNibName:@"SLSearchBusListViewController" bundle:nil];;
    }
    self.busListController.lat=self.dataModel.lat;
    self.busListController.lng=self.dataModel.lng;
    [self.navigationController pushViewController:self.busListController animated:YES];
}
-(void)startNavigating{
    if (!self.navigatorController) {
        self.navigatorController=[[SLNavigatorViewController alloc]initWithNibName:@"SLNavigatorViewController" bundle:nil];
    }
    self.navigatorController.dateModel=self.dataModel;
    [self.navigationController pushViewController:self.navigatorController animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
}

@end
