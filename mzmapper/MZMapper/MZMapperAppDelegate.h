//
//  MZMapperAppDelegate.h
//  MZMapper
//
//  Created by Zalan Mergl on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@class MZMapperViewController;
@class MZStartViewController;

@interface MZMapperAppDelegate : NSObject <UIApplicationDelegate>
{
    
}

@property (nonatomic, retain) IBOutlet UIWindow                 *window;
@property (nonatomic, retain) IBOutlet MZMapperViewController   *viewController;
@property (nonatomic, retain) MZStartViewController             *startController;

@end
