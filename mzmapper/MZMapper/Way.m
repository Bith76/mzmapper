//
//  Way.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/8/12.
//
//

#import "Way.h"
#import "Node.h"

@implementation Way

@dynamic wayid, nodes, tags;

//Adatok kilistazasa (SELECT * FROM Person ...)
- (void)fetchRequestWayFromCoreData //SELECT
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Way" inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entity];
    
	NSError *error;
	NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil)
	{
		// Handle the error.
	}
	else
	{
        NSInteger index = 0;
		for(Way* wayObj in mutableFetchResults)
		{
			NSLog(@"%i : %@",index, wayObj.wayid);
			for (Node* nodeObj in wayObj.nodes)
			{
				NSLog(@"\t%@", nodeObj);
			}
		}
	}
    
	[mutableFetchResults release];
	[request release];
}


//Adatok kilistazasa szurve es rendezve (SELECT * FROM Person WHERE ... ORDER BY {ASC|DESC} )

//- (void)fetchRequestPersonWithOrderAndPredicateFromCoreData
//{
//	NSFetchRequest *request = [[NSFetchRequest alloc] init];
//	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
//	[request setEntity:entity];
//    
//    
//	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(name = 'Sarah') AND (ANY addresses.country = 'Italy') AND (ANY addresses.city = 'Rome')"];
//	[request setPredicate:predicate];
//    
//    
//	NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//	[sortDescriptor release];
//    
//    
//	NSError *error;
//	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//	if (mutableFetchResults == nil)
//	{
//		// Handle the error.
//	}
//	else
//	{
//        
//		for(Person* personObj in mutableFetchResults)
//		{
//			NSLog(@"%@ : %@",[personObj name], [personObj timeStamp]);
//			for (Address* addressObj in [personObj addresses])
//			{
//				NSLog(@"\t%@", addressObj);
//			}
//		}
//        
//	}
//    
//	[mutableFetchResults release];
//	[request release];
//}
////Adatok kilistazasa tarolt eljarassal
//- (void)fetchRequestPersonWithTemplateFromCoreData //SELECT STORED REQUEST
//{
//    
//	//Stored request in Core Data.
//    
//	NSFetchRequest* requestTemplate = [[NSFetchRequest alloc] init];
//	NSEntityDescription* personEntity = [[self.managedObjectModel entitiesByName] objectForKey:@"Person"];
//	[requestTemplate setEntity:personEntity];
//    
//    
//	NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat: @"(name = $NAME) AND (ANY addresses.country = $COUNTRY)"];
//    
//	[requestTemplate setPredicate:predicateTemplate];
//    
//	[self.managedObjectModel setFetchRequestTemplate:requestTemplate forName:@"PersonAndCountry"];
//	[requestTemplate release];
//    
//    
//    
//	//Call stored request
//    
//	NSError* error = nil;
//	NSDictionary* substitutionDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Joe", @"NAME", @"Germany", @"COUNTRY", nil];
//    
//	NSFetchRequest* fetchRequest = [self.managedObjectModel fetchRequestFromTemplateWithName:@"PersonAndCountry" substitutionVariables:substitutionDictionary];
//    
//	NSMutableArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//	for(Person* personObj in results)
//	{
//		NSLog(@"%@ : %@",[personObj name], [personObj timeStamp]);
//		for (Address* addressObj in [personObj addresses])
//		{
//			NSLog(@"\t%@", addressObj);
//		}
//	}
//    
//}
////Adatok Torlese (osszes) (DELETE FROM Person)
//- (void)deleteAllFromCoreData //DELETE ALL
//{
//	NSEntityDescription* entity = [NSEntityDescription entityForName:@"Way" inManagedObjectContext:self.managedObjectContext];
//	NSFetchRequest* request = [[NSFetchRequest alloc] init];
//	[request setEntity:entity];
//    
//	
//	NSError* error;
//	NSMutableArray* mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
//	for (NSManagedObject* managedObject in mutableFetchResults)
//	{
//		[managedObjectContext deleteObject:managedObject];
//		NSLog(@"object deleted");
//	}
//    
//	if (![managedObjectContext save:&error])
//	{
//		NSLog(@"Error deleting.");
//	}
//}
////Adatok Torlese (szurt) (DELETE FROM Person WHERE ...)
//- (void)deleteFromCoreDataWithPredicate //DELETE WHERE
//{
//	NSEntityDescription* entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
//	NSFetchRequest* request = [[NSFetchRequest alloc] init];
//	[request setEntity:entity];
//    
//	
//	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(name = 'Anna')"];
//	[request setPredicate:predicate];
//    
//    
//	NSError* error;
//	NSMutableArray* mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
//	for (NSManagedObject* managedObject in mutableFetchResults)
//	{
//		[managedObjectContext deleteObject:managedObject];
//		NSLog(@"object deleted");
//	}
//    
//	if (![managedObjectContext save:&error])
//	{
//		NSLog(@"Error deleting.");
//	}
//}
////Adatok Frissetese (UPDATE Person SET ... WHERE ...)
//- (void)updateFromCoreData
//{
//	NSFetchRequest *request = [[NSFetchRequest alloc] init];
//	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Way" inManagedObjectContext:self.managedObjectContext];
//	[request setEntity:entity];
//    
//    
//	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name = 'Joe')"];
//	[request setPredicate:predicate];
//    
//    
//	NSError *error;
//	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//	if (mutableFetchResults == nil)
//	{
//        
//	}
//	else
//	{
//		NSDateFormatter* format = [[NSDateFormatter alloc] init];
//		[format setDateFormat:@"yyyy-MM-dd"];
//		for (Person* obj in mutableFetchResults)
//		{
//			[obj setTimeStamp:[format dateFromString:[NSString stringWithFormat:@"1882-02-23"]]];
//		}
//	}
//    
//	if (![managedObjectContext save:&error])
//	{
//		NSLog(@"Error updating.");
//	}
//    
//	[mutableFetchResults release];
//	[request release];
//}
////Undo management
//- (void)undoManagement
//{
//	[self.managedObjectContext processPendingChanges];  //flush operations for which you want undos
//	[[self.managedObjectContext undoManager] disableUndoRegistration];
//    
//    
//	//make changes for which undo operations are not be recorded
//    
//	[self.managedObjectContext processPendingChanges]; //flush operatons which you do not want undos
//	[[self.managedObjectContext undoManager] enableUndoRegistration];
//}

@end
