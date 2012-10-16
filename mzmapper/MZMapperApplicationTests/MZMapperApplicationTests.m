//
//  MZMapperApplicationTests.m
//  MZMapperApplicationTests
//
//  Created by Zalán Mergl on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZMapperApplicationTests.h"

@implementation MZMapperApplicationTests

/* The setUp method is called automatically for each test-case method (methods whose name starts with 'test').
 */
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    mapperAppDelegate       =   [[UIApplication sharedApplication] delegate];
    mapperViewController    =   mapperAppDelegate.viewController;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAppDelegate
{
    STAssertNotNil(mapperAppDelegate, @"Cannot find the application delegate");
}

- (void)testViewController
{
    STAssertNotNil(mapperViewController, @"Cannot find the main view controller");
}

- (void)testViewControllerSubviews
{
    STAssertNotNil([mapperViewController.view viewWithTag:1], @"Cannot find the scroll view");
    STAssertNotNil([mapperViewController.view viewWithTag:2], @"Cannot find the message view");
    STAssertNotNil([mapperViewController.view viewWithTag:3], @"Cannot find the pull view");
    STAssertNotNil([mapperViewController.view viewWithTag:4], @"Cannot find the current location button");
    STAssertNotNil([mapperViewController.view viewWithTag:5], @"Cannot find the search button");
    STAssertNotNil([mapperViewController.view viewWithTag:6], @"Cannot find the loupe view");
}

@end
