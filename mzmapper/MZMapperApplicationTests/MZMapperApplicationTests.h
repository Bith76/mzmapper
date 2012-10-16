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

@interface MZMapperApplicationTests : SenTestCase
{
    @private
    MZMapperAppDelegate*    mapperAppDelegate;
    MZMapperViewController* mapperViewController;
}
@end
