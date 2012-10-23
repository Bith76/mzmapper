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
    MZMapperPointCategoryManMade,
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
