//
//  UIImage+MZMapperUtilities.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/23/12.
//
//

#import "UIImage+MZMapperUtilities.h"

@implementation UIImage (MZMapperUtilities)

+ (UIImage*)imageForPointCategoryElement:(NSUInteger)element
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
            retVal = [UIImage imageNamed:@"shop_books.png"];
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
            retVal = [UIImage imageNamed:@"shop_laundry.png"];
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
            
            
            
            
            
            
        case MZMapperPointCategoryTourismElementMuseum:
        {
            retVal = [UIImage imageNamed:@"tourism_museum.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementArcheologicalSite:
        {
            retVal = [UIImage imageNamed:@"historic_archaeological_site.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementBattlefield:
        {
            retVal = [UIImage imageNamed:@"historic_battlefield.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementCastle:
        {
            retVal = [UIImage imageNamed:@"historic_castle.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementMemorial:
        {
            retVal = [UIImage imageNamed:@"historic_memorial.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementMonument:
        {
            retVal = [UIImage imageNamed:@"historic_monument.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementRuins:
        {
            retVal = [UIImage imageNamed:@"historic_ruins.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementPicnicSite:
        {
            retVal = [UIImage imageNamed:@"tourism_picnic_site.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementViewPoint:
        {
            retVal = [UIImage imageNamed:@"tourism_viewpoint.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementZoo:
        {
            retVal = [UIImage imageNamed:@"tourism_zoo.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementInformation:
        {
            retVal = [UIImage imageNamed:@"tourism_information.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementArtWork:
        {
            retVal = [UIImage imageNamed:@"tourism_artwork.png"];
        }
            break;
        case MZMapperPointCategoryTourismElementThemePark:
        {
            retVal = [UIImage imageNamed:@"tourism_theme_park.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementHotel:
        {
            retVal = [UIImage imageNamed:@"tourism_hotel.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementMotel:
        {
            retVal = [UIImage imageNamed:@"tourism_motel.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementHostel:
        {
            retVal = [UIImage imageNamed:@"tourism_hostel.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementGuestHouse:
        {
            retVal = [UIImage imageNamed:@"tourism_guest_house.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementCampSite:
        {
            retVal = [UIImage imageNamed:@"tourism_camp_site.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementCaravanPark:
        {
            retVal = [UIImage imageNamed:@"tourism_caravan_site.png"];
        }
            break;
        case MZMapperPointCategoryAccomodationElementAlpineHut:
        {
            retVal = [UIImage imageNamed:@"tourism_alpine_hut.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementAirport:
        {
            retVal = [UIImage imageNamed:@"aeroway_aerodrome.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementAirportTerminal:
        {
            retVal = [UIImage imageNamed:@"aeroway_terminal.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementAirportGate:
        {
            retVal = [UIImage imageNamed:@"aeroway_gate.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementHelipad:
        {
            retVal = [UIImage imageNamed:@"aeroway_helipad.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementRailwayStation:
        {
            retVal = [UIImage imageNamed:@"railway_station.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementTramStop:
        {
            retVal = [UIImage imageNamed:@"railway_tram_stop.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementBusStation:
        {
            retVal = [UIImage imageNamed:@"amenity_bus_station.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementBusStop:
        {
            retVal = [UIImage imageNamed:@"highway_bus_stop.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementCarParking:
        {
            retVal = [UIImage imageNamed:@"amenity_parking.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementTaxiRank:
        {
            retVal = [UIImage imageNamed:@"amenity_taxi.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementBicycleParking:
        {
            retVal = [UIImage imageNamed:@"amenity_bicycle_parking.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementCarRental:
        {
            retVal = [UIImage imageNamed:@"amenity_car_rental.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementBicycleRental:
        {
            retVal = [UIImage imageNamed:@"amenity_bicycle_rental.png"];
        }
            break;
        case MZMapperPointCategoryTransportElementFuel:
        {
            retVal = [UIImage imageNamed:@"amenity_fuel.png"];
        }
            break;
        case MZMapperPointCategoryBarrierElementBollard:
        {
            retVal = [UIImage imageNamed:@"barrier_bollard.png"];
        }
            break;
        case MZMapperPointCategoryBarrierElementGate:
        {
            retVal = [UIImage imageNamed:@"barrier_gate.png"];
        }
            break;
        case MZMapperPointCategoryBarrierElementLiftGate:
        {
            retVal = [UIImage imageNamed:@"barrier_lift_gate.png"];
        }
            break;
        case MZMapperPointCategoryBarrierElementCycleBarrier:
        {
            retVal = [UIImage imageNamed:@"barrier_cycle_barrier.png"];
        }
            break;
        case MZMapperPointCategoryBarrierElementBigConcreteBlocks:
        {
            retVal = [UIImage imageNamed:@"barrier_block.png"];
        }
            break;
        case MZMapperPointCategoryBarrierElementTollBooth:
        {
            retVal = [UIImage imageNamed:@"barrier_toll_booth.png"];
        }
            break;
        case MZMapperPointCategoryPowerElementHighVoltage:
        {
            retVal = [UIImage imageNamed:@"power_tower.png"];
        }
            break;
        case MZMapperPointCategoryPowerElementPowerPole:
        {
            retVal = [UIImage imageNamed:@"power_pole.png"];
        }
            break;
        case MZMapperPointCategoryPowerElementPlantStation:
        {
            retVal = [UIImage imageNamed:@"power_station.png"];
        }
            break;
        case MZMapperPointCategoryPowerElementSubstation:
        {
            retVal = [UIImage imageNamed:@"power_sub_station.png"];
        }
            break;
        case MZMapperPointCategoryPowerElementTransformer:
        {
            retVal = [UIImage imageNamed:@"power_generator.png"];
        }
            break;
        case MZMapperPointCategoryLanduseElementCemetery:
        {
            retVal = [UIImage imageNamed:@"landuse_cemetery.png"];
        }
            break;
        case MZMapperPointCategoryLanduseElementGraveYard:
        {
            retVal = [UIImage imageNamed:@"amenity_grave_yard.png"];
        }
            break;
        case MZMapperPointCategoryPlacesElementHamlet:
        {
            retVal = [UIImage imageNamed:@"place_hamlet.png"];
        }
            break;
        case MZMapperPointCategoryPlacesElementVillage:
        {
            retVal = [UIImage imageNamed:@"place_village.png"];
        }
            break;
        case MZMapperPointCategoryPlacesElementTown:
        {
            retVal = [UIImage imageNamed:@"place_town.png"];
        }
            break;
        case MZMapperPointCategoryPlacesElementSuburb:
        {
            retVal = [UIImage imageNamed:@"place_suburb.png"];
        }
            break;
        case MZMapperPointCategoryPlacesElementCity:
        {
            retVal = [UIImage imageNamed:@"place_city.png"];
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementSwimmingPool:
        {
            retVal = [UIImage imageNamed:@"leisure_swimming.png"];
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementPlayground:
        {
            retVal = [UIImage imageNamed:@"amenity_playground.png"];
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementSportCentre:
        {
            retVal = [UIImage imageNamed:@"leisure_sports_centre.png"];
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementMarina:
        {
            retVal = [UIImage imageNamed:@"leisure_marina.png"];
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementSlipway:
        {
            retVal = [UIImage imageNamed:@"leisure_slipway.png"];
        }
            break;
        case MZMapperPointCategoryHealthcareElementPharmacy:
        {
            retVal = [UIImage imageNamed:@"amenity_pharmacy.png"];
        }
            break;
        case MZMapperPointCategoryHealthcareElementHospital:
        {
            retVal = [UIImage imageNamed:@"amenity_hospital.png"];
        }
            break;
        case MZMapperPointCategoryHealthcareElementVeterinary:
        {
            retVal = [UIImage imageNamed:@"amenity_veterinary.png"];
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCultureElementCinema:
        {
            retVal = [UIImage imageNamed:@"amenity_cinema.png"];
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCultureElementTheatre:
        {
            retVal = [UIImage imageNamed:@"amenity_theatre.png"];
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCultureElementFountain:
        {
            retVal = [UIImage imageNamed:@"amenity_fountain.png"];
        }
            break;
        case MZMapperPointCategoryEducationElementKindergarten:
        {
            retVal = [UIImage imageNamed:@"amenity_kindergarten.png"];
        }
            break;
        case MZMapperPointCategoryEducationElementLibrary:
        {
            retVal = [UIImage imageNamed:@"amenity_library.png"];
        }
            break;
        case MZMapperPointCategoryEducationElementSchool:
        {
            retVal = [UIImage imageNamed:@"amenity_school.png"];
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

@end
