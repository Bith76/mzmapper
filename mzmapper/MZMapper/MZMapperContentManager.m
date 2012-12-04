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
@synthesize handledPointObjects;
@synthesize handledPointObjectTypes;
@synthesize actualPointObjects;
@synthesize deletedPointObjects;
@synthesize addedPointObjects;
@synthesize updatedPointObjects;

#pragma mark -
#pragma mark singleton pattern

+ (MZMapperContentManager*)sharedContentManager
{
    if (sharedContentManager == nil) 
    {
        sharedContentManager = [[super allocWithZone:NULL] init];
        
        sharedContentManager.handledPointObjectTypes = [NSArray arrayWithObjects:
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
        
        sharedContentManager.handledPointObjects = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"shop:supermarket",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementSupermarket],
                            @"shop:convenience",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementSmallConvenienceStore],
                            @"shop:bakery",                     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementBakery],
                            @"shop:alcohol",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementAlcoholShop],
                            @"shop:bicycle",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementBikeShop],
                            @"shop:books",                      [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementBookShop],
                            @"shop:butcher",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementButcher],
                            @"shop:car",                        [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementCarSales],
                            @"shop:car_repair",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementCarRepair],
                            @"shop:clothes",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementClothesShop],
                            @"shop:confectionery",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementConfectionery],
                            @"shop:diy",                        [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementDIY],
                            @"shop:fish",                       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementFishmonger],
                            @"shop:florist",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementFlorist],
                            @"shop:garden_centre",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementGardenCentre],
                            @"shop:gift",                       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementGiftShop],
                            @"shop:greengrocer",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementGreengrocer],
                            @"shop:hairdresser",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementHairdresser],
                            @"shop:hifi",                       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementHifiShop],
                            @"shop:jewelry",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementJewellery],
                            @"shop:kiosk",                      [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementKiosk],
                            @"shop:laundry",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementLaundrette],
                            @"shop:motorcycle",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementMotorbikeShop],
                            @"shop:music",                      [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementMusicShop],
                            @"shop:toys",                       [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementToyShop],
                            @"shop:marketplace",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryShoppingElementMarketPlace],

                            @"amenity:drinking_water",          [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementWaterFountain],
                            @"amenity:vending_machine",         [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementVendingMachine],
                            @"amenity:pub",                     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementPub],
                            @"amenity:bar",                     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementBar],
                            @"amenity:restaurant",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementRestaurant],
                            @"amenity:cafe",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementCafe],
                            @"amenity:fast_food",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryFoodAndDrinkElementFastFood],

                            @"amenity:fire_station",            [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementFireStation],
                            @"amenity:police",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementPolice],
                            @"amenity:townhall",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementTownhall],
                            @"amenity:place_of_worship",        [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementPlaceOfWorship],
                            @"amenity:post_office",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementPostOffice],
                            @"amenity:post_box",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementPostBox],
                            @"amenity:atm",                     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementAtm],
                            @"amenity:bank",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementBank],
                            @"amenity:recycling",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementRecycling],
                            @"amenity:waste_basket",            [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementWasteBasket],
                            @"amenity:toilet",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementToilet],
                            @"amenity:shelter",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementShelter],
                            @"amenity:hunting_stand",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementHuntingStand],
                            @"amenity:bench",                   [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementBench],
                            @"amenity:telephone",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementTelephone],
                            @"emergency:phone",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementPhone],
                            @"man_made:tower",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAmenityElementTower],

                            @"tourism:museum",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementMuseum],
                            @"historic:archaeological_site",    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementArcheologicalSite],
                            @"historic:battlefield",            [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementBattlefield],
                            @"historic:castle",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementCastle],
                            @"historic:memorial",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementMemorial],
                            @"historic:monument",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementMonument],
                            @"historic:ruins",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementRuins],
                            @"tourism:picnic_site",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementPicnicSite],
                            @"tourism:viewpoint",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementViewPoint],
                            @"tourism:zoo",                     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementZoo],
                            @"tourism:information",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementInformation],
                            @"tourism:artwork",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementArtWork],
                            @"tourism:theme_park",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTourismElementThemePark],

                            @"tourism:hotel",                   [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementHotel],
                            @"tourism:motel",                   [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementMotel],
                            @"tourism:hostel",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementHostel],
                            @"tourism:guest_house",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementGuestHouse],
                            @"tourism:camp_site",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementCampSite],
                            @"tourism:caravan_site",            [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementCaravanPark],
                            @"tourism:alpine_hut",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryAccomodationElementAlpineHut],
                                                    
                            @"aeroway:aerodrome",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementAirport],
                            @"aeroway:terminal",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementAirportTerminal],
                            @"aeroway:gate",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementAirportGate],
                            @"aeroway:helipad",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementHelipad],
                            @"railway:station",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementRailwayStation],
                            @"railway:tram_stop",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementTramStop],
                            @"amenity:bus_station",             [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementBusStation],
                            @"highway:bus_stop",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementBusStop],
                            @"amenity:parking",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementCarParking],
                            @"amenity:taxi",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementTaxiRank],
                            @"amenity:bicycle_parking",         [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementBicycleParking],
                            @"amenity:car_rental",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementCarRental],
                            @"amenity:bicycle_rental",          [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementBicycleRental],
                            @"amenity:fuel",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementFuel],

                            @"barrier:bollard",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryBarrierElementBollard],
                            @"barrier:gate",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryBarrierElementGate],
                            @"barrier:lift_gate",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryBarrierElementLiftGate],
                            @"barrier:cycle_barrier",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryBarrierElementCycleBarrier],
                            @"barrier:block",                   [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryBarrierElementBigConcreteBlocks],
                            @"barrier:toll_booth",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryBarrierElementTollBooth],

                            @"power:tower",                     [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPowerElementHighVoltage],
                            @"power:pole",                      [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPowerElementPowerPole],
                            @"power:generator",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPowerElementPlantStation],
                            @"power:sub_station",               [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPowerElementTransformer],

                            @"landuse:cemetery",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryLanduseElementCemetery],
                            @"amenity:grave_yard",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryLanduseElementGraveYard],

                            @"place:hamlet",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPlacesElementHamlet],
                            @"place:village",                   [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPlacesElementVillage],
                            @"place:town",                      [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPlacesElementTown],
                            @"place:suburb",                    [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPlacesElementSuburb],
                            @"place:city",                      [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryPlacesElementCity],

                            @"leisure:swimming_pool",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategorySportAndLeisureElementSwimmingPool],
                            @"leisure:playground",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategorySportAndLeisureElementPlayground],
                            @"leisure:sports_centre",           [NSNumber numberWithUnsignedInteger:MZMapperPointCategorySportAndLeisureElementSportCentre],
                            @"leisure:marina",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategorySportAndLeisureElementMarina],
                            @"leisure:slipway",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategorySportAndLeisureElementSlipway],

                            @"amenity:pharmacy",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryHealthcareElementPharmacy],
                            @"amenity:hospital",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryHealthcareElementHospital],
                            @"amenity:veterinary",              [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryHealthcareElementVeterinary],

                            @"amenity:cinema",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryEntertainmentArtsCultureElementCinema],
                            @"amenity:theatre",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryEntertainmentArtsCultureElementTheatre],
                            @"amenity:fountain",                [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryEntertainmentArtsCultureElementFountain],

                            @"amenity:kindergarten",            [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryEducationElementKindergarten],
                            @"amenity:library",                 [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryEducationElementLibrary],
                            @"amenity:school",                  [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryEducationElementSchool],
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
    
    for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].handledPointObjectTypes)
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
    
    for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].handledPointObjectTypes)
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

- (NSString*)fullTypeNameInServerRepresentationForLogicalType:(NSUInteger)logicalType
{
    return [self.handledPointObjects objectForKey:[NSNumber numberWithUnsignedInteger:logicalType]];
}

- (NSUInteger)logicalTypeForServerTypeName:(NSString*)serverType
{
    NSSet *keys = [self.handledPointObjects keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return (*stop = [serverType isEqual:obj]);
    }];
    
    return [[keys anyObject] unsignedIntegerValue];
}

- (NSString*)serverTypeNameForLogicalType:(NSUInteger)logicalType
{
    return [self.handledPointObjects objectForKey:[NSNumber numberWithUnsignedInteger:logicalType]];
}

@end
