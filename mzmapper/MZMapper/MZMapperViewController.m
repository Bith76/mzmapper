//
//  MZMapperViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MZMapperViewController.h"
#import "MZRESTRequestManager.h"
#import "MZMessageView.h"
#import "MZPullView.h"
#import "MZSearchViewController.h"
#import "MZEditViewController.h"
#import "MZLoupeView.h"
#import "MZOpenStreetBugsViewController.h"
#import "MZOpenStreetBug.h"
#import "MZNode.h"
#import "MZPointObjectEditorTableViewController.h"
#import "MZDraggedCategoryItemView.h"
#import "MZUploadManager.h"
#import "MZAboutViewController.h"
#import "MZScaleView.h"

@implementation MZMapperViewController

@synthesize gettingCurrentLocationIsInProgress = _gettingCurrentLocationIsInProgress;
@synthesize selectedPointObject = _selectedPointObject;
@synthesize editingModeIsActive = _editingModeIsActive;

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
        
		_scrollView.maximumZoomScale = /*3.5*/1.0; //temporarly disable zooming
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
    
    _scaleView = [[MZScaleView alloc] init];
    [_scaleView setDisplayString:@"x m"];
    [_scaleView setFrame:CGRectMake(300.0, self.view.bounds.size.height - 30.0, 174.5, 20.0)];
    [self.view addSubview:_scaleView];
    [_scaleView release];
    
    _messageView = [[MZMessageView alloc] initWithFrame:CGRectMake(530.0, self.view.bounds.size.height - 50.0, 480.0, 40.0)];
    _pullView = [[MZPullView alloc] initWithFrame:CGRectMake(0.0, 4.0, 300.0, 740.0)];
    
    [self.view addSubview:_messageView];
    [_messageView setTag:2];
    [self.view addSubview:_pullView];
    [_pullView setTag:3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustScaleView) name:@"PullViewToggledState" object:nil];
    
    _currentLocButton = [[UIButton alloc] initWithFrame:CGRectMake(960.0, 20.0, 44.0, 44.0)];
    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(908.0, 20.0, 44.0, 44.0)];
    _editButton = [[UIButton alloc] initWithFrame:CGRectMake(856.0, 20.0, 44.0, 44.0)];
    _openStreetBugButton = [[UIButton alloc] initWithFrame:CGRectMake(804.0, 20.0, 44.0, 44.0)];
    
    [_editButton setImage:[UIImage imageNamed:@"icon_edit.png"] forState:UIControlStateNormal];
    [_currentLocButton setImage:[UIImage imageNamed:@"icon_current_location.png"] forState:UIControlStateNormal];
    //[_currentLocButton setImage:[UIImage imageNamed:@"icon_current_location_reversed.png"] forState:UIControlStateHighlighted];
    [_searchButton setImage:[UIImage imageNamed:@"icon_search.png"] forState:UIControlStateNormal];
    //[_searchButton setImage:[UIImage imageNamed:@"icon_search_reversed.png"] forState:UIControlStateHighlighted];
    [_openStreetBugButton setImage:[UIImage imageNamed:@"icon_bug.png"] forState:UIControlStateNormal];
    
    [_editButton setExclusiveTouch:YES];
    [_currentLocButton setExclusiveTouch:YES];
    [_searchButton setExclusiveTouch:YES];
    [_openStreetBugButton setExclusiveTouch:YES];
    
    [_editButton addTarget:self action:@selector(editButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_currentLocButton addTarget:self action:@selector(currentLocButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_searchButton addTarget:self action:@selector(searchButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_openStreetBugButton addTarget:self action:@selector(openStreetBugsButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_editButton];
    [_editButton setTag:3];
    [self.view addSubview:_currentLocButton];
    [_currentLocButton setTag:4];
    [self.view addSubview:_searchButton];
    [_searchButton setTag:5];
    [self.view addSubview:_openStreetBugButton];
    [_openStreetBugButton setTag:6];
    
    
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
    
    _editingModeIsActive = NO;
    
    _openStreetBugs = [[NSMutableArray alloc] init];
    
    _blockView = [[MZBlockView alloc] initWithView:self.view];
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
    
    
    CLLocation* bottomLeftLocation = [[CLLocation alloc] initWithLatitude:bottom longitude:left];
    CLLocation* bottomRightLocation = [[CLLocation alloc] initWithLatitude:bottom longitude:right];
    
    //represent a distance in meters
    CGFloat distance = [bottomLeftLocation distanceFromLocation:bottomRightLocation];
    CGFloat mapWidth = _map.frame.size.width;
    
    NSLog(@"távolság: %f",distance);
    NSLog(@"térképszélesség: %f",mapWidth);
    
    CGFloat displayableMeters = (distance * _scaleView.frame.size.width) / mapWidth;
    [_scaleView setDisplayString:[NSString stringWithFormat:@"%.0f m", displayableMeters]];
    
    
    //    NSLog(@"kezdeti koordinatak: %f,%f,%f,%f",_map.minLongitude,_map.minLatitude,_map.maxLongitude,_map.maxLatitude);
    //    NSLog(@"ezek lettek: %f,%f,%f,%f",left,bottom,right,top);
    //
    //    NSLog(@"downloader is called");
    
    MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
    
    //GET /api/0.6/map?bbox=left,bottom,right,top
    //ezt ideiglenesen kikapcsolom, ne töltögessen feleslegesen...
//    [_scrollView updateBackgroundImage];
//    [[((MZMapperAppDelegate*)[[UIApplication sharedApplication] delegate]) startController] hide];
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/map?bbox=%f,%f,%f,%f",[NSString loginPath],left,bottom,right,top]];
    
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
                             
                             
                             [self showAboutVC];
                             
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

- (void)showBlockView
{
    [_blockView show];
}

- (void)hideBlockView
{
    [_blockView hide];
}

- (void)jumpToCoordinateLongitude:(CGFloat)lon latitude:(CGFloat)lat
{
    [_scrollView jumpToCoordinateLongitude:lon latitude:lat];
}

- (void)enterEditingMode
{
    _editingModeIsActive = YES;
    
    [_editButton setImage:[UIImage imageNamed:@"icon_save.png"] forState:UIControlStateNormal];
    
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    cm.deletedPointObjects = [NSMutableArray array];
    cm.addedPointObjects = [NSMutableArray array];
    cm.updatedPointObjects = [NSMutableArray array];
    
    [self animateButtonsOut];
    
    [self updatePointObjectsLayerView];
    
    [self showEditVC];
}

- (void)exitFromEditingMode
{
    [_editButton setImage:[UIImage imageNamed:@"icon_edit.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(animateButtonsIn) withObject:nil afterDelay:0.8];
    
    _editingModeIsActive = NO;
    
    [_pointObjectsLayerView removeFromSuperview];
    [_pointObjectsLayerView release], _pointObjectsLayerView = nil;
    
    //create and set the about view controller
    MZAboutViewController* aboutVC = [[MZAboutViewController alloc] initWithNibName:@"MZAboutViewController" bundle:nil];
    
    [_pullView setContentViewController:aboutVC];
    
    [aboutVC release];
}

- (void)animateButtonsOut
{
    NSLog(@"bugframe: %@",NSStringFromCGRect(_openStreetBugButton.frame));
        NSLog(@"editframe: %@",NSStringFromCGRect(_editButton.frame));
    //animate edit button to the right
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_editButton setFrame:_currentLocButton.frame];
        
    } completion:nil];
    
    //animate open street bugs button to the right
    [UIView animateWithDuration:0.15 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_openStreetBugButton setFrame:_searchButton.frame];
    } completion:nil];
    
    //animate current loc button out
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect currentLocButtonFrame = _currentLocButton.frame;
        currentLocButtonFrame.origin.y -= 100.0;
        [_currentLocButton setFrame:currentLocButtonFrame];
        [_currentLocButton setAlpha:0.0];
    } completion:nil];
    
    //animate search button out
    [UIView animateWithDuration:0.15 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect searchButtonFrame = _searchButton.frame;
        searchButtonFrame.origin.y -= 100.0;
        [_searchButton setFrame:searchButtonFrame];
        [_searchButton setAlpha:0.0];
    } completion:nil];
}

- (void)animateButtonsIn
{
    //animate current loc button in
    [UIView animateWithDuration:0.15 delay:0.00 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_currentLocButton setFrame:_editButton.frame];
        [_currentLocButton setAlpha:1.0];
    } completion:nil];
    
    //animate search button in
    [UIView animateWithDuration:0.15 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_searchButton setFrame:_openStreetBugButton.frame];
        [_searchButton setAlpha:1.0];
    } completion:nil];
    
    //animate open street bugs button to the left
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect openStreetBugButtonFrame = _openStreetBugButton.frame;
        openStreetBugButtonFrame.origin.x = 804.0;
        [_openStreetBugButton setFrame:openStreetBugButtonFrame];
    } completion:nil];
    
    //animate edit button to the left
    [UIView animateWithDuration:0.15 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect editButtonFrame = _editButton.frame;
        editButtonFrame.origin.x = 856.0;
        [_editButton setFrame:editButtonFrame];
    } completion:nil];
}

- (void)updatePointObjectsLayerView
{
    if (_pointObjectsLayerView)
    {
        [_pointObjectsLayerView removeFromSuperview];
        
        [_pointObjectsLayerView release], _pointObjectsLayerView = nil;
    }
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    //set point objects into editing mode
    _pointObjectsLayerView = [[UIView alloc] initWithFrame:_map.bounds];
    
    //iterate through the actual point objects
    for (MZNode* node in cm.actualPointObjects)
    {
        //get the image name of the point object
        NSString* type = [cm typeNameInServerRepresentationForNode:node];
        NSString* subType = [cm subTypeNameInServerRepresentationForNode:node];
        
        NSString* imageName = [NSString stringWithFormat:@"%@_%@.png", type ,subType];
        
        //create and add image to the pointObjectsLayerView
        UIImageView* imageViewForPointObject = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [imageViewForPointObject setCenter:[_map realPositionForNode:node]];
        [imageViewForPointObject setUserInteractionEnabled:YES];
        [imageViewForPointObject setTag:[node.nodeid integerValue]];
        
        [_pointObjectsLayerView addSubview:imageViewForPointObject];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePointObjectTap:)];
        [imageViewForPointObject addGestureRecognizer:tap];
        
        [tap release];
        
        [imageViewForPointObject release];
    }
    
    [_scrollView addSubview:_pointObjectsLayerView];
}

- (void)showEditVC
{
    //create and pull in the edit view controller
    MZEditViewController* editVC = [[MZEditViewController alloc] initWithNibName:@"MZEditViewController" bundle:nil];
    editVC.controller = self;
    
    [_pullView setContentViewController:editVC];
    
    [editVC release];
    
    [_pullView show];
}

- (void)showAboutVC
{
    //create and pull in the about view controller
    MZAboutViewController* aboutVC = [[MZAboutViewController alloc] initWithNibName:@"MZAboutViewController" bundle:nil];
    
    [_pullView setContentViewController:aboutVC];
    
    [aboutVC release];
    
    [_pullView show];
}

- (void)adjustScaleView
{
    if (_pullView.shown)
    {
        //_pullView animated in so adjust scaleView to get visible
        
        [UIView animateWithDuration:0.15 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect scaleViewFrame = _scaleView.frame;
            scaleViewFrame.origin.x += 270.0;
            [_scaleView setFrame:scaleViewFrame];
        } completion:nil];
    }
    else
    {
        //_pullView animated out so adjust scaleView to follow it
        
        [UIView animateWithDuration:0.15 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect scaleViewFrame = _scaleView.frame;
            scaleViewFrame.origin.x -= 270.0;
            [_scaleView setFrame:scaleViewFrame];
        } completion:nil];
    }
}

//collects bug data from resultString and returns an array which contains MZOpenStreetBug objects
- (NSMutableArray*)collectOpenStreetBugsFromResultString:(NSString*)resultString
{
    NSMutableArray* retVal = [NSMutableArray array];
    
    [resultString enumerateLinesUsingBlock:^(NSString *line, BOOL *stop)
     {
         NSRange rangeOfFirstQuote = [line rangeOfString:@"'"];
         
         NSString* firstHalf = [line substringToIndex:rangeOfFirstQuote.location];
         
         //get second half of the line without the starting quote
         NSString* secondHalf = [line substringFromIndex:rangeOfFirstQuote.location + 1];
         
         //process the first half of the line------------
         //remove "putAJAXMarker(" string from the beginning
         firstHalf = [firstHalf stringByReplacingOccurrencesOfString:@"putAJAXMarker(" withString:@""];
         
         //split substring by ","
         NSArray* components = [firstHalf componentsSeparatedByString:@","];
         
         //components array contains the plain data
         NSString* bugID = [components objectAtIndex:0];
         CGFloat longitude = [[components objectAtIndex:1] floatValue];
         CGFloat latitude = [[components objectAtIndex:2] floatValue];
         
         
         //process the second half of the line------------
         NSRange rangeOfSecondQuote = [secondHalf rangeOfString:@"'"];
         
         //get description from the second half of the line (without ending quote)
         NSString* description = [secondHalf substringToIndex:rangeOfSecondQuote.location];
         
         //remove description from the second half string
         secondHalf = [secondHalf stringByReplacingOccurrencesOfString:description withString:@""];
         
         //remove unneeded strings from the second half string
         secondHalf = [secondHalf stringByReplacingOccurrencesOfString:@"', " withString:@""];
         secondHalf = [secondHalf stringByReplacingOccurrencesOfString:@");" withString:@""];
         
         //try convert left string to a status bool
         BOOL status = [secondHalf boolValue];
         
         //description maybe contains comment(s)
         components = [description componentsSeparatedByString:@"<hr />"];
         
         NSMutableArray* comments = [NSMutableArray array];
         
         if ([components count] > 1)
         {
             description = [components objectAtIndex:0];
             
             for (NSUInteger i = 1; i < [components count]; i++)
             {
                 [comments addObject:[components objectAtIndex:i]];
             }
         }
         
         
//         NSLog(@"\tbugId: %@",bugID);
//         NSLog(@"\tlon: %f",longitude);
//         NSLog(@"\tlat: %f",latitude);
//         NSLog(@"\tdesc: %@",description);
//         NSLog(@"\tstatus: %@",status ? @"YES" : @"NO");
//         for (NSString* comment in comments)
//         {
//             NSLog(@"\tcommentx: %@",comment);
//         }
         
         
         MZOpenStreetBug* bug = [[MZOpenStreetBug alloc] init];
         [bug setBugID:bugID];
         [bug setLongitude:longitude];
         [bug setLatitude:latitude];
         [bug setDescription:description];
         [bug setStatus:status];
         [bug setComments:comments];
         
         [retVal addObject:bug];
         
         [bug release];
     }];
    
    return retVal;
}

- (void)switchOnOpenStreetBugs
{
    CGFloat width = _map.maxLongitude - _map.minLongitude;
    CGFloat left = _map.minLongitude - width;
    CGFloat right = _map.maxLongitude + width;
    
    CGFloat height = _map.maxLatitude - _map.minLatitude;
    CGFloat bottom = _map.minLatitude - height;
    CGFloat top = _map.maxLatitude + height;
    
    //http://openstreetbugs.schokokeks.org/api/0.1/getBugs?b=46.2000070&t=46.2158120&l=19.3771410&r=19.4075760
    
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openstreetbugs.schokokeks.org/api/0.1/getBugs?b=%f&t=%f&l=%f&r=%f",bottom,top,left,right]];
    
    MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
    
    [_blockView show];
    
    [downloader downloadRequestFromURL:url
                       progressHandler:nil
                     completionHandler:^(NSString* resultString){
                         
                         if (![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                         {
                             //empty _openStreetBugs array
                             if ([_openStreetBugs count])
                             {
                                 [_openStreetBugs removeAllObjects];
                             }
                             
                             //fill _openStreetBugs array
                             [_openStreetBugs addObjectsFromArray:[self collectOpenStreetBugsFromResultString:resultString]];
                             
                             [_openStreetBugButton setImage:[UIImage imageNamed:@"icon_bug_on.png"] forState:UIControlStateNormal];
                             
                             //_openStreetBugView is a container view for open street bugs
                             if (_openStreetBugView)
                             {
                                 NSLog(@"subviews: %@",_openStreetBugView.subviews);
                                 for (id subview in [_openStreetBugView subviews])
                                 {
//                                     if ([subview isKindOfClass:[UIImageView class]])
//                                     {
                                         [subview removeFromSuperview];
//                                     }
                                 }
                             }
                             else
                             {
                                 _openStreetBugView = [[UIView alloc] initWithFrame:_map.frame];
                             }
                             
                             for (MZOpenStreetBug* bug in _openStreetBugs)
                             {
                                 //convert MZOpenStreetBug to a MZNode, so we can use realPositionForNode: method of the MZMapView
                                 MZNode* bugNode = [[MZNode alloc] init];
                                 bugNode.longitude = bug.longitude;
                                 bugNode.latitude = bug.latitude;
                                 
                                 CGPoint realPosition = [_map realPositionForNode:bugNode];
                                 
                                 [bugNode release];
                                 
                                 UIImage* statusImage = nil;
                                 
                                 if (bug.status)
                                 {
                                     statusImage = [UIImage imageNamed:@"icon_ok.png"];
                                 }
                                 else
                                 {
                                     statusImage = [UIImage imageNamed:@"icon_error.png"];
                                 }
                                 
                                 UIImageView* bugImageView = [[UIImageView alloc] initWithImage:statusImage];
                                 [bugImageView setCenter:realPosition];
                                 [bugImageView setUserInteractionEnabled:YES];
                                 
                                 UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBugTap:)];
                                 [bugImageView addGestureRecognizer:tapGesture];
                                 [tapGesture release];
                                 
                                 [_openStreetBugView addSubview:bugImageView];
                                 
                                 [bugImageView release];
                             }
                             
                             [_scrollView insertSubview:_openStreetBugView belowSubview:_blockView];
                             
                             //OpenStreetBugs integration
                             UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBugViewTap:)];
                             [doubleTap setNumberOfTapsRequired:1];
                             [_openStreetBugView addGestureRecognizer:doubleTap];
                             [doubleTap release];
                             
                             [_blockView hide];
                         }
                     }];
    
    [downloader release];
    [url release];
}

- (void)switchOffOpenStreetBugs
{
    [_openStreetBugButton setImage:[UIImage imageNamed:@"icon_bug.png"] forState:UIControlStateNormal];
    
    [_openStreetBugView removeFromSuperview];
    
    [_openStreetBugView release], _openStreetBugView = nil;
}

- (void)refreshOpenStreetBugs
{
    [self switchOnOpenStreetBugs];
}

- (void)addedPointObjectWithType:(NSUInteger)aType toPoint:(CGPoint)aPoint
{
    NSLog(@"addedpointwittype: %d topoint: %@",aType, NSStringFromCGPoint(aPoint));
        
    CGPoint convertedCenterPoint = [self.view.window.rootViewController.view convertPoint:aPoint toView:_pointObjectsLayerView];
    
    _imageViewForNewlyAddedPointObject = [[UIImageView alloc] initWithImage:[UIImage imageForPointCategoryElement:aType]];
    [_imageViewForNewlyAddedPointObject setCenter:convertedCenterPoint];
    
    [_pointObjectsLayerView addSubview:_imageViewForNewlyAddedPointObject];
    
    //remove dragged view from window
    for (UIView* subview in self.view.window.rootViewController.view.subviews)
    {
        if ([subview isKindOfClass:[MZDraggedCategoryItemView class]])
        {
            [subview removeFromSuperview];
        }
    }
    
    if (_selectedPointObject)
    {
        //deselect selected point object
        [_selectedPointObjectBackgroundView removeFromSuperview];
        
        [_selectedPointObjectBackgroundView release];
    }
    
    //select point object
    CGFloat highlightBorderWidth = 4.0;
    
    _selectedPointObjectBackgroundView = [[UIView alloc] initWithFrame:_imageViewForNewlyAddedPointObject.frame];
    CGRect backgroundViewFrame = _selectedPointObjectBackgroundView.frame;
    backgroundViewFrame.size.width += highlightBorderWidth * 2.0;
    backgroundViewFrame.size.height += highlightBorderWidth * 2.0;
    [_selectedPointObjectBackgroundView setFrame:backgroundViewFrame];
    [_selectedPointObjectBackgroundView setCenter:_imageViewForNewlyAddedPointObject.center];
    [_selectedPointObjectBackgroundView.layer setCornerRadius:3.0];
    [_selectedPointObjectBackgroundView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0.0/255.0 alpha:1.0]];
    
    [_imageViewForNewlyAddedPointObject.superview insertSubview:_selectedPointObjectBackgroundView belowSubview:_imageViewForNewlyAddedPointObject];
    
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    MZNode* addedNode = [_map nodeForRealPosition:convertedCenterPoint];
    [addedNode setNodeid:[NSString stringWithFormat:@"%d",_indexOfNewlyAddedNode++]];
    [addedNode.tags setValue:[cm subTypeNameInServerRepresentationForLogicalType:aType] forKey:[cm typeNameInServerRepresentationForLogicalType:aType]];
    
    
    
    
//    [cm.actualPointObjects addObject:addedNode];
    //[cm.addedPointObjects addObject:addedNode];
    
    _selectedPointObject = [addedNode retain];
    _newlyAddedPointObject = [addedNode retain];
    
    if (_editorTableViewController)
    {
        [_editorTableViewController release], _editorTableViewController = nil;
    }
    
    _editorTableViewController = [[MZPointObjectEditorTableViewController alloc] initWithDeleteButton:NO];
    [_editorTableViewController setEditedPointObject:_selectedPointObject];
    _editorTableViewController.view.layer.cornerRadius = 5.0;
    [_editorTableViewController setTitle:NSLocalizedString(@"EditKey", @"Title of the edit controller")];
    [_editorTableViewController setController:self];
    
    
    UINavigationController* navCont = [[UINavigationController alloc] initWithRootViewController:_editorTableViewController];
    [navCont.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editorVCDoneButtonTouched:)];
    [_editorTableViewController.navigationItem setRightBarButtonItem:doneButton];
    [doneButton release];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(editorVCCancelButtonTouched:)];
    [_editorTableViewController.navigationItem setLeftBarButtonItem:cancelButton];
    [cancelButton release];
    
    [_pullView setContentViewController:navCont];
    
    [navCont release];
    
    [_pullView show];
}

- (void)deselectSelectedPointObject
{
    [_selectedPointObjectBackgroundView removeFromSuperview];
    [_selectedPointObjectBackgroundView release];
    
    [_selectedPointObject release], _selectedPointObject = nil;
}

- (void)saveChangesToTheOSMServer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [_pullView hide];
    
    [self adjustScaleView];
    
    MZSavingPanelViewController* savingPanel = [[MZSavingPanelViewController alloc] initWithNibName:@"MZSavingPanelViewController" bundle:nil];
    [savingPanel setModalPresentationStyle:UIModalPresentationFormSheet];
    [savingPanel setDelegate:self];
    
    [self presentViewController:savingPanel animated:YES completion:nil];
    
    

}

#pragma mark -
#pragma mark Button touched methods

- (void)editButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    
    if (_editingModeIsActive) //saving changed content
    {
        [self saveChangesToTheOSMServer];
    }
    else //entering edit mode
    {
        if ([MZMapperContentManager sharedContentManager].loggedIn) //temporarly this functionality is switched off
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

- (void)openStreetBugsButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if ([MZMapperContentManager sharedContentManager].openStreetBugModeIsActive)
    {
        [MZMapperContentManager sharedContentManager].openStreetBugModeIsActive = NO;
        
        [self switchOffOpenStreetBugs];
    }
    else
    {
        [MZMapperContentManager sharedContentManager].openStreetBugModeIsActive = YES;
        
        [self switchOnOpenStreetBugs];
    }
}

- (void)editorVCDoneButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    if (_newlyAddedPointObject)
    {
        NSLog(@"új pont mentése");
        
        MZNode* newNode = _editorTableViewController.editedPointObject;
        
        for (NSString* key in [newNode.tags allKeys])
        {
            NSLog(@"%@ : %@",key, [newNode.tags valueForKey:key]);
        }
        
        [cm.addedPointObjects addObject:newNode];
        [cm.actualPointObjects addObject:newNode];
        
        [self deselectSelectedPointObject];
        
        //add image - which represents deleted point object - to the map
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NodeAddedNotification" object:newNode];
        
        [_scrollView updateBackgroundImage];
        
        [self updatePointObjectsLayerView];
        
        [_newlyAddedPointObject release], _newlyAddedPointObject = nil;
    }
    else
    {
        NSLog(@"módosított pont mentése");
        
        MZNode* updatedNode = _editorTableViewController.editedPointObject;
        
        for (NSString* key in [updatedNode.tags allKeys])
        {
            NSLog(@"%@ : %@",key, [updatedNode.tags valueForKey:key]);
        }
        
        NSLog(@"eredeti pont");
        for (NSString* key in [_selectedPointObject.tags allKeys])
        {
            NSLog(@"%@ : %@",key, [_selectedPointObject.tags valueForKey:key]);
        }
        
        
        
        
        if (![updatedNode.tags isEqualToDictionary:_selectedPointObject.tags])
        {
            [cm.updatedPointObjects addObject:updatedNode];
            
            NSLog(@"self.selectedObject: %@",_selectedPointObject);
            NSLog(@"actualobjects: %@",cm.actualPointObjects);
            
            [cm.actualPointObjects replaceObjectAtIndex:[cm.actualPointObjects indexOfObject:_selectedPointObject] withObject:updatedNode];
            
            //update image - which represents deleted point object - to the map
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NodeUpdatedNotification" object:updatedNode];
            
            [_scrollView updateBackgroundImage];
            
            [self updatePointObjectsLayerView];
        }
        
        [self deselectSelectedPointObject];
    }
    
    [self showEditVC];
}

- (void)editorVCCancelButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [self deselectSelectedPointObject];
    
    if (_newlyAddedPointObject)
    {
//        [[MZMapperContentManager sharedContentManager].actualPointObjects removeObject:_newlyAddedPointObject];
        
        [_newlyAddedPointObject release], _newlyAddedPointObject = nil;
        
        [_imageViewForNewlyAddedPointObject removeFromSuperview];
        
        [_imageViewForNewlyAddedPointObject release], _imageViewForNewlyAddedPointObject = nil;
    }
    
    [self showEditVC];
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
    
    [self showMessageViewWithMessage:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"LocationManagerFailedWithErrorKey", @"When location manager failed this string will be displayed in the messageview before the error string")/*@"Location manager failed with error: */,[error localizedDescription]]];
    
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

- (void)savingPanelViewControllerWillDismiss:(MZSavingPanelViewController*)savingPanelViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)savingPanelViewControllerWillCancelEditing:(MZSavingPanelViewController *)savingPanelViewController
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AreYouSureKey", @"When user want to exit from editing mode without saving - alert view title")/*Biztos?"*/ message:NSLocalizedString(@"WithoutSavingAlertViewMessageKey", @"When user want to exit from editing mode without saving - alert view message")/*@"Minden el nem mentett változtatás el fog veszni. Biztos, hogy megszakítod a szerkesztést?"*/ delegate:self cancelButtonTitle:NSLocalizedString(@"NoKey", @"When user want to exit from editing mode without saving - alert view NO button title") /*@"Nem"*/ otherButtonTitles:NSLocalizedString(@"YesKey", @"When user want to exit from editing mode without saving - alert view YES button title")/*@"Igen"*/, nil];
    
    [av show];
    
    [av release];
}

- (void)savingPanelViewControllerWillSave:(MZSavingPanelViewController*)savingPanelViewController withComment:(NSString*)comment
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [_blockView show];
    
    }];
    
    MZUploadManager* uploadManager = [[MZUploadManager alloc] init];
    [uploadManager setDelegate:self];

    [uploadManager uploadChangesToOSMWithComment:comment];

    [uploadManager release];

    
}

- (void)uploadManagerDidFinishWithUploading:(MZUploadManager*)uploadManager
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    
    
    [_blockView performSelector:@selector(hide) withObject:nil afterDelay:0.2];
    
    
    [self exitFromEditingMode];
    
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SuccessfulSavingKey", @"When user saved a changeset succesfully - alert view title")/* @"Sikeres mentés"*/ message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"OkKey", @"") otherButtonTitles:nil];
    
    [av show];
    
    [av release];
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)gesture
{
    NSLog(@"self.view: %@",NSStringFromCGPoint([gesture locationInView:self.view]));
    NSLog(@"view: %@",NSStringFromCGPoint([gesture locationInView:_pullView]));
    //NSLog(@"loc: %@",NSStringFromCGPoint([gesture locationInView:self.view]));
    
    //NSLog(@"self.view.frame: %@",NSStringFromCGRect(self.view.frame));
    CGPoint locationInVC = [gesture locationInView:self.view];
    CGPoint locationInPointObjectsLayerView = [gesture locationInView:_pointObjectsLayerView];
    
    NSLog(@"location: %@",NSStringFromCGPoint(locationInVC));
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [_loupeView setHidden:YES];
        
        UIView* touchedView = [_pointObjectsLayerView hitTest:locationInPointObjectsLayerView withEvent:nil];
        
        NSLog(@"touchedview: %@",touchedView);
        
        if ([touchedView isMemberOfClass:[UIImageView class]])
        {
            [self handlePointObjectTap:[touchedView.gestureRecognizers objectAtIndex:0]];
        }
        
        
        //[_scrollView selectPoint:_loupeView.touchPointInViewToMagnify];
    }
    else if (_editingModeIsActive)
    {
        CGFloat sizeOfEnlargedArea = 50.0;
        CGFloat borderWidth = sizeOfEnlargedArea / 2.0;
        
        // Set limiters
        if (locationInVC.x < borderWidth)
        {
            NSLog(@"védelemx<");
            locationInVC.x = borderWidth;
        }
        if (locationInVC.x > self.view.bounds.size.width - borderWidth)
        {
            NSLog(@"védelemx>");
            locationInVC.x = self.view.bounds.size.width - borderWidth;
        }
        if (locationInVC.y < borderWidth)
        {
            NSLog(@"védelemy<");
            locationInVC.y = borderWidth;
        }
        if (locationInVC.y > self.view.bounds.size.height - borderWidth)
        {
            NSLog(@"védelemy>");
            locationInVC.y = self.view.bounds.size.height - borderWidth;
        }
        
        CGPoint offset = _scrollView.contentOffset;
        
        locationInVC.x += offset.x;
        locationInVC.y += offset.y;
        
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
        _loupeView.touchPointInViewToMagnify = locationInVC;
        
        // Refresh view
        [_loupeView setNeedsDisplay];
        
        [_loupeView setHidden:NO];
    }
    
}

//when user taps on an empty area on the _openStreetBugView
- (void)handleBugViewTap:(UITapGestureRecognizer*)gesture
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    CGPoint gestureRecognizedAtPoint = [gesture locationInView:[gesture view]];
    
    MZOpenStreetBugsViewController* bugController = [[MZOpenStreetBugsViewController alloc] initWithControllerType:MZOpenStreetBugsViewControllerTypeCreateBug andWithBug:nil];
    
    MZNode* touchedNode = [_map nodeForRealPosition:gestureRecognizedAtPoint];
    bugController.node = touchedNode;
    
    bugController.controller = self;
    
    //[bugController setDelegate:self];
    [bugController setContentSizeForViewInPopover:CGSizeMake(400.0, 200.0)];
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:bugController];
    
    [bugController.navigationItem setTitle:@"OpenStreetBug"];
    
    UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
    bugController.aPopoverController = popoverController;
    
    UIImageView* newBugImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_error.png"]];
    [newBugImageView setCenter:gestureRecognizedAtPoint];
    [gesture.view addSubview:newBugImageView];
    bugController.imageViewForBug = newBugImageView;
    [newBugImageView release];
    
    [popoverController presentPopoverFromRect:newBugImageView.frame/*CGRectMake(gestureRecognizedAtPoint.x, gestureRecognizedAtPoint.y, 1.0, 1.0)*/ inView:[gesture view] permittedArrowDirections:UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
    
    [navController release];
    [bugController release];
    
//    popOverMenu.delegate = self;
//    popOverMenu.noResultsLabelText = noResultsLabelText;
//    popOverMenu.contentSizeForViewInPopover = CGSizeMake(300.0, 44.0 * 10.0);
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//    {
//        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:popOverMenu];
//        
//        popOverMenu.navigationItem.title = title;
//        
//        UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
//        popoverController.delegate = popOverMenu;
//        popOverMenu.aPopoverController = popoverController;
//        
//        UITableViewCell* selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
//        
//        [popoverController presentPopoverFromRect:selectedCell.bounds inView:selectedCell permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//        
//        [navController release];
//        [popOverMenu release];
}

//when user taps on an existing bug
- (void)handleBugTap:(UITapGestureRecognizer*)gesture
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    UIImageView* bugImageView = (UIImageView*)gesture.view;
    
    for (MZOpenStreetBug* bug in _openStreetBugs)
    {
        //convert MZOpenStreetBug to a MZNode, so we can use realPositionForNode: method of the MZMapView
        MZNode* bugNode = [[MZNode alloc] init];
        bugNode.longitude = bug.longitude;
        bugNode.latitude = bug.latitude;
        
        CGPoint realPosition = [_map realPositionForNode:bugNode];
        
        [bugNode release];
        
        if (CGPointEqualToPoint(bugImageView.center, realPosition))
        {
            MZOpenStreetBugsViewController* bugController = nil;
            
            if (bug.status)
            {
                bugController = [[MZOpenStreetBugsViewController alloc] initWithControllerType:MZOpenStreetBugsViewControllerTypeFixedBug andWithBug:bug];
            }
            else
            {
                bugController = [[MZOpenStreetBugsViewController alloc] initWithControllerType:MZOpenStreetBugsViewControllerTypeUnresolvedBug andWithBug:bug];
            }
            
            //[bugController setDelegate:self];
            [bugController setContentSizeForViewInPopover:CGSizeMake(400.0, 200.0)];
            [bugController setController:self];
            
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:bugController];
            
            [bugController.navigationItem setTitle:@"OpenStreetBug"];
            
            UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
            bugController.aPopoverController = popoverController;
            [popoverController presentPopoverFromRect:gesture.view.bounds inView:[gesture view] permittedArrowDirections:UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
            
            [navController release];
            [bugController release];
            
            break;
        }
    }
}

- (void)handlePointObjectTap:(UITapGestureRecognizer*)gesture
{
    if (_selectedPointObject)
    {
        //deselect selected point object
        [_selectedPointObjectBackgroundView removeFromSuperview];
        
        [_selectedPointObjectBackgroundView release];
    }
    
    //select point object
    CGFloat highlightBorderWidth = 4.0;
    
    _selectedPointObjectBackgroundView = [[UIView alloc] initWithFrame:gesture.view.frame];
    CGRect backgroundViewFrame = _selectedPointObjectBackgroundView.frame;
    backgroundViewFrame.size.width += highlightBorderWidth * 2.0;
    backgroundViewFrame.size.height += highlightBorderWidth * 2.0;
    [_selectedPointObjectBackgroundView setFrame:backgroundViewFrame];
    [_selectedPointObjectBackgroundView setCenter:gesture.view.center];
    [_selectedPointObjectBackgroundView.layer setCornerRadius:3.0];
    [_selectedPointObjectBackgroundView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0.0/255.0 alpha:1.0]];
    
    [gesture.view.superview insertSubview:_selectedPointObjectBackgroundView belowSubview:gesture.view];
    
    for (MZNode* node in [MZMapperContentManager sharedContentManager].actualPointObjects)
    {
        if ([node.nodeid integerValue] == gesture.view.tag)
        {
            _selectedPointObject = [node retain];
            break;
        }
    }
    
    NSLog(@"self.selectedObject: %@",_selectedPointObject);
    NSLog(@"actualobjects: %@",[MZMapperContentManager sharedContentManager].actualPointObjects);
    
    if (_editorTableViewController)
    {
        [_editorTableViewController release], _editorTableViewController = nil;
    }
    
    _editorTableViewController = [[MZPointObjectEditorTableViewController alloc] initWithDeleteButton:YES];
    [_editorTableViewController setEditedPointObject:_selectedPointObject];
    _editorTableViewController.view.layer.cornerRadius = 5.0;
    [_editorTableViewController setTitle:NSLocalizedString(@"EditKey", @"Title of the edit controller")];
    [_editorTableViewController setController:self];
    
    
    UINavigationController* navCont = [[UINavigationController alloc] initWithRootViewController:_editorTableViewController];
    [navCont.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editorVCDoneButtonTouched:)];
    [_editorTableViewController.navigationItem setRightBarButtonItem:doneButton];
    [doneButton release];
    
//    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(editorVCCancelButtonTouched:)];
//    [editorTableViewController.navigationItem setLeftBarButtonItem:cancelButton];
//    [cancelButton release];
    
    [_pullView setContentViewController:navCont];
    
    [navCont release];
    
    [_pullView show];
}

#pragma mark -
#pragma mark editing methods

- (void)deleteEditedPointObject
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    [cm.deletedPointObjects addObject:_selectedPointObject];
    [cm.actualPointObjects removeObject:_selectedPointObject];
    
    //remove image - which represents deleted point object - from the map
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NodeDeletedNotification" object:_selectedPointObject];
    
    for (UIView* v in _pointObjectsLayerView.subviews)
    {
        if (v.tag == [_selectedPointObject.nodeid integerValue])
        {
            [v removeFromSuperview];
            break;
        }
    }
    
    [_scrollView updateBackgroundImage];
    
    [self editorVCCancelButtonTouched:nil];    
}

#pragma mark -
#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self exitFromEditingMode];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_editorTableViewController)
    {
        [_editorTableViewController release], _editorTableViewController = nil;
    }
    
    [_map release];
    [_scrollView release];
    [_messageView release];
    [_pullView release];
    [_currentLocButton release];
    [_searchButton release];
    [_editButton release];
    [_openStreetBugButton release];
    [_loupeView release];
    [_blockView release];
    [_scaleView release];
    
    [_locationManager stopUpdatingLocation];
	[_locationManager release];
    
    [_openStreetBugs release];
    
    [super dealloc];
}

@end
