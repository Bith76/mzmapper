//
//  MZOpenStreetBug.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/22/12.
//
//

#import "MZOpenStreetBug.h"

@implementation MZOpenStreetBug

@synthesize bugID;
@synthesize longitude;
@synthesize latitude;
@synthesize description;
@synthesize status;
@synthesize comments;

- (void)dealloc
{
    self.bugID = nil;
    self.description = nil;
    self.comments = nil;
    
    [super dealloc];
}

@end
