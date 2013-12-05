//
//  SLPlace.h
//  benben
//
//  Created by Sonic Lin on 12/5/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLPlace : NSObject
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
