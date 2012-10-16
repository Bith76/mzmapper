//
//  MZTiledLayerView.h
//  MZMapper
//
//  Created by Zalan Mergl on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class MZMapView;

@interface MZTiledLayerView : UIView
{
    CGFloat     _scale;
    MZMapView*  _sourceView;
}

@property (nonatomic, assign) CGFloat       scale;
@property (nonatomic, retain) MZMapView*    sourceView;

@end
