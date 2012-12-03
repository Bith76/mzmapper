//
//  MZMapperContentManager.h
//  MZMapper
//
//  Created by Zalán Mergl on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


// point category types
enum
{
    MZMapperPointCategoryNone = 0,
	MZMapperPointCategoryShopping,
	MZMapperPointCategoryFoodAndDrink,
	MZMapperPointCategoryAmenity,
    MZMapperPointCategoryTourism,
    MZMapperPointCategoryAccomodation,
    MZMapperPointCategoryTransport,
    MZMapperPointCategoryBarrier,
    MZMapperPointCategoryPower,
    MZMapperPointCategoryLanduse,
    MZMapperPointCategoryPlaces,
    MZMapperPointCategorySportAndLeisure,
    MZMapperPointCategoryHealthCare,
    MZMapperPointCategoryEntertainmentArtsCulture,
    MZMapperPointCategoryEducation,
    MZMapperPointCategoryCountOfCategories
};
typedef NSUInteger MZMapperPointCategory;


// point category item types
enum
{
    MZMapperPointCategoryShoppingElementUnknown = 1000,
    MZMapperPointCategoryShoppingElementSupermarket,
    MZMapperPointCategoryShoppingElementSmallConvenienceStore,
    MZMapperPointCategoryShoppingElementBakery,
    MZMapperPointCategoryShoppingElementAlcoholShop,
    MZMapperPointCategoryShoppingElementBikeShop,
    MZMapperPointCategoryShoppingElementBookShop,
    MZMapperPointCategoryShoppingElementButcher,
    MZMapperPointCategoryShoppingElementCarSales,
    MZMapperPointCategoryShoppingElementCarRepair,
    MZMapperPointCategoryShoppingElementClothesShop,
    MZMapperPointCategoryShoppingElementConfectionery,
    MZMapperPointCategoryShoppingElementDIY,
    MZMapperPointCategoryShoppingElementFishmonger,
    MZMapperPointCategoryShoppingElementFlorist,
    MZMapperPointCategoryShoppingElementGardenCentre,
    MZMapperPointCategoryShoppingElementGiftShop,
    MZMapperPointCategoryShoppingElementGreengrocer,
    MZMapperPointCategoryShoppingElementHairdresser,
    MZMapperPointCategoryShoppingElementHifiShop,
    MZMapperPointCategoryShoppingElementJewellery,
    MZMapperPointCategoryShoppingElementKiosk,
    MZMapperPointCategoryShoppingElementLaundrette,
    MZMapperPointCategoryShoppingElementMotorbikeShop,
    MZMapperPointCategoryShoppingElementMusicShop,
    MZMapperPointCategoryShoppingElementToyShop,
    MZMapperPointCategoryShoppingElementMarketPlace,
    MZMapperPointCategoryShoppingElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryShoppingElement;

enum
{
    MZMapperPointCategoryFoodAndDrinkElementUnknown = 2000,
    MZMapperPointCategoryFoodAndDrinkElementWaterFountain,
    MZMapperPointCategoryFoodAndDrinkElementVendingMachine,
    MZMapperPointCategoryFoodAndDrinkElementPub,
    MZMapperPointCategoryFoodAndDrinkElementBar,
    MZMapperPointCategoryFoodAndDrinkElementRestaurant,
    MZMapperPointCategoryFoodAndDrinkElementCafe,
    MZMapperPointCategoryFoodAndDrinkElementFastFood,
    MZMapperPointCategoryFoodAndDrinkElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryFoodAndDrinkElement;

enum
{
    MZMapperPointCategoryAmenityElementUnknown = 3000,
    MZMapperPointCategoryAmenityElementFireStation,
    MZMapperPointCategoryAmenityElementPolice,
    MZMapperPointCategoryAmenityElementTownhall,
    MZMapperPointCategoryAmenityElementPlaceOfWorship,
    MZMapperPointCategoryAmenityElementPostOffice,
    MZMapperPointCategoryAmenityElementPostBox,
    MZMapperPointCategoryAmenityElementAtm,
    MZMapperPointCategoryAmenityElementBank,
    MZMapperPointCategoryAmenityElementRecycling,
    MZMapperPointCategoryAmenityElementWasteBasket,
    MZMapperPointCategoryAmenityElementToilet,
    MZMapperPointCategoryAmenityElementShelter,
    MZMapperPointCategoryAmenityElementHuntingStand,
    MZMapperPointCategoryAmenityElementBench,
    MZMapperPointCategoryAmenityElementTelephone,
    MZMapperPointCategoryAmenityElementPhone,
    MZMapperPointCategoryAmenityElementTower,
    MZMapperPointCategoryAmenityElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryAmenityElement;

enum
{
    MZMapperPointCategoryTourismElementUnknown = 4000,
    MZMapperPointCategoryTourismElementMuseum,
    MZMapperPointCategoryTourismElementArcheologicalSite,
    MZMapperPointCategoryTourismElementBattlefield,
    MZMapperPointCategoryTourismElementCastle,
    MZMapperPointCategoryTourismElementMemorial,
    MZMapperPointCategoryTourismElementMonument,
    MZMapperPointCategoryTourismElementRuins,
    MZMapperPointCategoryTourismElementPicnicSite,
    MZMapperPointCategoryTourismElementViewPoint,
    MZMapperPointCategoryTourismElementZoo,
    MZMapperPointCategoryTourismElementInformation,
    MZMapperPointCategoryTourismElementArtWork,
    MZMapperPointCategoryTourismElementThemePark,
    MZMapperPointCategoryTourismElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryTourismElement;

enum
{
    MZMapperPointCategoryAccomodationElementUnknown = 5000,
    MZMapperPointCategoryAccomodationElementHotel,
    MZMapperPointCategoryAccomodationElementMotel,
    MZMapperPointCategoryAccomodationElementHostel,
    MZMapperPointCategoryAccomodationElementGuestHouse,
    MZMapperPointCategoryAccomodationElementCampSite,
    MZMapperPointCategoryAccomodationElementCaravanPark,
    MZMapperPointCategoryAccomodationElementAlpineHut,
    MZMapperPointCategoryAccomodationElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryAccomodationElement;

enum
{
    MZMapperPointCategoryTransportElementUnknown = 6000,
    MZMapperPointCategoryTransportElementAirport,
    MZMapperPointCategoryTransportElementAirportTerminal,
    MZMapperPointCategoryTransportElementAirportGate,
    MZMapperPointCategoryTransportElementHelipad,
    MZMapperPointCategoryTransportElementRailwayStation,
    MZMapperPointCategoryTransportElementTramStop,
    MZMapperPointCategoryTransportElementBusStation,
    MZMapperPointCategoryTransportElementBusStop,
    MZMapperPointCategoryTransportElementCarParking,
    MZMapperPointCategoryTransportElementTaxiRank,
    MZMapperPointCategoryTransportElementBicycleParking,
    MZMapperPointCategoryTransportElementCarRental,
    MZMapperPointCategoryTransportElementBicycleRental,
    MZMapperPointCategoryTransportElementFuel,
    MZMapperPointCategoryTransportElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryTransportElement;

enum
{
    MZMapperPointCategoryBarrierElementUnknown = 7000,
    MZMapperPointCategoryBarrierElementBollard,
    MZMapperPointCategoryBarrierElementGate,
    MZMapperPointCategoryBarrierElementLiftGate,
    MZMapperPointCategoryBarrierElementCycleBarrier,
    MZMapperPointCategoryBarrierElementBigConcreteBlocks,
    MZMapperPointCategoryBarrierElementTollBooth,
    MZMapperPointCategoryBarrierElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryBarrierElement;

enum
{
    MZMapperPointCategoryPowerElementUnknown = 8000,
    MZMapperPointCategoryPowerElementHighVoltage,
    MZMapperPointCategoryPowerElementPowerPole,
    MZMapperPointCategoryPowerElementPlantStation,
    MZMapperPointCategoryPowerElementTransformer,
    MZMapperPointCategoryPowerElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryPowerElement;

enum
{
    MZMapperPointCategoryLanduseElementUnknown = 9000,
    MZMapperPointCategoryLanduseElementCemetery,
    MZMapperPointCategoryLanduseElementGraveYard,
    MZMapperPointCategoryLanduseElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryLanduseElement;

enum
{
    MZMapperPointCategoryPlacesElementUnknown = 10000,
    MZMapperPointCategoryPlacesElementHamlet,
    MZMapperPointCategoryPlacesElementVillage,
    MZMapperPointCategoryPlacesElementTown,
    MZMapperPointCategoryPlacesElementSuburb,
    MZMapperPointCategoryPlacesElementCity,
    MZMapperPointCategoryPlacesElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryPlacesElement;

enum
{
    MZMapperPointCategorySportAndLeisureElementUnknown = 11000,
    MZMapperPointCategorySportAndLeisureElementSwimmingPool,
    MZMapperPointCategorySportAndLeisureElementPlayground,
    MZMapperPointCategorySportAndLeisureElementSportCentre,
    MZMapperPointCategorySportAndLeisureElementMarina,
    MZMapperPointCategorySportAndLeisureElementSlipway,
    MZMapperPointCategorySportAndLeisureElementCountOfElements
};
typedef NSUInteger MZMapperPointCategorySportAndLeisureElement;

enum
{
    MZMapperPointCategoryHealthcareElementUnknown = 12000,
    MZMapperPointCategoryHealthcareElementPharmacy,
    MZMapperPointCategoryHealthcareElementHospital,
    MZMapperPointCategoryHealthcareElementVeterinary,
    MZMapperPointCategoryHealthcareElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryHealthcareElement;

enum
{
    MZMapperPointCategoryEntertainmentArtsCultureElementUnknown = 13000,
    MZMapperPointCategoryEntertainmentArtsCultureElementCinema,
    MZMapperPointCategoryEntertainmentArtsCultureElementTheatre,
    MZMapperPointCategoryEntertainmentArtsCultureElementFountain,
    MZMapperPointCategoryEntertainmentArtsCultureElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryEntertainmentArtsCultureElement;

enum
{
    MZMapperPointCategoryEducationElementUnknown = 14000,
    MZMapperPointCategoryEducationElementKindergarten,
    MZMapperPointCategoryEducationElementLibrary,
    MZMapperPointCategoryEducationElementSchool,
    MZMapperPointCategoryEducationElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryEducationElement;



@class MZNode;

@interface MZMapperContentManager : NSObject

@property (nonatomic, retain) NSString*         userName;
@property (nonatomic, retain) NSString*         password;
@property (nonatomic, assign) BOOL              loggedIn;
@property (nonatomic, assign) BOOL              openStreetBugModeIsActive;
@property (nonatomic, retain) NSArray*          handledPointObjectTypes;

@property (nonatomic, retain) NSDictionary*     handledPointObjects; //stores point objects which the app should handle; key: logical number representation of the point object type; value: string representation of the point object type
@property (nonatomic, retain) NSMutableArray*   actualPointObjects; //stores actual point objects from map-slice

@property (nonatomic, retain) NSMutableArray*   deletedPointObjects; //stores deleted point objects; actualPointObjects does not contains these objects
@property (nonatomic, retain) NSMutableArray*   addedPointObjects; //stores newly added point objects; actualPointObjects contains these objects too
@property (nonatomic, retain) NSMutableArray*   updatedPointObjects; //stores updated point objects; actualPointObjects contains these objects too

//singleton
+ (MZMapperContentManager*)sharedContentManager;

- (NSString*)typeNameInServerRepresentationForNode:(MZNode*)aNode;
- (NSString*)subTypeNameInServerRepresentationForNode:(MZNode*)aNode;
- (NSString*)fullTypeNameInServerRepresentationForNode:(MZNode*)aNode;

- (NSString*)typeNameInServerRepresentationForLogicalType:(NSUInteger)logicalType;
- (NSString*)subTypeNameInServerRepresentationForLogicalType:(NSUInteger)logicalType;
- (NSString*)fullTypeNameInServerRepresentationForLogicalType:(NSUInteger)logicalType;

- (NSUInteger)logicalTypeForServerTypeName:(NSString*)serverType;
- (NSString*)serverTypeNameForLogicalType:(NSUInteger)logicalType;

@end
