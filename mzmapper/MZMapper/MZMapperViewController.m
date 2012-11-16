//
//  MZMapperViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MZMapperViewController.h"
#import "MZDownloader.h"
#import "MZMessageView.h"
#import "MZPullView.h"
#import "MZSearchViewController.h"
#import "MZEditViewController.h"
#import "MZLoupeView.h"
#import "MZOpenStreetBugsViewController.h"
#import "MZOpenStreetBug.h"
#import "MZNode.h"
#import "MZPointObjectEditorViewController.h"
#import "MZPointObjectEditorTableViewController.h"

@implementation MZMapperViewController

@synthesize gettingCurrentLocationIsInProgress = _gettingCurrentLocationIsInProgress;
@synthesize selectedPointObject = _selectedPointObject;

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
    
    
    //temporary login button
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setFrame:CGRectMake(700.0, 20.0, 60.0, 44.0)];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    _editingModeIsActive = NO;
    
    _openStreetBugs = [[NSMutableArray alloc] init];
    
    _blockView = [[MZBlockView alloc] initWithView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapViewDidEndParsingDocument) name:@"ParserDidEndDocumentNotification" object:nil];
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
    
    
    MZEditViewController* editVC = [[MZEditViewController alloc] initWithNibName:@"MZEditViewController" bundle:nil];
    editVC.controller = self;
    
    [_pullView setContentViewController:editVC];
    
    [editVC release];
    
    
    
    
    [_pullView show];
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
    
    MZDownloader* downloader = [[MZDownloader alloc] init];
    
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

#pragma mark -
#pragma mark NSNotification methods

- (void)mapViewDidEndParsingDocument
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    UIView* pointObjectsLayerView = [[UIView alloc] initWithFrame:_map.bounds];

    [_scrollView addSubview:pointObjectsLayerView];
    
    
    
    for (MZNode* node in [MZMapperContentManager sharedContentManager].pointObjects)
    {
        NSString* imageName = nil;
        
        for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].pointObjectTypes)
        {
            NSString* subType = [node.tags valueForKey:pointObjectType];
            
            if (subType)
            {
                imageName = [NSString stringWithFormat:@"%@_%@.png", pointObjectType ,subType];
            }
        }
        
//        NSString* tourism = [node.tags valueForKey:@"tourism"];
//        NSString* emergency = [node.tags valueForKey:@"emergency"];
//        NSString* manMade = [node.tags valueForKey:@"man_made"];
//        NSString* barrier = [node.tags valueForKey:@"barrier"];
//        NSString* landuse = [node.tags valueForKey:@"landuse"];
//        NSString* place = [node.tags valueForKey:@"place"];
//        NSString* power = [node.tags valueForKey:@"power"];
//        NSString* highway = [node.tags valueForKey:@"highway"];
//        NSString* railway = [node.tags valueForKey:@"railway"];
//        NSString* shop = [node.tags valueForKey:@"shop"];
//        NSString* leisure = [node.tags valueForKey:@"leisure"];
//        NSString* historic = [node.tags valueForKey:@"historic"];
//        NSString* aeroway = [node.tags valueForKey:@"aeroway"];
//        NSString* amenity = [node.tags valueForKey:@"amenity"];
//
//
//        NSString* imageName = nil;
//
//        if (tourism)
//        {
//            imageName = [NSString stringWithFormat:@"tourism_%@.png",tourism];
//        }
//        else if (emergency)
//        {
//            imageName = [NSString stringWithFormat:@"emergency_%@.png",emergency];
//        }
//        else if (manMade)
//        {
//            imageName = [NSString stringWithFormat:@"man_made_%@.png",manMade];
//        }
//        else if (barrier)
//        {
//            imageName = [NSString stringWithFormat:@"barrier_%@.png",barrier];
//        }
//        else if (landuse)
//        {
//            imageName = [NSString stringWithFormat:@"landuse_%@.png",landuse];
//        }
//        else if (place)
//        {
//            //ez kiírja a település nevét
//            //            NSString* name = [node.tags valueForKey:@"name"];
//            //            [name drawAtPoint:[self realPositionForNode:node] withFont:[UIFont systemFontOfSize:16.0]];
//
//            imageName = [NSString stringWithFormat:@"place_%@.png",place];
//        }
//        else if (power)
//        {
//            imageName = [NSString stringWithFormat:@"power_%@.png",power];
//        }
//        else if (highway)
//        {
//            imageName = [NSString stringWithFormat:@"highway_%@.png",highway];
//        }
//        else if (railway)
//        {
//            imageName = [NSString stringWithFormat:@"railway_%@.png",railway];
//        }
//        else if (shop)
//        {
//            imageName = [NSString stringWithFormat:@"shop_%@.png",shop];
//        }
//        else if (leisure)
//        {
//            imageName = [NSString stringWithFormat:@"leisure_%@.png",leisure];
//        }
//        else if (historic)
//        {
//            imageName = [NSString stringWithFormat:@"historic_%@.png",historic];
//        }
//        else if (aeroway)
//        {
//            imageName = [NSString stringWithFormat:@"aeroway_%@.png",aeroway];
//        }
//        else if (amenity)
//        {
//            imageName = [NSString stringWithFormat:@"amenity_%@.png",amenity];
//        }


        if (imageName)
        {
            UIImageView* imageViewForPointObject = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            [imageViewForPointObject setCenter:[_map realPositionForNode:node]];
            [imageViewForPointObject setUserInteractionEnabled:YES];
            [imageViewForPointObject setTag:[node.nodeid integerValue]];

            [pointObjectsLayerView addSubview:imageViewForPointObject];

            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePointObjectTap:)];
            [imageViewForPointObject addGestureRecognizer:tap];

            [tap release];
            
            [imageViewForPointObject release];
        }
    }
    
    
    [pointObjectsLayerView release];
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
    
    [self enterEditingMode];
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
        
        //[_scrollView selectPoint:_loupeView.touchPointInViewToMagnify];
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
    
    [bugController.navigationItem setTitle:@"OpenStreetBugs"];
    
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
            
            [bugController.navigationItem setTitle:@"OpenStreetBugs"];
            
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
    
    for (MZNode* node in [MZMapperContentManager sharedContentManager].pointObjects)
    {
        if ([node.nodeid integerValue] == gesture.view.tag)
        {
            _selectedPointObject = node;
        }
    }
    
    NSLog(@"selected point object: %@",_selectedPointObject.tags);
    
    MZPointObjectEditorTableViewController* editorTableViewController = [[MZPointObjectEditorTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    editorTableViewController.view.layer.cornerRadius = 5.0;
    [editorTableViewController setTitle:@"Edit"];
    [editorTableViewController setImage:((UIImageView*)gesture.view).image];
    [editorTableViewController setController:self];
    [editorTableViewController setPointObjectName:[_selectedPointObject.tags valueForKey:@"name"]];
    
    //MZPointObjectEditorViewController* editVC = [[MZPointObjectEditorViewController alloc] initWithNibName:@"MZPointObjectEditorViewController" bundle:nil];
    //editVC.controller = self;
    //editVC.image = ((UIImageView*)gesture.view).image;
    //editVC.view.layer.cornerRadius = 5.0;
    //[editVC.nameLabel setText:[_selectedPointObject.tags valueForKey:@"name"]];
    
    
    UINavigationController* navCont = [[UINavigationController alloc] initWithRootViewController:editorTableViewController];
    [navCont.navigationBar setBarStyle:UIBarStyleBlack];
    
    
    
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editorVCDoneButtonTouched:)];
    [editorTableViewController.navigationItem setRightBarButtonItem:doneButton];
    [doneButton release];
    
    [_pullView setContentViewController:navCont];
    
    //[editVC release], editVC = nil;
    
    [_pullView show];
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
    
    [_locationManager stopUpdatingLocation];
	[_locationManager release];
    
    [_openStreetBugs release];
    
    [super dealloc];
}

@end
