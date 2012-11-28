//
//  MZMapperViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MZMapView.h"
#import "MZTiledScrollView.h"
#import "MZLoginViewController.h"
#import "MZBlockView.h"
#import "MZUploadManager.h"

@class MZMessageView;
@class MZPullView;
@class MZLoupeView;
@class MZLoginViewController;
@class MZNode;

@interface MZMapperViewController : UIViewController <CLLocationManagerDelegate, MZLoginViewControllerDelegate, MZUploadManagerDelegate>
{
    MZTiledScrollView*      _scrollView;
	MZMapView*              _map;
    MZPullView*             _pullView;
    BOOL                    _gettingCurrentLocationIsInProgress;
    BOOL                    _editingModeIsActive;
    BOOL                    _waitingForLogInToSwitchToEditingMode;
    
    MZNode*                 _selectedPointObject;
    MZNode*                 _newlyAddedPointObject;
    
    @private
    MZMessageView*          _messageView;
    MZBlockView*            _blockView;
    CLLocationManager*      _locationManager;
    UIButton*               _currentLocButton;
    UIButton*               _searchButton;
    UIButton*               _editButton;
    UIButton*               _openStreetBugButton;
    MZLoupeView*            _loupeView;
    MZLoginViewController*  _loginViewController;
    NSMutableArray*         _openStreetBugs;
    UIView*                 _openStreetBugView;
    
    UIView*                 _pointObjectsLayerView;
    UIView*                 _selectedPointObjectBackgroundView;
    UIImageView*            _imageViewForNewlyAddedPointObject;
    NSUInteger              _indexOfNewlyAddedNode;
}

@property (nonatomic, assign)   BOOL gettingCurrentLocationIsInProgress;
@property (nonatomic, retain)   MZNode* selectedPointObject;

- (void)showMessageViewWithMessage:(NSString*)message;
- (void)hideMessageView;
- (void)showBlockView;
- (void)hideBlockView;
- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat;
- (void)handleBugTap:(UITapGestureRecognizer*)gesture;
- (void)refreshOpenStreetBugs;

- (void)addedPointObjectWithType:(NSUInteger)aType toPoint:(CGPoint)aPoint;

- (void)deleteEditedPointObject;


@end
