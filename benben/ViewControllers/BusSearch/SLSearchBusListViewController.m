//
//  SLSearchBusListViewController.m
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLSearchBusListViewController.h"
#import "AibangApi.h"
#import "SLBusLineCell.h"
#import "SLBusSearchHeaderView.h"
#import "SLBusDM.h"


static NSString *BusLineCellCellIdentifier = @"BusLineCellCellIdentifier";
static NSString *BusSearchHeaderViewIdentifier = @"BusSearchHeaderViewIdentifier";

@interface SLSearchBusListViewController ()

@end

@implementation SLSearchBusListViewController
@synthesize lat,lng,busArray,busTable;

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
    if (!_aiBang) {
        _aiBang=[[AibangApi alloc]init];
        _aiBang.delegate=self;
    }
   
    [self.busTable registerClass:[SLBusLineCell class] forCellReuseIdentifier:BusLineCellCellIdentifier];
    [self.busTable registerClass:[SLBusSearchHeaderView class] forHeaderFooterViewReuseIdentifier:BusSearchHeaderViewIdentifier];
    self.busTable.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
self.busArray=[NSMutableArray arrayWithCapacity:0];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [super showHudOnView:self.view withTitle:@"加载中"];
    [self loadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.currentStretchIndexPath=nil;
    self.busArray=nil;
    [super viewWillDisappear:animated];
}
-(void)loadData{
    SLAppDelegate *delegate=[super getApplegate];
    //        [_aiBang busTransferWithCity:@"上海" StartAddr:@"" EndAddr:@"" StartLng:[NSString stringWithFormat:@"%f",delegate.lng] StartLat:[NSString stringWithFormat:@"%f",delegate.lat] EndLng:self.lng EndLat:self.lat Rc:@"0" Count:@"10" Withxys:@"0"];
    [_aiBang busTransferWithCity:@"上海" StartAddr:@"" EndAddr:@"" StartLng:@"121.598105" StartLat:@"31.211067" EndLng:self.lng EndLat:self.lat Rc:@"0" Count:@"10" Withxys:@"0"];
    delegate=nil;
}
#pragma mark -
#pragma mark AibangApiDelegate
-(void) requestDidFinishWithData:(NSData*)data aibangApi:(id)aibangApi{
    if ([SLBusDM parseIntoMerchantstList:self.busArray fromString:data]) {
        [super changeHudToCustomViewMode:@"success" withImage:@"37x-CheckMark.png" hideAfterTimeIntervals:1];
        [self.busTable reloadData];
    }else{
        [super changeHudToCustomViewMode:@"parse fail" withImage:@"37x-CheckMark.png" hideAfterTimeIntervals:1];
    }
}
#pragma mark -
#pragma mark UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger num=0;
    if ([self.busArray count]!=0) {
        num=[self.busArray count];
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headerView=[self.busTable dequeueReusableHeaderFooterViewWithIdentifier:BusSearchHeaderViewIdentifier];
    if (!self.headerView) {
        self.headerView=[[SLBusSearchHeaderView alloc]initWithReuseIdentifier:BusSearchHeaderViewIdentifier];
    }
    SLBusDM *oneBusDM=nil;
    oneBusDM=[self.busArray objectAtIndex:section];
    self.headerView.lineNum.text=[NSString stringWithFormat:@"%d",section+1];
    self.headerView.time.text=[NSString stringWithFormat:@"约:%@分钟",oneBusDM.time];
    NSString *lineName=[[NSString alloc]init];
    for (SLBusSegmentDM *oneBusSegment in oneBusDM.segmentArray) {
        lineName=[lineName stringByAppendingString:oneBusSegment.line_name];
        if ([lineName rangeOfString:@"("].location!=NSNotFound) {
            lineName=[lineName substringToIndex:[lineName rangeOfString:@"("].location];
        }
        lineName=[lineName stringByAppendingString:@"--"];
    }
    
    lineName=[lineName stringByReplacingCharactersInRange:NSMakeRange([lineName length]-2, 2) withString:@"" ];
    self.headerView.lineName.text=lineName;
    lineName=nil;
    self.headerView.showDetailBtn.tag=section;
    
    [self.headerView.showDetailBtn addTarget:self
                           action:@selector(actSectionClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
    return self.headerView;
}
-(IBAction)actSectionClicked:(id)sender{
    UIButton *clickedBUtton=(UIButton *)sender;
    NSIndexPath *newIndexPath;
    SLBusDM *model=nil;
    model=[self.busArray objectAtIndex:clickedBUtton.tag];
    NSInteger num=[model.segmentArray count];
    newIndexPath=[NSIndexPath indexPathForRow:num inSection:clickedBUtton.tag];
    
    
    [self.busTable beginUpdates];
    if (!self.currentStretchIndexPath) {
        self.currentStretchIndexPath=newIndexPath;
        NSMutableArray *insertionArray=[[NSMutableArray alloc]init];
        for (int i=0; i<num; i++) {
            [insertionArray addObject:[NSIndexPath indexPathForRow:i inSection:clickedBUtton.tag]];
        }
        [self.busTable insertRowsAtIndexPaths:insertionArray withRowAnimation:UITableViewRowAnimationTop];
        
    }else{
        model=[self.busArray objectAtIndex:self.currentStretchIndexPath.section];
        NSInteger deletenum=[model.segmentArray count];
        
        NSMutableArray *deleteArray=[[NSMutableArray alloc]init];
        
        for (int i=0; i<deletenum; i++) {
            [deleteArray addObject:[NSIndexPath indexPathForRow:i inSection:self.currentStretchIndexPath.section]];
        }
        [self.busTable deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationTop];
        
        if (self.currentStretchIndexPath.section==newIndexPath.section) {
            self.currentStretchIndexPath=nil;
        }else{
            self.currentStretchIndexPath=newIndexPath;
            SLBusDM *model=nil;
            model=[self.busArray objectAtIndex:clickedBUtton.tag];
            NSInteger num=[model.segmentArray count];
            NSMutableArray *insertionArray=[[NSMutableArray alloc]init];
            for (int i=0; i<num; i++) {
                [insertionArray addObject:[NSIndexPath indexPathForRow:i inSection:clickedBUtton.tag]];
            }
            [self.busTable insertRowsAtIndexPaths:insertionArray withRowAnimation:UITableViewRowAnimationTop];
            
        }
    }
    [self.busTable endUpdates];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.currentStretchIndexPath && indexPath.section==self.currentStretchIndexPath.section) {
            SLBusLineCell *cell = (SLBusLineCell *)[self tableView:self.busTable cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
       
    }else{
        return 0;
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger num=0;
    if (self.currentStretchIndexPath &&section==self.currentStretchIndexPath.section) {
        SLBusDM *model=[self.busArray objectAtIndex:section];
        num=[model.segmentArray count];
    }
    return num;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLBusLineCell *cell=[self.busTable dequeueReusableHeaderFooterViewWithIdentifier:BusLineCellCellIdentifier];
    if (!cell) {
        cell=[[SLBusLineCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:BusLineCellCellIdentifier];
    }

    SLBusDM *oneBusDM=[self.busArray objectAtIndex:indexPath.section];
    SLBusSegmentDM *oneBusSegmentDM=[oneBusDM.segmentArray objectAtIndex:indexPath.row];
    NSString *str=[NSString stringWithFormat:@"线路长度:%@米\n\n步行%@米至%@\n\n乘坐%@至%@",oneBusSegmentDM.line_dist,oneBusSegmentDM.foot_dist,oneBusSegmentDM.start_stat,oneBusSegmentDM.line_name,oneBusSegmentDM.end_stat];
    cell.lineDesc.text=str;
    CGSize constraint=CGSizeMake(200, 20000.0f);
    CGSize size=[str sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:13] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
    cell.lineDesc.numberOfLines=0;
    cell.lineDesc.lineBreakMode=NSLineBreakByCharWrapping;
    cell.lineDesc.font=[UIFont fontWithName:@"Avenir-Light" size:13];
    cell.lineDesc.frame=CGRectMake(110, 0, size.width, size.height);
    
    cell.frame=CGRectMake(0, 0, 320, size.height+10);
    
       NSMutableArray *statArray=[NSMutableArray arrayWithCapacity:0];
    NSString *statTitles=[[NSString alloc]init];
    statTitles=oneBusSegmentDM.stats;
    
    while ([statTitles rangeOfString:@";"].location!= NSNotFound) {
        NSRange range=[statTitles rangeOfString:@";"];
        [statArray addObject:[statTitles substringToIndex:range.location-1]];
        statTitles=[statTitles substringToIndex:range.location];
    }
    [statArray addObject:statTitles];
    [statArray addObject:oneBusSegmentDM.end_stat];
    
    CGRect lineRect=CGRectMake(0, 0, 320, size.height);
    [cell updateStationPoint:lineRect withTitle:statArray];

    UIView *selectedView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, size.height+10)];
    selectedView.backgroundColor=[UIColor clearColor];
    cell.selectedBackgroundView=selectedView;
    selectedView=nil;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
