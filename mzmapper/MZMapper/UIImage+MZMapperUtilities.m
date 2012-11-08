//
//  UIImage+MZMapperUtilities.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/23/12.
//
//

#import "UIImage+MZMapperUtilities.h"

@implementation UIImage (MZMapperUtilities)

+ (UIImage*)imageForPointCategoryShoppingElement:(MZMapperPointCategoryShoppingElement)element
{
    UIImage* retVal = nil;
    
    switch (element)
    {
        case MZMapperPointCategoryShoppingElementSupermarket:
        {
            retVal = [UIImage imageNamed:@"shop_supermarket.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementSmallConvenienceStore:
        {
            retVal = [UIImage imageNamed:@"shop_convenience.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementBakery:
        {
            retVal = [UIImage imageNamed:@"shop_bakery.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementAlcoholShop:
        {
            retVal = [UIImage imageNamed:@"shop_alcohol.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementBikeShop:
        {
            retVal = [UIImage imageNamed:@"shop_bicycle.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementBookShop:
        {
            retVal = [UIImage imageNamed:@"shop_book.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementButcher:
        {
            retVal = [UIImage imageNamed:@"shop_butcher.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementCarSales:
        {
            retVal = [UIImage imageNamed:@"shop_car.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementCarRepair:
        {
            retVal = [UIImage imageNamed:@"shop_car_repair.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementClothesShop:
        {
            retVal = [UIImage imageNamed:@"shop_clothes.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementConfectionery:
        {
            retVal = [UIImage imageNamed:@"shop_confectionery.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementDIY:
        {
            retVal = [UIImage imageNamed:@"shop_diy.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementFishmonger:
        {
            retVal = [UIImage imageNamed:@"shop_fish.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementFlorist:
        {
            retVal = [UIImage imageNamed:@"shop_florist.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementGardenCentre:
        {
            retVal = [UIImage imageNamed:@"shop_garden_centre.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementGiftShop:
        {
            retVal = [UIImage imageNamed:@"shop_gift.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementGreengrocer:
        {
            retVal = [UIImage imageNamed:@"shop_greengrocer.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementHairdresser:
        {
            retVal = [UIImage imageNamed:@"shop_hairdresser.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementHifiShop:
        {
            retVal = [UIImage imageNamed:@"shop_hifi.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementJewellery:
        {
            retVal = [UIImage imageNamed:@"shop_jewelry.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementKiosk:
        {
            retVal = [UIImage imageNamed:@"shop_kiosk.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementLaundrette:
        {
            retVal = [UIImage imageNamed:@"shop_laundrette.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementMotorbikeShop:
        {
            retVal = [UIImage imageNamed:@"shop_motorcycle.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementMusicShop:
        {
            retVal = [UIImage imageNamed:@"shop_music.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementToyShop:
        {
            retVal = [UIImage imageNamed:@"shop_toys.png"];
        }
            break;
        case MZMapperPointCategoryShoppingElementMarketPlace:
        {
            retVal = [UIImage imageNamed:@"shop_marketplace.png"];
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

+ (UIImage*)imageForPointCategoryFoodAndDrinkElement:(MZMapperPointCategoryFoodAndDrinkElement)element
{
    UIImage* retVal = nil;
    
    switch (element)
    {
        case MZMapperPointCategoryFoodAndDrinkElementWaterFountain:
        {
            retVal = [UIImage imageNamed:@"amenity_drinking_water.png"];
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementVendingMachine:
        {
            retVal = [UIImage imageNamed:@"amenity_vending_machine.png"];
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementPub:
        {
            retVal = [UIImage imageNamed:@"amenity_pub.png"];
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementBar:
        {
            retVal = [UIImage imageNamed:@"amenity_bar.png"];
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementRestaurant:
        {
            retVal = [UIImage imageNamed:@"amenity_restaurant.png"];
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementCafe:
        {
            retVal = [UIImage imageNamed:@"amenity_cafe.png"];
        }
            break;
        case MZMapperPointCategoryFoodAndDrinkElementFastFood:
        {
            retVal = [UIImage imageNamed:@"amenity_fastfood.png"];
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

+ (UIImage*)imageForPointCategoryAmenityElement:(MZMapperPointCategoryAmenityElement)element
{
    UIImage* retVal = nil;
    
    switch (element)
    {
        case MZMapperPointCategoryAmenityElementFireStation:
        {
            retVal = [UIImage imageNamed:@"amenity_firestation.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementPolice:
        {
            retVal = [UIImage imageNamed:@"amenity_police.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementTownhall:
        {
            retVal = [UIImage imageNamed:@"amenity_town_hall.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementPlaceOfWorship:
        {
            retVal = [UIImage imageNamed:@"amenity_place_of_worship.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementPostOffice:
        {
            retVal = [UIImage imageNamed:@"amenity_post_office.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementPostBox:
        {
            retVal = [UIImage imageNamed:@"amenity_post_box.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementAtm:
        {
            retVal = [UIImage imageNamed:@"amenity_atm.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementBank:
        {
            retVal = [UIImage imageNamed:@"amenity_bank.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementRecycling:
        {
            retVal = [UIImage imageNamed:@"amenity_recycling.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementWasteBasket:
        {
            retVal = [UIImage imageNamed:@"amenity_waste_basket.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementToilet:
        {
            retVal = [UIImage imageNamed:@"amenity_toilet.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementShelter:
        {
            retVal = [UIImage imageNamed:@"amenity_shelter.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementHuntingStand:
        {
            retVal = [UIImage imageNamed:@"amenity_hunting_stand.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementBench:
        {
            retVal = [UIImage imageNamed:@"amenity_bench.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementTelephone:
        {
            retVal = [UIImage imageNamed:@"amenity_telephone.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementPhone:
        {
            retVal = [UIImage imageNamed:@"emergency_phone.png"];
        }
            break;
        case MZMapperPointCategoryAmenityElementTower:
        {
            retVal = [UIImage imageNamed:@"man_made_tower.png"];
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

@end
