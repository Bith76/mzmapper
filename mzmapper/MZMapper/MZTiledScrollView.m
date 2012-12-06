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
#import "MZRESTRequestManager.h"
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
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.scrollsToTop = NO;
    
    return self;
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
    CGPoint currentOffset = self.contentOffset;
    
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

- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat
{    
    CGFloat bigMapWidthInMapCoordinates = _sourceView.maxLongitude - _sourceView.minLongitude;
    CGFloat bigMapHeightInMapCoordinates = _sourceView.maxLatitude - _sourceView.minLatitude;
    
    CGFloat left = lon - (bigMapWidthInMapCoordinates / 2.0);
    CGFloat bottom = lat - (bigMapHeightInMapCoordinates / 2.0);
    CGFloat right = lon + (bigMapWidthInMapCoordinates / 2.0);
    CGFloat top = lat + (bigMapHeightInMapCoordinates / 2.0);
    
    MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
    
    //GET /api/0.6/map?bbox=left,bottom,right,top
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/map?bbox=%f,%f,%f,%f",[NSString loginPath],left,bottom,right,top]];
    
    [_controller showMessageViewWithMessage:[NSString stringWithFormat:@"%@...",NSLocalizedString(@"DownloadingMapKey", @"Text displays on the message view when map downloading is in progress")]];
    [_controller showBlockView];
    
    [downloader downloadRequestFromURL:url
                       progressHandler:^(long long totalBytes, long long currentBytes){
                           //NSLog(@"download is in progress: %lld/%lld",currentBytes,totalBytes);
                           [_controller showMessageViewWithMessage:[NSString stringWithFormat:@"%@:\t\t\t%.2f MB",NSLocalizedString(@"DownloadingMapKey", @"Text displays on the message view when map downloading is in progress"),currentBytes / 1024.0 / 1024.0]];
                       }
                     completionHandler:^(NSString* resultString){
                         if (![resultString isEqualToString:HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED] && ![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                         {
                             [_sourceView setupWithXML:resultString];
                             
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
#pragma mark zooming

//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
//{    
//    // Remove back tiled view.
//	[_oldTiledContent removeFromSuperview];
//	[_oldTiledContent release];
//    
//    
//    // Set the current TiledPDFView to be the old view.
//	_oldTiledContent = _tiledContent;
//	
//	[self addSubview:_oldTiledContent];
//}
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return _tiledContent;
//}
//
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    [_mapBackground setFrame:CGRectMake(0.0, 0.0, self.contentSize.width, self.contentSize.height)];
//}
//
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
//{
//    _scale *= scale;
//    
//    self.minimumZoomScale = 1.0 / _scale;
//    self.maximumZoomScale = 3.5 * self.minimumZoomScale;
//    
//    CGRect pageRect = self.bounds;
//    pageRect.size = CGSizeMake(pageRect.size.width*3.0*_scale, pageRect.size.height*3.0*_scale);
//    
//    _sourceView.scale = _scale;
//    _sourceView.bounds = CGRectMake(0.0, 0.0, self.frame.size.width* 3.0 * _scale, self.frame.size.height * 3.0 * _scale);
//    
//    _tiledContent = [[MZTiledLayerView alloc] initWithFrame:pageRect];
//    _tiledContent.scale = scale;
//    _tiledContent.sourceView = _sourceView;
//    
//    [self addSubview:_tiledContent];
//    
//    //[_tiledContent release];     //ez kell szerintem különben csorgunk
//    
//    // Remove back tiled view
//    [_oldTiledContent removeFromSuperview];
//}

//We use layoutSubviews to center the PDF page in the view
- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    if (!_controller.editingModeIsActive)
    {
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
    }
    
    if (!_scrolling) // beginning of scrolling
    {
        _scrolling = YES;
    }
}



#pragma mark -
#pragma mark scrolling

-(void)scrollViewDidScroll:(UIScrollView *)sender 
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //enshore that the end of scroll is fired because apple are twats...
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3]; 
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    _scrolling = NO;
    
    if (_outOfBounds && !_controller.editingModeIsActive)
    {
        //kiszámoljuk, hány pixellel került arrébb a nagy térkép originje
        CGFloat bigMapOriginChangeX = 2.0 * _recenteredXTimes * self.bounds.size.width + (self.contentOffset.x - self.bounds.size.width);
        
        CGFloat bigMapOriginChangeY = 2.0 * _recenteredYTimes * self.bounds.size.height + (self.contentOffset.y - self.bounds.size.height); 
        
        CGFloat scrolledDistanceInMapCoordinates = 0.0;
        
        // horizontal changes
        CGFloat bigMapWidthInMapCoordinates = _sourceView.maxLongitude - _sourceView.minLongitude;
        
        CGFloat onePixelWidthInMapCoordinates = bigMapWidthInMapCoordinates / (self.bounds.size.width * 3.0);
        scrolledDistanceInMapCoordinates = bigMapOriginChangeX * onePixelWidthInMapCoordinates;
        
        CGFloat left = _sourceView.minLongitude + scrolledDistanceInMapCoordinates;
        CGFloat right = _sourceView.maxLongitude + scrolledDistanceInMapCoordinates;
        
        // vertical changes
        CGFloat bigMapHeightInMapCoordinates = _sourceView.maxLatitude - _sourceView.minLatitude;
        
        CGFloat onePixelHeightInMapCoordinates = bigMapHeightInMapCoordinates / (self.bounds.size.height * 3.0);
        scrolledDistanceInMapCoordinates = bigMapOriginChangeY * onePixelHeightInMapCoordinates;
        
        CGFloat bottom = _sourceView.minLatitude - scrolledDistanceInMapCoordinates; // TO-DO scrolling up means by us: decrease y coord; means by osm: increase y coord
        CGFloat top = _sourceView.maxLatitude - scrolledDistanceInMapCoordinates;
        
        MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
        
        //GET /api/0.6/map?bbox=left,bottom,right,top
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/map?bbox=%f,%f,%f,%f",[NSString loginPath],left,bottom,right,top]];
        
        [_controller showMessageViewWithMessage:[NSString stringWithFormat:@"%@...",NSLocalizedString(@"DownloadingMapKey", @"Text displays on the message view when map downloading is in progress")]];
        [_controller showBlockView];
        
        [downloader downloadRequestFromURL:url
                           progressHandler:^(long long totalBytes, long long currentBytes){
                               //NSLog(@"download is in progress: %lld/%lld",currentBytes,totalBytes);
                               [_controller showMessageViewWithMessage:[NSString stringWithFormat:@"%@:\t\t\t%.2f MB",NSLocalizedString(@"DownloadingMapKey", @"Text displays on the message view when map downloading is in progress"),currentBytes / 1024.0 / 1024.0]];
                           }
                         completionHandler:^(NSString* resultString){
                             
                             [_sourceView setupWithXML:resultString];
                             
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
