//
//  MZMapperLogicTests.m
//  MZMapperLogicTests
//
//  Created by Zalán Mergl on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZMapperLogicTests.h"
#import "MZNode.h"

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

@end
