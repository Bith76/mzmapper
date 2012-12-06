//
//  MZMapView.h
//  MZMapper
//
//  Created by Zalan Mergl on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class MZNode;
@class MZWay;

@interface MZMapView : UIView <NSXMLParserDelegate>
{
    NSXMLParser*            _parser;
    
    NSMutableDictionary*    _nodes;
    NSMutableArray*         _ways;
    
    NSMutableDictionary*    _levels;
    
    CGFloat                 _minLatitude;
    CGFloat                 _maxLatitude;
    CGFloat                 _minLongitude;
    CGFloat                 _maxLongitude;
    
    MZNode*                 _currentNode;
    MZWay*                  _currentWay;
    
    CGFloat                 _scale;
    
    NSDate*                 _startTime;
    
    BOOL                    _logging;
    
    UIView*                 _pointObjectsLayerView;
}

@property (nonatomic, assign) CGFloat           minLatitude;
@property (nonatomic, assign) CGFloat           maxLatitude;
@property (nonatomic, assign) CGFloat           minLongitude;
@property (nonatomic, assign) CGFloat           maxLongitude;
@property (nonatomic, assign) CGFloat           scale;

- (void)setupWithXML:(NSString*)xml;

- (CGPoint)realPositionForNode:(MZNode*)node;
- (MZNode*)nodeForRealPosition:(CGPoint)point;

@end
