//
//  MZMapperLogicTests.m
//  MZMapperLogicTests
//
//  Created by Zalán Mergl on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZMapperLogicTests.h"
#import "MZNode.h"
#import "MZMapView.h"

@implementation MZMapperLogicTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTypeNameInServerRepresentationForNodeMethod
{
    MZNode* aNode = [[MZNode alloc] init];
    [aNode.tags setValue:@"supermarket" forKey:@"shop"];
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* type = [cm typeNameInServerRepresentationForNode:aNode];
    
    STAssertEquals(type, @"shop", @"");
}

- (void)testSubTypeNameInServerRepresentationForNodeMethod
{
    MZNode* aNode = [[MZNode alloc] init];
    [aNode.tags setValue:@"shelter" forKey:@"amenity"];
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* subType = [cm subTypeNameInServerRepresentationForNode:aNode];
    
    STAssertEquals(subType, @"shelter", @"");
}

- (void)testFullTypeNameInServerRepresentationForNodeMethod
{
    MZNode* aNode = [[MZNode alloc] init];
    [aNode.tags setValue:@"phone" forKey:@"emergency"];
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* fullType = [cm fullTypeNameInServerRepresentationForNode:aNode];
        
    STAssertEqualObjects(fullType, @"emergency:phone", @"");
}

- (void)testTypeNameInServerRepresentationForLogicalTypeMethod
{
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* type = [cm typeNameInServerRepresentationForLogicalType:MZMapperPointCategoryTourismElementBattlefield];
    
    STAssertEqualObjects(type, @"historic", @"");
}

- (void)testSubTypeNameInServerRepresentationForLogicalTypeMethod
{
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* subType = [cm subTypeNameInServerRepresentationForLogicalType:MZMapperPointCategoryShoppingElementMusicShop];
    
    STAssertEqualObjects(subType, @"music", @"");
}

- (void)testFullTypeNameInServerRepresentationForLogicalTypeMethod
{
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* fullType = [cm fullTypeNameInServerRepresentationForLogicalType:MZMapperPointCategoryHealthcareElementHospital];
    
    STAssertEqualObjects(fullType, @"amenity:hospital", @"");
}

- (void)testLogicalTypeForServerTypeNameMethod
{
    NSString* serverTypeName = @"aeroway:aerodrome";
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSUInteger logicalType = [cm logicalTypeForServerTypeName:serverTypeName];
    
    STAssertEqualObjects([NSNumber numberWithUnsignedInteger:logicalType], [NSNumber numberWithUnsignedInteger:MZMapperPointCategoryTransportElementAirport], @"");
}

- (void)testServerTypeNameForLogicalTypeMethod
{
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* serverType = [cm serverTypeNameForLogicalType:MZMapperPointCategorySportAndLeisureElementPlayground];
    
    STAssertEqualObjects(serverType, @"leisure:playground", @"");
}

@end
