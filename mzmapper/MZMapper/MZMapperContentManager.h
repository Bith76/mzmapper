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
    MZMapperPointCategoryWater,
    MZMapperPointCategoryBarrier,
    MZMapperPointCategoryPower,
    MZMapperPointCategoryBuildings,
    MZMapperPointCategoryLanduse,
    MZMapperPointCategoryPlaces,
    MZMapperPointCategorySportAndLeisure,
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
    MZMapperPointCategoryShoppingElementPharmacy,
    MZMapperPointCategoryShoppingElementToyShop,
    MZMapperPointCategoryShoppingElementMarketPlace,
    MZMapperPointCategoryShoppingElementCountOfElements
};
typedef NSUInteger MZMapperPointCategoryShoppingElement;

@interface MZMapperContentManager : NSObject
{
    NSString*   _userName;
    NSString*   _password;
    
    BOOL        _loggedIn;
}

@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, assign) BOOL      loggedIn;

//singleton
+ (MZMapperContentManager*)sharedContentManager;

@end
