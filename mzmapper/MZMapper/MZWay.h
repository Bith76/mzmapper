//
//  MZWay.h
//  MZMapper
//
//  Created by Zalan Mergl on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@interface MZWay : NSObject
{
    NSString*               _wayid;
    NSMutableArray*         _nodes;
    NSMutableDictionary*    _tags;
    
    CGFloat                 _lineWidth;
    UIColor*                _fillColor;
    UIColor*                _strokeColor;
}

@property (nonatomic, retain)   NSString*               wayid;
@property (nonatomic, retain)   NSMutableArray*         nodes;
@property (nonatomic, retain)   NSMutableDictionary*    tags;
@property (nonatomic, assign)   CGFloat                 lineWidth;
@property (nonatomic, retain)   UIColor*                fillColor;
@property (nonatomic, retain)   UIColor*                strokeColor;

@end
