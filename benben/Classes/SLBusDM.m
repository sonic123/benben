//
//  SLBusDM.m
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLBusDM.h"
@implementation SLBusSegmentDM

@end

@implementation SLBusDM
+ (BOOL)parseIntoMerchantstList:(NSMutableArray*)busList
                     fromString:(NSData*)responseData{
    if (!busList ||!responseData) {
        NSLog(@"Param Failed");
        return NO;
    }
    NSError *parseErr=nil;
    id objTmp=nil;
    NSDictionary *dicTmp=nil;
    NSArray *arrTmp=nil;
    do {
        id dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&parseErr];
        if (!dic || parseErr) {
            return NO;
        }
        objTmp=[dic objectForKey:@"buses"];
        if (objTmp &&[objTmp isKindOfClass:[NSDictionary class]]) {
            dicTmp=(NSDictionary *)objTmp;
            if (dicTmp) {
                objTmp=[dicTmp objectForKey:@"bus"];
                if (objTmp &&[objTmp isKindOfClass:[NSArray class]]) {
                    arrTmp=(NSArray *)objTmp;
                } else {
                    objTmp=nil;
                }
            } else {
                dicTmp=nil;
            }
            
        }else{
            objTmp=nil;
        }
        SLBusDM *oneBusDM=nil;
        SLBusSegmentDM *oneSgementDM=nil;
        for (NSDictionary *dic in arrTmp) {
            @autoreleasepool {
                oneBusDM=[[SLBusDM alloc]init];
                oneBusDM.dist=[dic objectForKey:@"dist"];
                oneBusDM.foot_dist=[dic objectForKey:@"foot_dist"];
                oneBusDM.last_food_dist=[dic objectForKey:@"last_foot_dist"];
                oneBusDM.time=[dic objectForKey:@"time"];
                oneBusDM.segmentArray=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *d in [[dic objectForKey:@"segments"] objectForKey:@"segment"]) {
                    @autoreleasepool {
                        oneSgementDM=[[SLBusSegmentDM alloc]init];
                        oneSgementDM.end_stat=[d objectForKey:@"end_stat"];
                        oneSgementDM.foot_dist=[d objectForKey:@"foot_dist"];
                        oneSgementDM.line_dist=[d objectForKey:@"line_dist"];
                        oneSgementDM.line_name=[d objectForKey:@"line_name"];
                        oneSgementDM.line_xys=[d objectForKey:@"line_xys"];
                        oneSgementDM.start_stat=[d objectForKey:@"start_stat"];
                        oneSgementDM.stat_xys=[d objectForKey:@"stat_xys"];
                        oneSgementDM.stats=[d objectForKey:@"stats"];
                        [oneBusDM.segmentArray addObject:oneSgementDM];
                    }
                    
                }
                [busList addObject:oneBusDM];
            }
        }
    } while (0);
    return YES;
}
@end
