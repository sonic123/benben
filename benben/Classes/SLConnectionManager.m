//
//  SLConnectionManager.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLConnectionManager.h"

static SLConnectionManager *connectionManagerInstance=nil;

@implementation SLConnectionManager
+(SLConnectionManager *)sharedManager{
    @synchronized(self){
        if (connectionManagerInstance==nil) {
            connectionManagerInstance=[[SLConnectionManager alloc]init];
        }
    }
    return connectionManagerInstance;
}

@end
