//
//  NSString+MZMapperUtilities.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//


@interface NSString (MZMapperUtilities)

+ (NSString*)nameOfPointCategory:(MZMapperPointCategory)category;

+ (NSString*)nameOfPointCategoryElement:(NSUInteger)element;
//+ (NSString*)nameOfPointCategoryShoppingElement:(MZMapperPointCategoryShoppingElement)element;
//+ (NSString*)nameOfPointCategoryFoodAndDrinkElement:(MZMapperPointCategoryFoodAndDrinkElement)element;
//+ (NSString*)nameOfPointCategoryAmenityElement:(MZMapperPointCategoryAmenityElement)element;

+ (NSString*)loginPath;

@end
