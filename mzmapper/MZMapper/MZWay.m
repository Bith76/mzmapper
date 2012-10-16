//
//  MZWay.m
//  MZMapper
//
//  Created by Zalan Mergl on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MZWay.h"

@implementation MZWay

@synthesize wayid = _wayid;
@synthesize nodes = _nodes;
@synthesize tags = _tags;
@synthesize lineWidth = _lineWidth;
@synthesize strokeColor = _strokeColor;
@synthesize fillColor = _fillColor;

- (id)init
{
    self = [super init];
    
    if (self) 
    {
        // Initialization code here.
        _nodes = [[NSMutableArray alloc] init];
        _tags = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [_nodes release], _nodes = nil;
    
    [_tags release], _tags = nil;
    
    [super dealloc];
}

@end
