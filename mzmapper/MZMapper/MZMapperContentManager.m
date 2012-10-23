//
//  MZMapperContentManager.m
//  MZMapper
//
//  Created by Zalán Mergl on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZMapperContentManager.h"

static MZMapperContentManager* sharedContentManager = nil;

@implementation MZMapperContentManager

@synthesize userName                    = _userName;
@synthesize password                    = _password;
@synthesize loggedIn                    = _loggedIn;
@synthesize openStreetBugModeIsActive;

#pragma mark -
#pragma mark singleton pattern

+ (MZMapperContentManager*)sharedContentManager
{
    if (sharedContentManager == nil) 
    {
        sharedContentManager = [[super allocWithZone:NULL] init];
    }
    
    return sharedContentManager;
}

+ (id)allocWithZone:(NSZone*)zone
{
    return [[self sharedContentManager] retain];
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;   //denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
