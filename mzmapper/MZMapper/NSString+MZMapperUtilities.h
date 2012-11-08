//
//  NSString+MZMapperUtilities.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//


@interface NSString (MZMapperUtilities)

+ (NSString*)nameOfPointCategory:(MZMapperPointCategory)category;

+ (NSString*)nameOfPointCategoryShoppingElement:(MZMapperPointCategoryShoppingElement)element;
+ (NSString*)nameOfPointCategoryFoodAndDrinkElement:(MZMapperPointCategoryFoodAndDrinkElement)element;
+ (NSString*)nameOfPointCategoryAmenityElement:(MZMapperPointCategoryAmenityElement)element;

@end
