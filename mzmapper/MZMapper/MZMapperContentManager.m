//
//  MZMapperContentManager.m
//  MZMapper
//
//  Created by Zalán Mergl on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZMapperContentManager.h"
#import "MZNode.h"

static MZMapperContentManager* sharedContentManager = nil;

@implementation MZMapperContentManager

@synthesize userName;
@synthesize password;
@synthesize loggedIn;
@synthesize openStreetBugModeIsActive;
@synthesize pointObjectTypes;
@synthesize pointObjects;

#pragma mark -
#pragma mark singleton pattern

+ (MZMapperContentManager*)sharedContentManager
{
    if (sharedContentManager == nil) 
    {
        sharedContentManager = [[super allocWithZone:NULL] init];
        
        sharedContentManager.pointObjectTypes = [NSArray arrayWithObjects:
                                                 @"amenity",
                                                 @"shop",
                                                 @"tourism",
                                                 @"emergency",
                                                 @"man_made",
                                                 @"barrier",
                                                 @"landuse",
                                                 @"place",
                                                 @"power",
                                                 @"highway",
                                                 @"railway",
                                                 @"leisure",
                                                 @"historic",
                                                 @"aeroway", nil];
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

- (NSString*)typeForNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    for (MZNode* node in [MZMapperContentManager sharedContentManager].pointObjects)
    {
        for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].pointObjectTypes)
        {
            NSString* subType = [node.tags valueForKey:pointObjectType];
            
            if (subType)
            {
                retVal = pointObjectType;
                break;
            }
        }
        
        if (retVal)
        {
            break;
        }
    }
    
    return retVal;
}

- (NSString*)subTypeForNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    for (MZNode* node in [MZMapperContentManager sharedContentManager].pointObjects)
    {
        for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].pointObjectTypes)
        {
            NSString* subType = [node.tags valueForKey:pointObjectType];
            
            if (subType)
            {
                retVal = subType;
                break;
            }
        }
        
        if (retVal)
        {
            break;
        }
    }
    
    return retVal;
}


@end
