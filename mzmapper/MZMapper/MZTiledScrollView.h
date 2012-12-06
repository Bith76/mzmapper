//
//  MZTiledScrollView.h
//  MZMapper
//
//  Created by Zalan Mergl on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class MZMapperViewController;
@class MZTiledLayerView;
@class MZMapView;

@interface MZTiledScrollView : UIScrollView <UIScrollViewDelegate>
{
    MZMapperViewController* _controller;
    
    MZTiledLayerView*       _tiledContent;
    MZTiledLayerView*       _oldTiledContent;
    
    MZMapView*              _sourceView;
    
    CGFloat                 _scale;
    
    UIImageView*            _mapBackground;
    
    BOOL                    _scrolling;
    NSInteger               _recenteredXTimes; // -- if map is recentered from left to center; ++ if map is recentered from right to center
    NSInteger               _recenteredYTimes; // -- if map is recentered from top to center; ++ if map is recentered from bottom to center
    CGPoint                 _startOffset; // 
    CGPoint                 _scrolledDistance; // the actual scrolled distance - from tracking to stop scrollview; by stop reset its value
    BOOL                    _outOfBounds; // YES if the user reaches the bounds of the actual map borders and we must reposition and redraw the map
}

@property (nonatomic, assign) MZMapperViewController*   controller;
@property (nonatomic, assign) CGFloat                   scale;
@property (nonatomic, retain) MZMapView*                sourceView;

- (id)initWithFrame:(CGRect)frame source:(MZMapView*)source;
- (void)updateBackgroundImage;
- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat;

@end
