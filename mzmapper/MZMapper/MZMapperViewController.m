//
//  MZMapperViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MZMapperViewController.h"
#import "MZDownloader.h"
#import "MZMessageView.h"
#import "MZPullView.h"
#import "MZSearchViewController.h"
#import "MZEditViewController.h"
#import "MZLoupeView.h"

@implementation MZMapperViewController

@synthesize gettingCurrentLocationIsInProgress = _gettingCurrentLocationIsInProgress;

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_map) 
	{
		_map = [[MZMapView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width*3, self.view.frame.size.height*3/*self.view.frame.size.width * 360.0 / 412.0*/)];
        
		[_map.layer setNeedsDisplayOnBoundsChange:YES];
        
		_scrollView = [[MZTiledScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height/*self.view.frame.size.width * 360.0 / 412.0*/) source:_map];
        
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        
		_scrollView.maximumZoomScale = 3.5;
		_scrollView.minimumZoomScale = 1.0;
		_scrollView.scale = 1.0;
        _scrollView.controller = self;
        
        [_scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mapbackground.png"]]];
	}
	
	if(![_scrollView superview])
	{
		[self.view addSubview:_scrollView];
        [_scrollView setTag:1];
	}
    
    
    _messageView = [[MZMessageView alloc] initWithFrame:CGRectMake(530.0, self.view.bounds.size.height - 50.0, 480.0, 40.0)];
    _pullView = [[MZPullView alloc] initWithFrame:CGRectMake(0.0, 4.0, 300.0, 740.0)];
    
    [self.view addSubview:_messageView];
    [_messageView setTag:2];
    [self.view addSubview:_pullView];
    [_pullView setTag:3];
    
    
    _currentLocButton = [[UIButton alloc] initWithFrame:CGRectMake(960.0, 20.0, 44.0, 44.0)];
    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(908.0, 20.0, 44.0, 44.0)];
    _editButton = [[UIButton alloc] initWithFrame:CGRectMake(856.0, 20.0, 44.0, 44.0)];
    
    [_editButton setImage:[UIImage imageNamed:@"icon_edit.png"] forState:UIControlStateNormal];
    [_currentLocButton setImage:[UIImage imageNamed:@"icon_current_location.png"] forState:UIControlStateNormal];
    //[_currentLocButton setImage:[UIImage imageNamed:@"icon_current_location_reversed.png"] forState:UIControlStateHighlighted];
    [_searchButton setImage:[UIImage imageNamed:@"icon_search.png"] forState:UIControlStateNormal];
    //[_searchButton setImage:[UIImage imageNamed:@"icon_search_reversed.png"] forState:UIControlStateHighlighted];
    
    [_editButton setExclusiveTouch:YES];
    [_currentLocButton setExclusiveTouch:YES];
    [_searchButton setExclusiveTouch:YES];
    
    [_editButton addTarget:self action:@selector(editButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_currentLocButton addTarget:self action:@selector(currentLocButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_searchButton addTarget:self action:@selector(searchButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_editButton];
    [_editButton setTag:3];
    [self.view addSubview:_currentLocButton];
    [_currentLocButton setTag:4];
    [self.view addSubview:_searchButton];
    [_searchButton setTag:5];
    
    
    _locationManager = [[CLLocationManager alloc] init];
	_locationManager.delegate = self;
	//[_locationManager startUpdatingLocation];
    
    
    //loupe section
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPress];
    [longPress release];

    _loupeView = [[MZLoupeView alloc] initWithFrame:CGRectMake(908.0, 84.0, 100.0, 100.0)];
    [_loupeView setHidden:YES];
    [self.view addSubview:_loupeView];
    [_loupeView setTag:6];
    
    
    //temporary login button
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setFrame:CGRectMake(700.0, 20.0, 60.0, 44.0)];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    _editingModeIsActive = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString* xml = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"melykut_02" ofType:@"osm"] encoding:NSUTF8StringEncoding error:nil];
    
	[_map setupWithXML:xml];
    //    [_map setupWithXML:[[NSBundle mainBundle] pathForResource:@"map" ofType:@"xml"]];
	
    [xml release];
    
    CGFloat width = _map.maxLongitude - _map.minLongitude;
    CGFloat left = _map.minLongitude - width;
    CGFloat right = _map.maxLongitude + width;
    
    CGFloat height = _map.maxLatitude - _map.minLatitude;
    CGFloat bottom = _map.minLatitude - height;
    CGFloat top = _map.maxLatitude + height;
    
    
    
    //    NSLog(@"kezdeti koordinatak: %f,%f,%f,%f",_map.minLongitude,_map.minLatitude,_map.maxLongitude,_map.maxLatitude);
    //    NSLog(@"ezek lettek: %f,%f,%f,%f",left,bottom,right,top);
    //
    //    NSLog(@"downloader is called");
    
    MZDownloader* downloader = [[MZDownloader alloc] init];
    
    //GET /api/0.6/map?bbox=left,bottom,right,top
    //ezt ideiglenesen kikapcsolom, ne töltögessen feleslegesen...
//    [_scrollView updateBackgroundImage];
//    [[((MZMapperAppDelegate*)[[UIApplication sharedApplication] delegate]) startController] hide];
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://api.openstreetmap.org/api/0.6/map?bbox=%f,%f,%f,%f",left,bottom,right,top]];
    
    [downloader downloadRequestFromURL:url
                       progressHandler:^(long long totalBytes, long long currentBytes){
                           //                           NSLog(@"download is in progress: %lld/%lld",currentBytes,totalBytes);
                       }
                     completionHandler:^(NSString* resultString){
                         //                         NSLog(@"download finished");
                         //NSLog(@"resultString: %@",resultString);
                         if (![resultString isEqualToString:HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED] && ![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                         {
                             [_map setupWithXML:resultString];
                             [_scrollView updateBackgroundImage];
                             
                             [[((MZMapperAppDelegate*)[[UIApplication sharedApplication] delegate]) startController] hide];
                         }
                     }];
    
    [downloader release];
    [url release];
}

#pragma mark -
#pragma mark Helper methods

- (void)showMessageViewWithMessage:(NSString*)message
{
    [_messageView showMessage:message];
}

- (void)hideMessageView
{
    [_messageView hide];
}

- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat
{
    [_scrollView jumpToCoordinateLongitude:lon latitude:lat];
}

- (void)enterEditingMode
{
    _editingModeIsActive = YES;
    
    [_editButton setImage:[UIImage imageNamed:@"icon_save.png"] forState:UIControlStateNormal];
    
    
    MZEditViewController* editVC = [[MZEditViewController alloc] initWithNibName:@"MZEditViewController" bundle:nil];
    editVC.controller = self;
    
    [_pullView setContentViewController:editVC];
    
    [editVC release];
    
    
    
    
    [_pullView show];
}

#pragma mark -
#pragma mark Button touched methods

- (void)editButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    
    if (_editingModeIsActive) //saving changed content
    {
        _editingModeIsActive = NO;
        
        [_editButton setImage:[UIImage imageNamed:@"icon_edit.png"] forState:UIControlStateNormal];
    }
    else //entering edit mode
    {
        if (1/*[MZMapperContentManager sharedContentManager].loggedIn*/) //temporarly this functionality is switched off
        {
            [self enterEditingMode];
        }
        else
        {
            _waitingForLogInToSwitchToEditingMode = YES;
            
            _loginViewController = [[MZLoginViewController alloc] initWithNibName:@"MZLoginViewController" bundle:nil];
            [_loginViewController setModalPresentationStyle:UIModalPresentationFormSheet];
            [_loginViewController setDelegate:self];
            
            [self presentViewController:_loginViewController animated:YES completion:nil];
        }
    }
}

- (void)searchButtonTouched:(UIButton*)sender
{
    //    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    MZSearchViewController* searchVC = [[MZSearchViewController alloc] initWithNibName:@"MZSearchViewController" bundle:nil];
    searchVC.controller = self;
    
    [_pullView setContentViewController:searchVC];
    
    [searchVC release];
    
    [_pullView show];
}

- (void)currentLocButtonTouched:(UIButton*)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
//    NSLog(@"gettinginprogress: %i",_gettingCurrentLocationIsInProgress);
    if (!_gettingCurrentLocationIsInProgress) 
    {
        [_locationManager startUpdatingLocation];
    }
}

- (void)loginButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    _loginViewController = [[MZLoginViewController alloc] initWithNibName:@"MZLoginViewController" bundle:nil];
    [_loginViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [_loginViewController setDelegate:self];
    
    [self presentViewController:_loginViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [_locationManager stopUpdatingLocation];
    
    [self showMessageViewWithMessage:[NSString stringWithFormat:@"Location: %.4f, %.4f",newLocation.coordinate.longitude,newLocation.coordinate.latitude]];
    
    [self performSelector:@selector(hideMessageView) withObject:nil afterDelay:3.0];
    
    if (!_gettingCurrentLocationIsInProgress) 
    {
        _gettingCurrentLocationIsInProgress = YES;
        
        [self jumpToCoordinateLongitude:newLocation.coordinate.longitude latitude:newLocation.coordinate.latitude];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [_locationManager stopUpdatingLocation];
    
    [self showMessageViewWithMessage:[NSString stringWithFormat:NSLocalizedString(@"Location manager failed with error: %@", nil),[error localizedDescription]]];
    
    [self performSelector:@selector(hideMessageView) withObject:nil afterDelay:3.0];
}

#pragma mark -
#pragma mark Delegate methods

- (void)loginViewControllerWillDismiss:(MZLoginViewController*)loginViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_waitingForLogInToSwitchToEditingMode && [MZMapperContentManager sharedContentManager].loggedIn)
    {
        [self enterEditingMode];
        
        _waitingForLogInToSwitchToEditingMode = NO;
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)gesture
{
    NSLog(@"self.view: %@",NSStringFromCGPoint([gesture locationInView:self.view]));
    NSLog(@"view: %@",NSStringFromCGPoint([gesture locationInView:_pullView]));
    //NSLog(@"loc: %@",NSStringFromCGPoint([gesture locationInView:self.view]));
    
    //NSLog(@"self.view.frame: %@",NSStringFromCGRect(self.view.frame));
    CGPoint location = [gesture locationInView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [_loupeView setHidden:YES];
        
        [_scrollView selectPoint:_loupeView.touchPointInViewToMagnify];
    }
    else
    {
        CGFloat sizeOfEnlargedArea = 50.0;
        CGFloat borderWidth = sizeOfEnlargedArea / 2.0;
        
        // Set limiters
        if (location.x < borderWidth)
        {
            NSLog(@"védelemx<");
            location.x = borderWidth;
        }
        if (location.x > self.view.bounds.size.width - borderWidth)
        {
            NSLog(@"védelemx>");
            location.x = self.view.bounds.size.width - borderWidth;
        }
        if (location.y < borderWidth)
        {
            NSLog(@"védelemy<");
            location.y = borderWidth;
        }
        if (location.y > self.view.bounds.size.height - borderWidth)
        {
            NSLog(@"védelemy>");
            location.y = self.view.bounds.size.height - borderWidth;
        }
        
        CGPoint offset = _scrollView.contentOffset;
        
        location.x += offset.x;
        location.y += offset.y;
        
        //        CGPoint offset = _scrollView.contentOffset;
        //
        //        // Make rect around the touched point
        //        CGRect rect = CGRectMake(offset.x + location.x - (sizeOfEnlargedArea / 2.0), offset.y + location.y - (sizeOfEnlargedArea / 2.0), sizeOfEnlargedArea, sizeOfEnlargedArea);
        //
        //        // Create bitmap image from original image data, using rectangle to specify desired crop area
        //        UIGraphicsBeginImageContextWithOptions(_map.bounds.size, _map.opaque, 0.0);
        //
        //        [_map.layer renderInContext:UIGraphicsGetCurrentContext()];
        //        UIImage* mapImg = UIGraphicsGetImageFromCurrentImageContext();
        //
        //        UIGraphicsEndImageContext();
        //
        //        CGImageRef imageRef = CGImageCreateWithImageInRect([mapImg CGImage], rect);
        //        UIImage *img = [UIImage imageWithCGImage:imageRef];
        //        CGImageRelease(imageRef);
        
        
        // Create and show the new image from bitmap data
        //_loupeView.zoomImage = img;
        _loupeView.viewToMagnify = _map;
        _loupeView.touchPointInViewToMagnify = location;
        
        // Refresh view
        [_loupeView setNeedsDisplay];
        
        [_loupeView setHidden:NO];
    }
    
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [_map release];
    [_scrollView release];
    [_messageView release];
    [_pullView release];
    [_currentLocButton release];
    [_searchButton release];
    [_editButton release];
    [_loupeView release];
    
    [_locationManager stopUpdatingLocation];
	[_locationManager release];
    
    [super dealloc];
}

@end
