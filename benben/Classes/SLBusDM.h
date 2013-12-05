//
//  SLBusDM.h
//  benben
//
//  Created by Sonic Lin on 12/4/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SLBusSegmentDM : NSObject
@property (strong, nonatomic) NSString *end_stat;
@property (strong, nonatomic) NSString *foot_dist;
@property (strong, nonatomic) NSString *line_dist;
@property (strong, nonatomic) NSString *line_name;
@property (strong, nonatomic) NSString *line_xys;
@property (strong, nonatomic) NSString *start_stat;
@property (strong, nonatomic) NSString *stat_xys;
@property (strong, nonatomic) NSString *stats;
@end


@interface SLBusDM : NSObject
@property (strong, nonatomic) NSString *dist;
@property (strong, nonatomic) NSString *foot_dist;
@property (strong, nonatomic) NSString *last_food_dist;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSMutableArray *segmentArray;//SLBusSegmentDM


+ (BOOL)parseIntoMerchantstList:(NSMutableArray*)busList
                     fromString:(NSData*)responseData;

@end
