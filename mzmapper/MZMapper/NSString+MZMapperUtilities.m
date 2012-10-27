//
//  NSString+MZMapperUtilities.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//

#import "NSString+MZMapperUtilities.h"

@implementation NSString (MZMapperUtilities)

+ (NSString*)nameOfPointCategory:(MZMapperPointCategory)category
{
    NSString* retVal = NSLocalizedString(@"UnnamedPointCategoryNameKey", @"Name of a point category which hasn't got predefined name");
    
    switch (category)
    {
        case MZMapperPointCategoryShopping:
        {
            retVal = NSLocalizedString(@"PointCategoryNameShoppingKey", @"Name of the Shopping-type point category");
        }
            break;
        case MZMapperPointCategoryFoodAndDrink:
        {
            retVal = NSLocalizedString(@"PointCategoryNameFoodAndDrinkKey", @"Name of the FoodAndDrink-type point category");
        }
            break;
        case MZMapperPointCategoryAmenity:
        {
            retVal = NSLocalizedString(@"PointCategoryNameAmenityKey", @"Name of the Amenity-type point category");
        }
            break;
        case MZMapperPointCategoryTourism:
        {
            retVal = NSLocalizedString(@"PointCategoryNameTourismKey", @"Name of the Tourism-type point category");
        }
            break;
        case MZMapperPointCategoryAccomodation:
        {
            retVal = NSLocalizedString(@"PointCategoryNameAccomodationKey", @"Name of the Accomodation-type point category");
        }
            break;
        case MZMapperPointCategoryTransport:
        {
            retVal = NSLocalizedString(@"PointCategoryNameTransportKey", @"Name of the Transport-type point category");
        }
            break;
        case MZMapperPointCategoryBarrier:
        {
            retVal = NSLocalizedString(@"PointCategoryNameBarrierKey", @"Name of the Barrier-type point category");
        }
            break;
        case MZMapperPointCategoryPower:
        {
            retVal = NSLocalizedString(@"PointCategoryNamePowerKey", @"Name of the Power-type point category");
        }
            break;
        case MZMapperPointCategoryLanduse:
        {
            retVal = NSLocalizedString(@"PointCategoryNameLanduseKey", @"Name of the Landuse-type point category");
        }
            break;
        case MZMapperPointCategoryPlaces:
        {
            retVal = NSLocalizedString(@"PointCategoryNamePlacesKey", @"Name of the Places-type point category");
        }
            break;
        case MZMapperPointCategorySportAndLeisure:
        {
            retVal = NSLocalizedString(@"PointCategoryNameSportAndLeisureKey", @"Name of the SportAndLeisure-type point category");
        }
            break;
        case MZMapperPointCategoryHealthCare:
        {
            retVal = NSLocalizedString(@"PointCategoryNameHealthcareKey", @"Name of the Healthcare-type point category");
        }
            break;
        case MZMapperPointCategoryEntertainment:
        {
            retVal = NSLocalizedString(@"PointCategoryNameEntertainmentKey", @"Name of the Entertainment-type point category");
        }
            break;
        case MZMapperPointCategoryEducation:
        {
            retVal = NSLocalizedString(@"PointCategoryNameEducationKey", @"Name of the Education-type point category");
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

+ (NSString*)nameOfPointCategoryShoppingElement:(MZMapperPointCategoryShoppingElement)element
{
    NSString* retVal = NSLocalizedString(@"UnnamedPointCategoryElementNameKey", @"Name of a point category element which hasn't got predefined name");
    
    switch (element)
    {
        case MZMapperPointCategoryShoppingElementSupermarket:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameSupermarketKey", @"Name of the Supermarket point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementSmallConvenienceStore:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameSmallConvenienceStoreKey", @"Name of the SmallConvenienceStore point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementBakery:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameBakeryKey", @"Name of the Bakery point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementAlcoholShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameAlcoholShopKey", @"Name of the AlcoholShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementBikeShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameBikeShopKey", @"Name of the BikeShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementBookShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameBookShopKey", @"Name of the BookShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementButcher:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameButcherKey", @"Name of the Butcher point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementCarSales:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameCarSalesKey", @"Name of the CarSales point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementCarRepair:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameCarRepairKey", @"Name of the CarRepair point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementClothesShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameClothesShopKey", @"Name of the ClothesShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementConfectionery:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameConfectioneryKey", @"Name of the Confectionery point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementDIY:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameDIYKey", @"Name of the DIY point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementFishmonger:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameFishmongerKey", @"Name of the Fishmonger point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementFlorist:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameFloristKey", @"Name of the Florist point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementGardenCentre:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameGardenCentreKey", @"Name of the GardenCentre point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementGiftShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameGiftShopKey", @"Name of the GiftShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementGreengrocer:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameGreengrocerKey", @"Name of the Greengrocer point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementHairdresser:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameHairdresserKey", @"Name of the Hairdresser point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementHifiShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameHifiShopKey", @"Name of the HifiShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementJewellery:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameJewelleryKey", @"Name of the Jewellery point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementKiosk:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameKioskKey", @"Name of the Kiosk point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementLaundrette:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameLaundretteKey", @"Name of the Laundrette point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementMotorbikeShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameMotorbikeShopKey", @"Name of the MotorbikeShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementMusicShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameMusicShopKey", @"Name of the MusicShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementToyShop:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameToyShopKey", @"Name of the ToyShop point category element");
        }
            break;
        case MZMapperPointCategoryShoppingElementMarketPlace:
        {
            retVal = NSLocalizedString(@"PointCategoryShoppingElementNameMarketPlaceKey", @"Name of the MarketPlace point category element");
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

+ (NSString*)nameOfPointCategoryFoodAndDrinkElement:(MZMapperPointCategoryFoodAndDrinkElement)element
{
    NSString* retVal = NSLocalizedString(@"UnnamedPointCategoryElementNameKey", @"Name of a point category element which hasn't got predefined name");
    
    switch (element)
    {
        case MZMapperPointCategoryFoodAndDrinkElementWaterFountain:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNameWaterFountainKey", @"Name of the WaterFountain point category element");
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementVendingMachine:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNameVendingMachineKey", @"Name of the VendingMachine point category element");
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementPub:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNamePubKey", @"Name of the Pub point category element");
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementBar:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNameBarKey", @"Name of the Bar point category element");
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementRestaurant:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNameRestaurantKey", @"Name of the Restaurant point category element");
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementCafe:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNameCafeKey", @"Name of the Cafe point category element");
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementFastFood:
        {
            retVal = NSLocalizedString(@"PointCategoryFoodAndDrinkElementNameFastFoodKey", @"Name of the FastFood point category element");
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

@end
