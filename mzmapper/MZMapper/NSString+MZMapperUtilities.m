//
//  NSString+MZMapperUtilities.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//

#import "NSString+MZMapperUtilities.h"


#define UNNAMED_POINT_CATEGORY_ELEMENT_NAME NSLocalizedString(@"UnnamedPointCategoryNameKey", @"Name of a point category which hasn't got predefined name")


@implementation NSString (MZMapperUtilities)

+ (NSString*)nameOfPointCategory:(MZMapperPointCategory)category
{
    NSString* retVal = UNNAMED_POINT_CATEGORY_ELEMENT_NAME;
    
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
        case MZMapperPointCategoryEntertainmentArtsCulture:
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

+ (NSString*)nameOfPointCategoryElement:(NSUInteger)element
{
    NSString* retVal = UNNAMED_POINT_CATEGORY_ELEMENT_NAME;
    
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
        case MZMapperPointCategoryAmenityElementFireStation:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameFireStationKey", @"Name of the FireStation point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementPolice:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNamePoliceKey", @"Name of the Police point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementTownhall:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameTownhallKey", @"Name of the Townhall point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementPlaceOfWorship:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNamePlaceOfWorshipKey", @"Name of the PlaceOfWorship point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementPostOffice:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNamePostOfficeKey", @"Name of the PostOffice point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementPostBox:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNamePostBoxKey", @"Name of the PostBox point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementAtm:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameAtmKey", @"Name of the Atm point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementBank:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameBankKey", @"Name of the Bank point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementRecycling:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameRecyclingKey", @"Name of the Recycling point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementWasteBasket:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameWasteBasketKey", @"Name of the WasteBasket point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementToilet:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameToiletKey", @"Name of the Toilet point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementShelter:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameShelterKey", @"Name of the Shelter point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementHuntingStand:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameHuntingStandKey", @"Name of the HuntingStand point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementBench:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameBenchKey", @"Name of the Bench point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementTelephone:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameTelephoneKey", @"Name of the Telephone point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementPhone:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNamePhoneKey", @"Name of the Phone point category element");
        }
            break;
        case MZMapperPointCategoryAmenityElementTower:
        {
            retVal = NSLocalizedString(@"PointCategoryAmenityElementNameTowerKey", @"Name of the Tower point category element");
        }
            break;
            
            
            
            
            
            
            
            
            
            
            
            
        case MZMapperPointCategoryTourismElementMuseum:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameMuseumKey", @"Name of the Museum point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementArcheologicalSite:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameArcheologicalSiteKey", @"Name of the ArcheologicalSite point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementBattlefield:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameBattlefieldKey", @"Name of the Battlefield point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementCastle:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameCastleKey", @"Name of the Castle point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementMemorial:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameMemorialKey", @"Name of the Memorial point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementMonument:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameMonumentKey", @"Name of the Monument point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementRuins:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameRuinsKey", @"Name of the Ruins point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementPicnicSite:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNamePicnicSiteKey", @"Name of the PicnicSite point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementViewPoint:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameViewPointKey", @"Name of the ViewPoint point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementZoo:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameZooKey", @"Name of the Zoo point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementInformation:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameInformationKey", @"Name of the Information point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementArtWork:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameArtWorkKey", @"Name of the ArtWork point category element");
        }
            break;
        case MZMapperPointCategoryTourismElementThemePark:
        {
            retVal = NSLocalizedString(@"PointCategoryTourismElementNameThemeParkKey", @"Name of the ThemePark point category element");
        }
            break;   
        case MZMapperPointCategoryAccomodationElementHotel:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameHotelKey", @"Name of the Hotel point category element");
        }
            break;
        case MZMapperPointCategoryAccomodationElementMotel:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameMotelKey", @"Name of the Motel point category element");
        }
            break;
        case MZMapperPointCategoryAccomodationElementHostel:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameHostelKey", @"Name of the Hostel point category element");
        }
            break;
        case MZMapperPointCategoryAccomodationElementGuestHouse:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameGuestHouseKey", @"Name of the GuestHouse point category element");
        }
            break;
        case MZMapperPointCategoryAccomodationElementCampSite:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameCampSiteKey", @"Name of the CampSite point category element");
        }
            break;
        case MZMapperPointCategoryAccomodationElementCaravanPark:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameCaravanParkKey", @"Name of the CaravanPark point category element");
        }
            break;
        case MZMapperPointCategoryAccomodationElementAlpineHut:
        {
            retVal = NSLocalizedString(@"PointCategoryAccomodationElementNameAlpineHutKey", @"Name of the AlpineHut point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementAirport:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameAirportKey", @"Name of the Airport point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementAirportTerminal:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameAirportTerminalKey", @"Name of the AirportTerminal point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementAirportGate:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameAirportGateKey", @"Name of the AirportGate point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementHelipad:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameHelipadKey", @"Name of the Helipad point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementRailwayStation:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameRailwayStationKey", @"Name of the RailwayStation point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementTramStop:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameTramStopKey", @"Name of the TramStop point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementBusStation:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameBusStationKey", @"Name of the BusStation point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementBusStop:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameBusStopKey", @"Name of the BusStop point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementCarParking:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameCarParkingKey", @"Name of the CarParking point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementTaxiRank:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameTaxiRankKey", @"Name of the TaxiRank point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementBicycleParking:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameBicycleParkingKey", @"Name of the BicycleParking point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementCarRental:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameCarRentalKey", @"Name of the CarRental point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementBicycleRental:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameBicycleRentalKey", @"Name of the BicycleRental point category element");
        }
            break;
        case MZMapperPointCategoryTransportElementFuel:
        {
            retVal = NSLocalizedString(@"PointCategoryTransportElementNameFuelKey", @"Name of the Fuel point category element");
        }
            break;
        case MZMapperPointCategoryBarrierElementBollard:
        {
            retVal = NSLocalizedString(@"PointCategoryBarrierElementNameBollardKey", @"Name of the Bollard point category element");
        }
            break;
        case MZMapperPointCategoryBarrierElementGate:
        {
            retVal = NSLocalizedString(@"PointCategoryBarrierElementNameGateKey", @"Name of the Gate point category element");
        }
            break;
        case MZMapperPointCategoryBarrierElementLiftGate:
        {
            retVal = NSLocalizedString(@"PointCategoryBarrierElementNameLiftGateKey", @"Name of the LiftGate point category element");
        }
            break;
        case MZMapperPointCategoryBarrierElementCycleBarrier:
        {
            retVal = NSLocalizedString(@"PointCategoryBarrierElementNameCycleBarrierKey", @"Name of the CycleBarrier point category element");
        }
            break;
        case MZMapperPointCategoryBarrierElementBigConcreteBlocks:
        {
            retVal = NSLocalizedString(@"PointCategoryBarrierElementNameBigConcreteBlocksKey", @"Name of the BigConcreteBlocks point category element");
        }
            break;
        case MZMapperPointCategoryBarrierElementTollBooth:
        {
            retVal = NSLocalizedString(@"PointCategoryBarrierElementNameTollBoothKey", @"Name of the TollBooth point category element");
        }
            break;
        case MZMapperPointCategoryPowerElementHighVoltage:
        {
            retVal = NSLocalizedString(@"PointCategoryPowerElementNameHighVoltageKey", @"Name of the HighVoltage point category element");
        }
            break;
        case MZMapperPointCategoryPowerElementPowerPole:
        {
            retVal = NSLocalizedString(@"PointCategoryPowerElementNamePowerPoleKey", @"Name of the PowerPole point category element");
        }
            break;
        case MZMapperPointCategoryPowerElementPlantStation:
        {
            retVal = NSLocalizedString(@"PointCategoryPowerElementNamePlantStationKey", @"Name of the PlantStation point category element");
        }
            break;
        case MZMapperPointCategoryPowerElementTransformer:
        {
            retVal = NSLocalizedString(@"PointCategoryPowerElementNameTransformerKey", @"Name of the Transformer point category element");
        }
            break;
        case MZMapperPointCategoryLanduseElementCemetery:
        {
            retVal = NSLocalizedString(@"PointCategoryLanduseElementNameCemeteryKey", @"Name of the Cemetery point category element");
        }
            break;
        case MZMapperPointCategoryLanduseElementGraveYard:
        {
            retVal = NSLocalizedString(@"PointCategoryLanduseElementNameGraveYardKey", @"Name of the GraveYard point category element");
        }
            break;
        case MZMapperPointCategoryPlacesElementHamlet:
        {
            retVal = NSLocalizedString(@"PointCategoryPlacesElementNameHamletKey", @"Name of the Hamlet point category element");
        }
            break;
        case MZMapperPointCategoryPlacesElementVillage:
        {
            retVal = NSLocalizedString(@"PointCategoryPlacesElementNameVillageKey", @"Name of the Village point category element");
        }
            break;
        case MZMapperPointCategoryPlacesElementTown:
        {
            retVal = NSLocalizedString(@"PointCategoryPlacesElementNameTownKey", @"Name of the Town point category element");
        }
            break;
        case MZMapperPointCategoryPlacesElementSuburb:
        {
            retVal = NSLocalizedString(@"PointCategoryPlacesElementNameSuburbKey", @"Name of the Suburb point category element");
        }
            break;
        case MZMapperPointCategoryPlacesElementCity:
        {
            retVal = NSLocalizedString(@"PointCategoryPlacesElementNameCityKey", @"Name of the City point category element");
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementSwimmingPool:
        {
            retVal = NSLocalizedString(@"PointCategorySportAndLeisureElementNameSwimmingPoolKey", @"Name of the SwimmingPool point category element");
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementPlayground:
        {
            retVal = NSLocalizedString(@"PointCategorySportAndLeisureElementNamePlaygroundKey", @"Name of the Playground point category element");
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementSportCentre:
        {
            retVal = NSLocalizedString(@"PointCategorySportAndLeisureElementNameSportCentreKey", @"Name of the SportCentre point category element");
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementMarina:
        {
            retVal = NSLocalizedString(@"PointCategorySportAndLeisureElementNameMarinaKey", @"Name of the Marina point category element");
        }
            break;
        case MZMapperPointCategorySportAndLeisureElementSlipway:
        {
            retVal = NSLocalizedString(@"PointCategorySportAndLeisureElementNameSlipwayKey", @"Name of the Slipway point category element");
        }
            break;
        case MZMapperPointCategoryHealthcareElementPharmacy:
        {
            retVal = NSLocalizedString(@"PointCategoryHealthcareElementNamePharmacyKey", @"Name of the Pharmacy point category element");
        }
            break;
        case MZMapperPointCategoryHealthcareElementHospital:
        {
            retVal = NSLocalizedString(@"PointCategoryHealthcareElementNameHospitalKey", @"Name of the Hospital point category element");
        }
            break;
        case MZMapperPointCategoryHealthcareElementVeterinary:
        {
            retVal = NSLocalizedString(@"PointCategoryHealthcareElementNameVeterinaryKey", @"Name of the Veterinary point category element");
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCultureElementCinema:
        {
            retVal = NSLocalizedString(@"PointCategoryEntertainmentArtsCultureElementNameCinemaKey", @"Name of the Cinema point category element");
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCultureElementTheatre:
        {
            retVal = NSLocalizedString(@"PointCategoryEntertainmentArtsCultureElementNameTheatreKey", @"Name of the Theatre point category element");
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCultureElementFountain:
        {
            retVal = NSLocalizedString(@"PointCategoryEntertainmentArtsCultureElementNameFountainKey", @"Name of the Fountain point category element");
        }
            break;
        case MZMapperPointCategoryEducationElementKindergarten:
        {
            retVal = NSLocalizedString(@"PointCategoryEducationElementNameKindergartenKey", @"Name of the Kindergarten point category element");
        }
            break;
        case MZMapperPointCategoryEducationElementLibrary:
        {
            retVal = NSLocalizedString(@"PointCategoryEducationElementNameLibraryKey", @"Name of the Library point category element");
        }
            break;
        case MZMapperPointCategoryEducationElementSchool:
        {
            retVal = NSLocalizedString(@"PointCategoryEducationElementNameSchoolKey", @"Name of the School point category element");
        }
            break;
        default:
            break;
    }
    
    return retVal;
}

+ (NSString*)loginPath
{
    return @"http://api06.dev.openstreetmap.org/api/0.6";
    //return @"http://api.openstreetmap.org/api/0.6";
}

@end
