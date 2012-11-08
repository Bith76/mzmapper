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


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
