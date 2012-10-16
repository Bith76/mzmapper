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

@class MZMessageView;
@class MZPullView;
@class MZLoupeView;
@class MZLoginViewController;

@interface MZMapperViewController : UIViewController <CLLocationManagerDelegate, MZLoginViewControllerDelegate>
{
    MZTiledScrollView*      _scrollView;
	MZMapView*              _map;
    MZPullView*             _pullView;
    BOOL                    _gettingCurrentLocationIsInProgress;
    BOOL                    _editingModeIsActive;
    BOOL                    _waitingForLogInToSwitchToEditingMode;
    
    @private
    MZMessageView*          _messageView;
    CLLocationManager*      _locationManager;
    UIButton*               _currentLocButton;
    UIButton*               _searchButton;
    UIButton*               _editButton;
    MZLoupeView*            _loupeView;
    MZLoginViewController*  _loginViewController;
}

@property (nonatomic, assign)   BOOL gettingCurrentLocationIsInProgress;

- (void)showMessageViewWithMessage:(NSString*)message;
- (void)hideMessageView;
- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat;

@end
