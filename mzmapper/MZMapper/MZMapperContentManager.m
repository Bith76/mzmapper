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
@synthesize pointObjects;
@synthesize pointObjectTypes;
@synthesize actualPointObjects;

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
        
        sharedContentManager.pointObjects = [NSDictionary dictionaryWithObjectsAndKeys:
                                             @"shop:supermarket",       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementSupermarket],
                                             @"shop:convenience",       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementSmallConvenienceStore],
                                             @"shop:bakery",            [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementBakery],
                                             @"shop:alcohol",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementAlcoholShop],
                                             @"shop:bicycle",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementBikeShop],
                                             @"shop:books",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementBookShop],
                                             @"shop:butcher",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementButcher],
                                             @"shop:car",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementCarSales],
                                             @"shop:car_repair",        [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementCarRepair],
                                             @"shop:clothes",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementClothesShop],
                                             @"shop:confectionery",     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementConfectionery],
                                             @"shop:diy",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementDIY],
                                             @"shop:fish",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementFishmonger],
                                             @"shop:florist",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementFlorist],
                                             @"shop:garden_centre",     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementGardenCentre],
                                             @"shop:gift",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementGiftShop],
                                             @"shop:greengrocer",       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementGreengrocer],
                                             @"shop:hairdresser",       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementHairdresser],
                                             @"shop:hifi",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementHifiShop], 
                                             @"shop:jewelry",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementJewellery], 
                                             @"shop:kiosk",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementKiosk], 
                                             @"shop:laundry",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementLaundrette], 
                                             @"shop:motorcycle",        [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementMotorbikeShop], 
                                             @"shop:music",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementMusicShop], 
                                             @"shop:toys",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementToyShop],
                                             @"shop:marketplace",       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementMarketPlace], 
                                             nil];
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

- (NSString*)typeNameInServerRepresentationForNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].pointObjectTypes)
    {
        NSString* subType = [aNode.tags valueForKey:pointObjectType];
        
        if (subType)
        {
            retVal = pointObjectType;
            break;
        }
    }

    return retVal;
}

- (NSString*)subTypeNameInServerRepresentationForNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].pointObjectTypes)
    {
        NSString* subType = [aNode.tags valueForKey:pointObjectType];
        
        if (subType)
        {
            retVal = subType;
            break;
        }
    }
    
    return retVal;
}

- (NSString*)fullTypeNameInServerRepresentationForNode:(MZNode*)aNode
{
    NSString* type = [self typeNameInServerRepresentationForNode:aNode];
    NSString* subType = [self subTypeNameInServerRepresentationForNode:aNode];
    
    return [NSString stringWithFormat:@"%@:%@",type,subType];
}

- (NSString*)typeNameInServerRepresentationForLogicalType:(NSUInteger)logicalType
{
    NSLog(@"servername: %@",[self serverTypeNameForLogicalType:logicalType]);
    NSLog(@"components: %@",[[self serverTypeNameForLogicalType:logicalType] componentsSeparatedByString:@":"]);
    NSLog(@"0. index: %@",[[[self serverTypeNameForLogicalType:logicalType] componentsSeparatedByString:@":"] objectAtIndex:0]);
    return [[[self serverTypeNameForLogicalType:logicalType] componentsSeparatedByString:@":"] objectAtIndex:0];
}

- (NSString*)subTypeNameInServerRepresentationForLogicalType:(NSUInteger)logicalType
{
    return [[[self serverTypeNameForLogicalType:logicalType] componentsSeparatedByString:@":"] objectAtIndex:1];
}

- (NSUInteger)logicalTypeForServerTypeName:(NSString*)serverType
{
    NSSet *keys = [self.pointObjects keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return (*stop = [serverType isEqual:obj]);
    }];
    
    return [[keys anyObject] unsignedIntegerValue];
}

- (NSString*)serverTypeNameForLogicalType:(NSUInteger)logicalType
{
    return [self.pointObjects objectForKey:[NSNumber numberWithUnsignedInteger:logicalType]];
}

@end
