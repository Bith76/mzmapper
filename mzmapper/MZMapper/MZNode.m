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

- (id)copyWithZone:(NSZone *)zone
{
    id newObject = [[[self class] alloc] init];
    
    if (newObject)
    {
        // Copy NSObject subclasses
        [newObject setNodeid:[[self.nodeid mutableCopyWithZone:zone] autorelease]];
        [newObject setTags:[[self.tags mutableCopyWithZone:zone] autorelease]];
        
        // Set primitives
        [newObject setLatitude:self.latitude];
        [newObject setLongitude:self.longitude];
        [newObject setVersion:self.version];
    }
    
    return newObject;
}

- (void)dealloc
{
    [_tags release], _tags = nil;
    
    [super dealloc];
}

@end
