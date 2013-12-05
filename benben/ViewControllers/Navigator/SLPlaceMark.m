//
//  SLPlaceMark.m
//  benben
//
//  Created by Sonic Lin on 12/5/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLPlaceMark.h"

@implementation SLPlaceMark
@synthesize coordinate;
@synthesize place;

-(id) initWithPlace: (SLPlace*) p
{
	self = [super init];
	if (self != nil) {
		coordinate.latitude = p.latitude;
		coordinate.longitude = p.longitude;
		self.place = p;
        
	}
	return self;
}

- (NSString *)subtitle
{
	return self.place.description;
}
- (NSString *)title
{
	return self.place.name;
}

@end
