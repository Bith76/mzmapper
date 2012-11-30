//
//  MZMapperApplicationTests.h
//  MZMapperApplicationTests
//
//  Created by Zalán Mergl on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

// Test-subject headers.
#import "MZMapperAppDelegate.h"
#import "MZMapperViewController.h"

// Viewcontrollers with xib
#import "MZStartViewController.h"
#import "MZSearchViewController.h"
#import "MZLoginViewController.h"
#import "MZAboutViewController.h"
#import "MZEditViewController.h"
#import "MZCategoryViewController.h"
#import "MZOpenStreetBugsViewController.h"
#import "MZPointObjectEditorTableViewController.h"
#import "MZPointObjectTypeSelectorTableViewController.h"
#import "MZSavingPanelViewController.h"

@interface MZMapperApplicationTests : SenTestCase
{
    @private
    MZMapperAppDelegate*    mapperAppDelegate;
    MZMapperViewController* mapperViewController;
}
@end
