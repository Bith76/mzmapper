//
//  MZPlace.m
//  MZMapper
//
//  Created by Zalán Mergl on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZPlace.h"

@implementation MZPlace

@synthesize placeId;
@synthesize latitude;
@synthesize longitude;
@synthesize displayName;
@synthesize iconURL;


- (NSString*)description
{
    NSString* retVal = nil;
    
    NSString* superDesc = [super description];
    
    NSRange range = NSMakeRange([superDesc length] - 2, 1);
    
    NSString* stringToAdd = [NSString stringWithFormat:@" placeId = %@; lat = %f; lon = %f; displayName = %@", self.placeId, self.latitude, self.longitude, self.displayName];
    
    retVal = [superDesc stringByReplacingCharactersInRange:range withString:stringToAdd];
    
    return retVal;
}

@end
