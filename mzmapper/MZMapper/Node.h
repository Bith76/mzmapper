//
//  Node.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/8/12.
//
//

#import <CoreData/CoreData.h>

@class Way;

@interface Node : NSManagedObject

@property (nonatomic, assign)   CGFloat                 latitude;
@property (nonatomic, assign)   CGFloat                 longitude;
@property (nonatomic, retain)   NSString*               nodeid;
@property (nonatomic, retain)   Way*                    way;
@property (nonatomic, retain)   NSMutableDictionary*    tags;

@end
