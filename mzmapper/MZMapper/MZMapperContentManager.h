//
//  MZMapperContentManager.h
//  MZMapper
//
//  Created by Zalán Mergl on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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
    MZMapperPointCategoryEntertainment,
    MZMapperPointCategoryEducation,
    MZMapperPointCategoryCountOfCategories
};
typedef NSUInteger MZMapperPointCategory;


enum
{
    MZMapperPointCategoryShoppingElementSupermarket = 0,
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
    MZMapperPointCategoryFoodAndDrinkElementWaterFountain = 0,
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
    MZMapperPointCategoryAmenityElementFireStation = 0,
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






//innen van meló
enum
{
    MZMapperPointCategoryTourismElementMuseum = 0,
    //...
    MZMapperPointCategoryTourismElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryTourismElement;

enum
{
    MZMapperPointCategoryAccomodationElementHotel = 0,
    //...
    MZMapperPointCategoryAccomodationElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryAccomodationElement;

enum
{
    MZMapperPointCategoryTransportElementAirport = 0,
    //...
    MZMapperPointCategoryTransportElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryTransportElement;

enum
{
    MZMapperPointCategoryBarrierElementBollard = 0,
    //...
    MZMapperPointCategoryBarrierElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryBarrierElement;

enum
{
    MZMapperPointCategoryPowerElementHighVoltage = 0,
    //...
    MZMapperPointCategoryPowerElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryPowerElement;

enum
{
    MZMapperPointCategoryLanduseElementCemetery = 0,
    MZMapperPointCategoryLanduseElementGraveYard,
    MZMapperPointCategoryLanduseElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryLanduseElement;

enum
{
    MZMapperPointCategoryPlacesElementHamlet = 0,
    //...
    MZMapperPointCategoryPlacesElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryPlacesElement;

enum
{
    MZMapperPointCategorySportAndLeisureElementSwimmingPool = 0,
    //...
    MZMapperPointCategorySportAndLeisureElementCountOfElements
};
typedef NSUInteger MZMapperPointCategorySportAndLeisureElement;

enum
{
    MZMapperPointCategoryHealthcareElementPharmacy = 0,
    //...
    MZMapperPointCategoryHealthcareElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryHealthcareElement;

enum
{
    MZMapperPointCategoryEntertainmentArtsCultureElementCinema = 0,
    //...
    MZMapperPointCategoryEntertainmentArtsCultureElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryEntertainmentArtsCultureElement;

enum
{
    MZMapperPointCategoryEducationElementKindergarten = 0,
    //...
    MZMapperPointCategoryEducationElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryEducationElement;





//idáig van meló

@interface MZMapperContentManager : NSObject
{
    NSString*   _userName;
    NSString*   _password;
    
    BOOL        _loggedIn;
}

@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, assign) BOOL      loggedIn;
@property (nonatomic, assign) BOOL      openStreetBugModeIsActive;

//singleton
+ (MZMapperContentManager*)sharedContentManager;

@end
