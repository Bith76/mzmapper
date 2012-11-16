//
//  Node.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/12/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Node : NSManagedObject

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic, retain) NSString * nodeid;
@property (nonatomic, retain) id tags;

@end
