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

//- (void)testExample
//{
//    STFail(@"Unit tests are not implemented yet in MZMapperLogicTests");
//}

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
    
    NSLog(@"isequal: %d",[@"emergency:phone" isEqual:fullType]);
    
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

- (void)testRealPositionForNodeMethod
{
    MZNode* node = [[MZNode alloc] init];
    node.latitude = 46.2152;
    node.longitude = 19.3792;
    
    MZMapView* _mapView = [[MZMapView alloc] init];

    NSString* xml = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"melykut_02" ofType:@"osm"] encoding:NSUTF8StringEncoding error:nil];
    
	[_mapView setupWithXML:xml];
    
    CGPoint realPosition = [_mapView realPositionForNode:node];
    
    STAssertEquals(realPosition, CGPointMake(208.702, 87.7451), @"");
}

- (void)testnodeForRealPositionMethod
{
    MZMapView* _mapView = [[MZMapView alloc] init];
    
    NSString* xml = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"melykut_02" ofType:@"osm"] encoding:NSUTF8StringEncoding error:nil];
    
	[_mapView setupWithXML:xml];
    
    MZNode* node = [_mapView nodeForRealPosition:CGPointMake(1576, 957)];
    
    STAssertEquals(node.latitude, 46.2114, @"");
    STAssertEquals(node.longitude, 19.3935, @"");
}


//- (CGPoint)realPositionForNode:(MZNode*)node;
//- (MZNode*)nodeForRealPosition:(CGPoint)point;

@end
