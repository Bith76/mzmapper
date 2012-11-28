//
//  MZNode.m
//  MZMapper
//
//  Created by Zalan Mergl on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MZNode.h"

@implementation MZNode

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize nodeid = _nodeid;
@synthesize version = _version;
@synthesize tags = _tags;

- (id)init
{
    self = [super init];
    if (self) 
    {
        //Initialization code here.
        
        _tags = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [_tags release], _tags = nil;
    
    [super dealloc];
}

@end
