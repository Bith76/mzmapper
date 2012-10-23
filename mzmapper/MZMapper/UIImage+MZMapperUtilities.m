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
//enum
//{
//    MZMapperPointCategoryShoppingElementSupermarket = 0,
//    MZMapperPointCategoryShoppingElementSmallConvenienceStore,
//    MZMapperPointCategoryShoppingElementBakery,
//    MZMapperPointCategoryShoppingElementAlcoholShop,
//    MZMapperPointCategoryShoppingElementBikeShop,
//    MZMapperPointCategoryShoppingElementBookShop,
//    MZMapperPointCategoryShoppingElementButcher,
//    MZMapperPointCategoryShoppingElementCarSales,
//    MZMapperPointCategoryShoppingElementCarRepair,
//    MZMapperPointCategoryShoppingElementClothesShop,
//    MZMapperPointCategoryShoppingElementConfectionery,
//    MZMapperPointCategoryShoppingElementDIY,
//    MZMapperPointCategoryShoppingElementFishmonger,
//    MZMapperPointCategoryShoppingElementFlorist,
//    MZMapperPointCategoryShoppingElementGardenCentre,
//    MZMapperPointCategoryShoppingElementGiftShop,
//    MZMapperPointCategoryShoppingElementGreengrocer,
//    MZMapperPointCategoryShoppingElementHairdresser,
//    MZMapperPointCategoryShoppingElementHifiShop,
//    MZMapperPointCategoryShoppingElementJewellery,
//    MZMapperPointCategoryShoppingElementKiosk,
//    MZMapperPointCategoryShoppingElementLaundrette,
//    MZMapperPointCategoryShoppingElementMotorbikeShop,
//    MZMapperPointCategoryShoppingElementMusicShop,
//    MZMapperPointCategoryShoppingElementPharmacy,
//    MZMapperPointCategoryShoppingElementToyShop,
//    MZMapperPointCategoryShoppingElementMarketPlace,
//    MZMapperPointCategoryShoppingElementCountOfElements
//};

@end
