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

#pragma mark -
#pragma mark loading from xib tests

- (void)testStartViewControllerLoadingFromXIB
{
    MZStartViewController* vc = [[MZStartViewController alloc] initWithNibName:@"MZStartViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZStartViewController could not be loaded");
}

- (void)testSearchViewControllerLoadingFromXIB
{
    MZSearchViewController* vc = [[MZSearchViewController alloc] initWithNibName:@"MZSearchViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZSearchViewController could not be loaded");
}

- (void)testLoginViewControllerLoadingFromXIB
{
    MZLoginViewController* vc = [[MZLoginViewController alloc] initWithNibName:@"MZLoginViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZLoginViewController could not be loaded");
}

- (void)testAboutViewControllerLoadingFromXIB
{
    MZAboutViewController* vc = [[MZAboutViewController alloc] initWithNibName:@"MZAboutViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZAboutViewController could not be loaded");
}

- (void)testEditViewControllerLoadingFromXIB
{
    MZEditViewController* vc = [[MZEditViewController alloc] initWithNibName:@"MZEditViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZEditViewController could not be loaded");
}

- (void)testCategoryViewControllerLoadingFromXIB
{
    MZCategoryViewController* vc = [[MZCategoryViewController alloc] initWithNibName:@"MZCategoryViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZCategoryViewController could not be loaded");
}

- (void)testOpenStreetBugsViewControllerLoadingFromXIB
{
    MZOpenStreetBugsViewController* vc = [[MZOpenStreetBugsViewController alloc] initWithNibName:@"MZOpenStreetBugsViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZOpenStreetBugsViewController could not be loaded");
}

- (void)testPointObjectEditorTableViewControllerLoadingFromXIB
{
    MZPointObjectEditorTableViewController* vc = [[MZPointObjectEditorTableViewController alloc] initWithNibName:@"MZPointObjectEditorTableViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZPointObjectEditorTableViewController could not be loaded");
}

- (void)testPointObjectTypeSelectorTableViewControllerLoadingFromXIB
{
    MZPointObjectTypeSelectorTableViewController* vc = [[MZPointObjectTypeSelectorTableViewController alloc] initWithNibName:@"MZPointObjectTypeSelectorTableViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZPointObjectTypeSelectorTableViewController could not be loaded");
}

- (void)testSavingPanelViewControllerLoadingFromXIB
{
    MZSavingPanelViewController* vc = [[MZSavingPanelViewController alloc] initWithNibName:@"MZSavingPanelViewController" bundle:nil];
    
    STAssertNotNil(vc, @"MZSavingPanelViewController could not be loaded");
}

- (void)testBlockView
{
    UIView* mockView = [[UIView alloc] initWithFrame:CGRectZero];
    
    MZBlockView* blockView = [[MZBlockView alloc] initWithView:mockView];
    
    [blockView show];
    
    STAssertNotNil(blockView.superview, @"");
}

@end
