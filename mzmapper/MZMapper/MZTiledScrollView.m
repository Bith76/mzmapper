//
//  MZTiledScrollView.m
//  MZMapper
//
//  Created by Zalan Mergl on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MZTiledScrollView.h"
#import "MZMapView.h"
#import "MZTiledLayerView.h"
#import "MZDownloader.h"
#import "MZMapperViewController.h"

@implementation MZTiledScrollView

@synthesize controller = _controller;
@synthesize scale = _scale;
@synthesize sourceView = _sourceView;

- (id)initWithFrame:(CGRect)frame source:(MZMapView *)source
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code here.
        
        _sourceView = source;
        
        _scale = 1.0;
        
        [self setDelegate:self];
        
        _mapBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width * 3.0, self.bounds.size.height * 3.0)];
        [_mapBackground setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [self addSubview:_mapBackground];
        
    }
    
    
    self.contentSize = CGSizeMake(self.bounds.size.width * 3.0, self.bounds.size.height * 3.0);
    self.contentInset = UIEdgeInsetsMake(self.bounds.size.height, self.bounds.size.width, self.bounds.size.height, self.bounds.size.width);
    self.contentOffset = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    self.scrollsToTop = NO;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //[self addGestureRecognizer:tap];
    [tap release];
    
    return self;
}

- (void)handleTap:(UITapGestureRecognizer*)gesture
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if ([MZMapperContentManager sharedContentManager].openStreetBugModeIsActive)
    {
        [_controller handleBugTap:gesture];
    }
    else
    {
        
        CGPoint tappedPoint = [gesture locationInView:self];
        
        //    [self selectPoint:tappedPoint];
    }
}

- (void)selectPoint:(CGPoint)point
{
    NSLog(@"mapbgrd.bounds: %@",NSStringFromCGRect(_mapBackground.bounds));
    NSLog(@"mapbgrd.frame: %@",NSStringFromCGRect(_mapBackground.frame));
    NSLog(@"controller.v.bounds: %@",NSStringFromCGRect(_controller.view.bounds));
    NSLog(@"controller.v.frame: %@",NSStringFromCGRect(_controller.view.frame));
    if (CGRectContainsPoint(_mapBackground.bounds, point)) 
    {
        NSLog(@"map tapped at point: %@",NSStringFromCGPoint(point));
        
        for (UIBezierPath* bp in _sourceView.bezierPaths) 
        {
            if ([bp containsPoint:point]) 
            {
                NSLog(@"a tappolt bp: %@",bp);
                _sourceView.selectedPath = bp;
                [_sourceView setNeedsDisplay];
                [self updateBackgroundImage];
                break;
            }
        }
    }
    else 
    {
        NSLog(@"out of bounds");
    }
}

- (void)recenterByX
{
    self.contentOffset = CGPointMake(self.bounds.size.width, self.contentOffset.y);
}

- (void)recenterByY
{
    self.contentOffset = CGPointMake(self.contentOffset.x, self.bounds.size.height);
}

// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterIfNecessary 
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    CGPoint currentOffset = self.contentOffset;
    
    //NSLog(@"currentoffset: %@",NSStringFromCGPoint(currentOffset));

    // x - left
    if (currentOffset.x <= -self.bounds.size.width) 
    {
        [self recenterByX];
        
        _recenteredXTimes--;
    }
    // x - right
    else if (currentOffset.x >= self.contentSize.width) 
    {
        [self recenterByX];
        
        _recenteredXTimes++;
    }
    
    // y - top
    if (currentOffset.y <= -self.bounds.size.height) 
    {
        [self recenterByY];
        
        _recenteredYTimes--;
    }
    // y - bottom
    else if (currentOffset.y >= self.contentSize.height)
    {
        [self recenterByY];
        
        _recenteredYTimes++;
    }
}

//- (void)layoutSubviews 
//{
//    [super layoutSubviews];
//    
//    [self recenterIfNecessary];
//    
//    // tile content in visible bounds
//    //    CGRect visibleBounds = [self convertRect:[self bounds] toView:labelContainerView];
//    //    CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
//    //    CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
//    //    
//    //    [self tileLabelsFromMinX:minimumVisibleX toMaxX:maximumVisibleX];
//}

- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat
{
    NSLog(@"jumpToCoordinatelon: %f lat: %f",lon,lat);
    
    CGFloat bigMapWidthInMapCoordinates = _sourceView.maxLongitude - _sourceView.minLongitude;
    CGFloat bigMapHeightInMapCoordinates = _sourceView.maxLatitude - _sourceView.minLatitude;
    
    CGFloat left = lon - (bigMapWidthInMapCoordinates / 2.0);
    CGFloat bottom = lat - (bigMapHeightInMapCoordinates / 2.0);
    CGFloat right = lon + (bigMapWidthInMapCoordinates / 2.0);
    CGFloat top = lat + (bigMapHeightInMapCoordinates / 2.0);
    
    MZDownloader* downloader = [[MZDownloader alloc] init];
    
    //GET /api/0.6/map?bbox=left,bottom,right,top
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://api.openstreetmap.org/api/0.6/map?bbox=%f,%f,%f,%f",left,bottom,right,top]];
    
    [_controller showMessageViewWithMessage:@"Downloading map..."];
    [_controller showBlockView];
    
    [downloader downloadRequestFromURL:url
                       progressHandler:^(long long totalBytes, long long currentBytes){
                           NSLog(@"download is in progress: %lld/%lld",currentBytes,totalBytes);
                           [_controller showMessageViewWithMessage:[NSString stringWithFormat:@"Downloading map:\t\t\t%.2f MB",currentBytes / 1024.0 / 1024.0]];
                       }
                     completionHandler:^(NSString* resultString){
                         if (![resultString isEqualToString:HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED] && ![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                         {
                             NSLog(@"download finished");
                             //NSLog(@"resultString: %@",resultString);
                             
                             [_controller showMessageViewWithMessage:@"Downloading map:\t\t\tParsolás"];
                             [_sourceView setupWithXML:resultString];
                             
                             [_controller showMessageViewWithMessage:@"Downloading map:\t\t\tRajzolás"];
                             [self updateBackgroundImage];
                             
                             [_mapBackground setHidden:NO];
                             
                             
                             [_controller hideMessageView];
                             [_controller hideBlockView];
                             
                             [self recenterByX];
                             [self recenterByY];
                             
                             _controller.gettingCurrentLocationIsInProgress = NO;
                         }
                     }];
    
    [downloader release];
    [url release];
}

#pragma mark - 
#pragma mark scroll view delegate methods

#pragma mark -
#pragma mark zooming

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    
    // Remove back tiled view.
	[_oldTiledContent removeFromSuperview];
	[_oldTiledContent release];
    
    
    
    // Set the current TiledPDFView to be the old view.
	_oldTiledContent = _tiledContent;
	
	[self addSubview:_oldTiledContent];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"\tview: %@",_tiledContent);
    
    return _tiledContent;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [_mapBackground setFrame:CGRectMake(0.0, 0.0, self.contentSize.width, self.contentSize.height)];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"\tkapott scale: %f",scale);
    
    _scale *= scale;
    
    self.minimumZoomScale = 1.0 / _scale;
    self.maximumZoomScale = 3.5 * self.minimumZoomScale;
    
    CGRect pageRect = self.bounds;
    NSLog(@"\tself.bounds: %@",NSStringFromCGRect(self.bounds));
    pageRect.size = CGSizeMake(pageRect.size.width*3.0*_scale, pageRect.size.height*3.0*_scale);
    
    _sourceView.scale = _scale;
    _sourceView.bounds = CGRectMake(0.0, 0.0, self.frame.size.width* 3.0 * _scale, self.frame.size.height * 3.0 * _scale);
    
    _tiledContent = [[MZTiledLayerView alloc] initWithFrame:pageRect];
    _tiledContent.scale = scale;
    _tiledContent.sourceView = _sourceView;
    
    [self addSubview:_tiledContent];
    
    //[_tiledContent release];     //ez kell szerintem különben csorgunk
    
    // Remove back tiled view
    [_oldTiledContent removeFromSuperview];
}

//We use layoutSubviews to center the PDF page in the view
- (void)layoutSubviews 
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSLog(@"_tiledcontent: %@",_tiledContent);
    NSLog(@"--");
    
    [super layoutSubviews];
    
    
    // recenterIfNecessary method sets the _recenteredXTimes and _recenteredYTimes variables
    [self recenterIfNecessary];
    
    if (_recenteredXTimes || _recenteredYTimes) 
    {
        _outOfBounds = YES;
        
        [_mapBackground setHidden:YES];
    }
    else 
    {
        // observe just the simple borders
        if (self.contentOffset.x < 0.0 || self.contentOffset.x > 2.0 * self.bounds.size.width || self.contentOffset.y < 0.0 || self.contentOffset.y > 2.0 * self.bounds.size.height) 
        {
            _outOfBounds = YES;
        }
        else 
        {
            _outOfBounds = NO;
        }
    }
    
    
    
    
    
    if (!_scrolling) // beginning of scrolling
    {
        
        
        _scrolling = YES;
    }
    else 
    {
//        _scrolledDistance.x = self.contentOffset.x - _startOffset.x;
//        _scrolledDistance.y = self.contentOffset.y - _startOffset.y;
    }
    
//    NSLog(@"startoffset: %@",NSStringFromCGPoint(_startOffset));
//    NSLog(@"scrolleddistance: %@",NSStringFromCGPoint(_scrolledDistance));
    
    
    
    
    
    
    
    
    // center the image as it becomes smaller than the size of the screen
	
//    CGSize boundsSize = self.bounds.size;
//    CGRect frameToCenter = _tiledContent.frame;
//	
//	if (!_tiledContent)
//	{
//		frameToCenter = CGRectZero;
//	}
//    
//	if (!_tiledContent)
//	{
//		frameToCenter = self.bounds;
//	}
//    
//    // center horizontally
//    if (frameToCenter.size.width < boundsSize.width)
//        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
//    else
//        frameToCenter.origin.x = 0;
//    
//    // center vertically
//    if (frameToCenter.size.height < boundsSize.height)
//        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
//    else
//        frameToCenter.origin.y = 0;
//    
//    _tiledContent.frame = frameToCenter;
//    
	// to handle the interaction between CATiledLayer and high resolution screens, we need to manually set the
	// tiling view's contentScaleFactor to 1.0. (If we omitted this, it would be 2.0 on high resolution screens,
	// which would cause the CATiledLayer to ask us for tiles of the wrong scales.)
//#ifndef __IPHONE_OS_VERSION_MAX_ALLOWED >= 4.0
	_tiledContent.contentScaleFactor = 1.0;
//#endif
}



#pragma mark -
#pragma mark scrolling

-(void)scrollViewDidScroll:(UIScrollView *)sender 
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //enshore that the end of scroll is fired because apple are twats...
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3]; 
    
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    
//    NSLog(@"megálltunk");
    _scrolling = NO;
    
    
    
    
    // process scrolled distance
    //ez itt jól kiszámolja az utolsó (start) pozícióból számítva mennyit scrolloztunk
    //de lehet hogy nem használjuk majd fel sehol ezt az információt
/*    CGFloat x = 0.0;
    
    if (_recenteredXTimes == 0) 
    {
        x = self.contentOffset.x - _startOffset.x;
        
        _scrolledDistance.x = x;
    }
    else 
    {
        CGFloat absoluteOriginX = _recenteredXTimes > 0 ? 3.0 * self.bounds.size.width : -self.bounds.size.width;
        x = fabsf(absoluteOriginX - _startOffset.x) + ((abs(_recenteredXTimes) - 1) * 2 * self.bounds.size.width) + fabsf(self.contentOffset.x - self.bounds.size.width);
        
        _scrolledDistance.x = _recenteredXTimes > 0 ? x : -x;
    }
    
    CGFloat y = 0.0;
    
    if (_recenteredYTimes == 0) 
    {
        y = self.contentOffset.y - _startOffset.y;
        
        _scrolledDistance.y = y;
    }
    else 
    {
        CGFloat absoluteOriginY = _recenteredYTimes > 0 ? 3.0 * self.bounds.size.height : -self.bounds.size.height;
        y = fabsf(absoluteOriginY - _startOffset.y) + ((abs(_recenteredYTimes) - 1) * 2 * self.bounds.size.height) + fabsf(self.contentOffset.y - self.bounds.size.height);
        
        _scrolledDistance.y = _recenteredYTimes > 0 ? y : -y;
    }
*/        
    
    
    
    
    
    NSLog(@"ujra kell rajzolnunk: %@",_outOfBounds?@"YES":@"NO");
    //NSLog(@"scrolledDistance: %@",NSStringFromCGPoint(_scrolledDistance));
    
    if (_outOfBounds) 
    {
        //kiszámoljuk, hány pixellel került arrébb a nagy térkép originje
        CGFloat bigMapOriginChangeX = 2.0 * _recenteredXTimes * self.bounds.size.width + (self.contentOffset.x - self.bounds.size.width);
        
        CGFloat bigMapOriginChangeY = 2.0 * _recenteredYTimes * self.bounds.size.height + (self.contentOffset.y - self.bounds.size.height); 

        
//        NSLog(@"bigMapOriginChangeX: %f",bigMapOriginChangeX);
//        NSLog(@"bigMapOriginChangeY: %f",bigMapOriginChangeY);        
        
        
        CGFloat scrolledDistanceInMapCoordinates = 0.0;
        
        // horizontal changes
        CGFloat bigMapWidthInMapCoordinates = _sourceView.maxLongitude - _sourceView.minLongitude;
        
        //NSLog(@"mapWidthInMapCoordinates: %f",bigMapWidthInMapCoordinates);
        
        
        CGFloat onePixelWidthInMapCoordinates = bigMapWidthInMapCoordinates / (self.bounds.size.width * 3.0);
        //NSLog(@"onePixelWidthInMapCoordinates: %0.10f",onePixelWidthInMapCoordinates);
        scrolledDistanceInMapCoordinates = bigMapOriginChangeX * onePixelWidthInMapCoordinates;
        //NSLog(@"scrolledDistanceInMapCoordinates: %f",scrolledDistanceInMapCoordinates);
        
        CGFloat left = _sourceView.minLongitude + scrolledDistanceInMapCoordinates;
        CGFloat right = _sourceView.maxLongitude + scrolledDistanceInMapCoordinates;
        
        // vertical changes
        CGFloat bigMapHeightInMapCoordinates = _sourceView.maxLatitude - _sourceView.minLatitude;
        
        CGFloat onePixelHeightInMapCoordinates = bigMapHeightInMapCoordinates / (self.bounds.size.height * 3.0);
        scrolledDistanceInMapCoordinates = bigMapOriginChangeY * onePixelHeightInMapCoordinates;
        
        CGFloat bottom = _sourceView.minLatitude - scrolledDistanceInMapCoordinates; // TO-DO scrolling up means by us: decrease y coord; means by osm: increase y coord
        CGFloat top = _sourceView.maxLatitude - scrolledDistanceInMapCoordinates;
                
        
        
        
//        NSLog(@"kezdeti koordinatak: %f,%f,%f,%f",_sourceView.minLongitude,_sourceView.minLatitude,_sourceView.maxLongitude,_sourceView.maxLatitude);
//        NSLog(@"egy pixel szelesssege map koordinataban: %f",onePixelHeightInMapCoordinates);
//        NSLog(@"scrolled distance in map coords: %f",scrolledDistanceInMapCoordinates);
//        NSLog(@"ezek lettek: %f,%f,%f,%f",left,bottom,right,top);
        
        
        
        MZDownloader* downloader = [[MZDownloader alloc] init];
        
        //GET /api/0.6/map?bbox=left,bottom,right,top
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://api.openstreetmap.org/api/0.6/map?bbox=%f,%f,%f,%f",left,bottom,right,top]];
        
        [_controller showMessageViewWithMessage:@"Downloading map..."];
        [_controller showBlockView];
        
        [downloader downloadRequestFromURL:url
                           progressHandler:^(long long totalBytes, long long currentBytes){
                               NSLog(@"download is in progress: %lld/%lld",currentBytes,totalBytes);
                               [_controller showMessageViewWithMessage:[NSString stringWithFormat:@"Downloading map:\t\t\t%.2f MB",currentBytes / 1024.0 / 1024.0]];
                           }
                         completionHandler:^(NSString* resultString){
                             NSLog(@"download finished");
                             //NSLog(@"resultString: %@",resultString);
                             
                             [_controller showMessageViewWithMessage:@"Downloading map:\t\t\tParsolás"];
                             [_sourceView setupWithXML:resultString];
                             
                             [_controller showMessageViewWithMessage:@"Downloading map:\t\t\tRajzolás"];
                             [self updateBackgroundImage];
                             
                             [_mapBackground setHidden:NO];
                             
                             
                             [_controller hideMessageView];
                             [_controller hideBlockView];
                             
                             [self recenterByX];
                             [self recenterByY];
                         }];
        
        [downloader release];
        [url release];
    }
    
    
    
    // save actual "origin"
    _startOffset = self.contentOffset;
    
    // reset informations
    _scrolledDistance = CGPointMake(0.0, 0.0);
    _recenteredXTimes = 0;
    _recenteredYTimes = 0;
    _outOfBounds = NO;
}

#pragma mark -
#pragma mark private methods

- (UIImage *)imageFromMap
{
    UIGraphicsBeginImageContextWithOptions(_sourceView.bounds.size, _sourceView.opaque, 0.0);
    
    [_sourceView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)updateBackgroundImage
{
    _mapBackground.image = [self imageFromMap];
}


- (void)dealloc
{
    [_mapBackground release], _mapBackground = nil;
    
    [super dealloc];
}

@end
