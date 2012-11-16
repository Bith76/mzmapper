//
//  Way.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/12/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Node;

@interface Way : NSManagedObject

@property (nonatomic, retain) NSString * wayid;
@property (nonatomic, retain) id tags;
@property (nonatomic, retain) NSSet *nodes;
@end

@interface Way (CoreDataGeneratedAccessors)

- (void)addNodesObject:(Node *)value;
- (void)removeNodesObject:(Node *)value;
- (void)addNodes:(NSSet *)values;
- (void)removeNodes:(NSSet *)values;

@end
