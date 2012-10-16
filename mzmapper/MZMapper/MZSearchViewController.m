//
//  MZSearchViewController.m
//  MZMapper
//
//  Created by Zalán Mergl on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZSearchViewController.h"
#import "MZMapperViewController.h"
#import "MZDownloader.h"
#import "MZPlace.h"

@interface MZSearchViewController ()

@end

@implementation MZSearchViewController

@synthesize controller = _controller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _searchResults = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tableView setAlwaysBounceVertical:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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

#pragma mark -
#pragma mark public methods

- (void)searchForString:(NSString*)searchString
{
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSURL* url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://open.mapquestapi.com/nominatim/v1/search?format=xml&q=%@", searchString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"searchurl: %@",url);
    
    MZDownloader* downloader = [[MZDownloader alloc] init];
    
    [downloader downloadRequestFromURL:url 
                       progressHandler:nil 
                     completionHandler:^(NSString *resultString) {
                         if (![resultString isEqualToString:HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED] && ![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                         {
                             NSLog(@"resultstring: %@",resultString);
                             
                             _parser = [[NSXMLParser alloc] initWithData:[resultString dataUsingEncoding:NSUTF8StringEncoding]];
                             
                             [_parser setDelegate:self];
                             
                             [_parser parse];
                             
                             [_parser release];
                         }
                     }];
    
    [downloader release];
}

#pragma mark -
#pragma mark UISearchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_controller showMessageViewWithMessage:@"Searching..."];
    
    [self searchForString:searchBar.text];
    
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark xmlparser delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if (_searchResults) 
    {
        [_searchResults removeAllObjects];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{    
    NSLog(@"parsing finished; _searchResults: %@",_searchResults);
    
    [_controller hideMessageView];
    
    if (![_searchResults count]) 
    {
        [_controller showMessageViewWithMessage:@"There are no hits for your search request"];
        [NSObject cancelPreviousPerformRequestsWithTarget:_controller selector:@selector(hideMessageView) object:nil]; 
        [_controller performSelector:@selector(hideMessageView) withObject:nil afterDelay:3.0];
    }
    
    [_tableView reloadData];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{    
    if ([elementName isEqualToString:@"place"]) 
    {
        if (_currentPlace) 
        {
            [_currentPlace release];
            _currentPlace = nil;
        }
        
        _currentPlace = [[MZPlace alloc] init];
        
        _currentPlace.placeId = [attributeDict valueForKey:@"place_id"];
        _currentPlace.latitude = [[attributeDict valueForKey:@"lat"] floatValue];
        _currentPlace.longitude = [[attributeDict valueForKey:@"lon"] floatValue];
        _currentPlace.displayName = [attributeDict valueForKey:@"display_name"];
        _currentPlace.iconURL = [attributeDict valueForKey:@"icon"];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{    
    if ([elementName isEqual:@"place"]) 
    {
        [_searchResults addObject:_currentPlace];
        
        [_currentPlace release], _currentPlace = nil;
    }
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"SearchResultCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
        
        UILabel* aTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[aTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [aTextLabel setMinimumScaleFactor:15.0];
		[aTextLabel setNumberOfLines:0];
		[aTextLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        [aTextLabel setTextColor:[UIColor whiteColor]];
		[aTextLabel setTag:1];
		[aTextLabel setOpaque:NO];
		[aTextLabel setBackgroundColor:[UIColor clearColor]];
		
		[[cell contentView] addSubview:aTextLabel];		
		[aTextLabel release];
		aTextLabel = nil;
        
        // set selection color
        UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
        myBackView.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:179.0/255.0 blue:54.0/255.0 alpha:1];
        cell.selectedBackgroundView = myBackView;
        [myBackView release];
    }
    
    UILabel* textLabel = (UILabel*)[cell viewWithTag:1];
    
    MZPlace* placeForRow = [_searchResults objectAtIndex:indexPath.row];
    
    [textLabel setText:placeForRow.displayName];
    
    CGFloat labelWidth = self.view.frame.size.width - 20.0;
    
    CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
    CGSize size = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:constraint lineBreakMode:textLabel.lineBreakMode];
    
    [textLabel setFrame:CGRectMake(10.0, 10.0, labelWidth, size.height)];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZPlace* selectedPlace = [_searchResults objectAtIndex:indexPath.row];
    
    [_controller jumpToCoordinateLongitude:selectedPlace.longitude latitude:selectedPlace.latitude];
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indp.row: %i",indexPath.row);
    if (indexPath.row > [_searchResults count]) 
    {
        return 44.0;
    }
    
    MZPlace* placeForRow = [_searchResults objectAtIndex:indexPath.row];
    
    CGFloat labelWidth = self.view.frame.size.width - 20.0;
    
    CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
    CGSize size = [placeForRow.displayName sizeWithFont:[UIFont boldSystemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    //top-bottom margins are 5-5px
    return size.height + 20.0;
}

- (void)dealloc
{
    [_searchResults release], _searchResults = nil;
    
    [super dealloc];
}

@end
