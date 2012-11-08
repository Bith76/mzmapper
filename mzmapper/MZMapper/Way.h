//
//  Way.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/8/12.
//
//

#import <CoreData/CoreData.h>

@interface Way : NSManagedObject

@property (nonatomic, retain)   NSString*               wayid;
@property (nonatomic, retain)   NSMutableArray*         nodes;
@property (nonatomic, retain)   NSMutableDictionary*    tags;

@end

@interface Way (CoreDataGeneratedAccessors)
- (void)addNodeObject:(NSManagedObject *)value;
- (void)removeNodeObject:(NSManagedObject *)value;
- (void)addNodes:(NSMutableArray *)value;
- (void)removeNodes:(NSMutableArray *)value;
@end