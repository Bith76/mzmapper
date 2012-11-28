//
//  MZNode.h
//  MZMapper
//
//  Created by Zalan Mergl on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@interface MZNode : NSObject
{
    CGFloat                 _latitude;
    CGFloat                 _longitude;
    NSString*               _nodeid;
    NSUInteger              _version;
    NSMutableDictionary*    _tags;
}

@property (nonatomic, assign)   CGFloat                 latitude;
@property (nonatomic, assign)   CGFloat                 longitude;
@property (nonatomic, retain)   NSString*               nodeid;
@property (nonatomic, assign)   NSUInteger              version;
@property (nonatomic, retain)   NSMutableDictionary*    tags;

@end
