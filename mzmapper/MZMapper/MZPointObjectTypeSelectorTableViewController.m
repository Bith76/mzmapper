//
//  MZPointObjectTypeSelectorTableViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//

#import "MZPointObjectTypeSelectorTableViewController.h"
#import "MZMapperContentManager.h"
#import "MZBlockView.h"

@interface MZPointObjectTypeSelectorTableViewController ()

@end

@implementation MZPointObjectTypeSelectorTableViewController

@synthesize editedPointObject;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        _content = [[NSMutableArray alloc] init];
        
        
        for (NSInteger i = 1; i < MZMapperPointCategoryCountOfCategories; i++)
        {
            
            NSMutableArray* categoryItems = [NSMutableArray array];
            NSMutableArray* categoryItemNames = [NSMutableArray array];
            NSMutableArray* categoryItemImages = [NSMutableArray array];
            
            if (i == MZMapperPointCategoryAccomodation)
            {
                for (NSUInteger j = MZMapperPointCategoryAccomodationElementUnknown + 1; j < MZMapperPointCategoryAccomodationElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryAmenity)
            {
                for (NSUInteger j = MZMapperPointCategoryAmenityElementUnknown + 1; j < MZMapperPointCategoryAmenityElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryBarrier)
            {
                for (NSUInteger j = MZMapperPointCategoryBarrierElementUnknown + 1; j < MZMapperPointCategoryBarrierElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryEducation)
            {
                for (NSUInteger j = MZMapperPointCategoryEducationElementUnknown + 1; j < MZMapperPointCategoryEducationElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryEntertainmentArtsCulture)
            {
                for (NSUInteger j = MZMapperPointCategoryEntertainmentArtsCultureElementUnknown + 1; j < MZMapperPointCategoryEntertainmentArtsCultureElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryFoodAndDrink)
            {
                for (NSUInteger j = MZMapperPointCategoryFoodAndDrinkElementUnknown + 1; j < MZMapperPointCategoryFoodAndDrinkElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryHealthCare)
            {
                for (NSUInteger j = MZMapperPointCategoryHealthcareElementUnknown + 1; j < MZMapperPointCategoryHealthcareElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryLanduse)
            {
                for (NSUInteger j = MZMapperPointCategoryLanduseElementUnknown + 1; j < MZMapperPointCategoryLanduseElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryPlaces)
            {
                for (NSUInteger j = MZMapperPointCategoryPlacesElementUnknown + 1; j < MZMapperPointCategoryPlacesElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryPower)
            {
                for (NSUInteger j = MZMapperPointCategoryPowerElementUnknown + 1; j < MZMapperPointCategoryPowerElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryShopping)
            {
                for (NSUInteger j = MZMapperPointCategoryShoppingElementUnknown + 1; j < MZMapperPointCategoryShoppingElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategorySportAndLeisure)
            {
                for (NSUInteger j = MZMapperPointCategorySportAndLeisureElementUnknown + 1; j < MZMapperPointCategorySportAndLeisureElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryTourism)
            {
                for (NSUInteger j = MZMapperPointCategoryTourismElementUnknown + 1; j < MZMapperPointCategoryTourismElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryTransport)
            {
                for (NSUInteger j = MZMapperPointCategoryTransportElementUnknown + 1; j < MZMapperPointCategoryTransportElementCountOfElements; j++)
                {
                    [categoryItems addObject:[NSNumber numberWithUnsignedInteger:j]];
                    [categoryItemNames addObject:[NSString nameOfPointCategoryElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryElement:j]];
                }
            }
            
            NSMutableDictionary* sectionData = [NSMutableDictionary dictionary];
            [sectionData setValue:[NSString nameOfPointCategory:i] forKey:@"categoryName"];
            [sectionData setValue:categoryItems forKey:@"items"];
            [sectionData setValue:categoryItemNames forKey:@"itemNames"];
            [sectionData setValue:categoryItemImages forKey:@"itemImages"];
            
            [_content addObject:sectionData];
        }
        
        NSLog(@"content: %@",_content);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
        
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, self.view.frame.size.width, 60.0)];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setNumberOfLines:0];
    [headerLabel setLineBreakMode:UILineBreakModeCharacterWrap];
    [headerLabel setTextAlignment:UITextAlignmentCenter];
    [headerLabel setText:NSLocalizedString(@"SelectTypeKey", @"Text displays when user will change the type of a point object - in the header of the table view")/* @"Please select a type for the point object."*/];
    [headerLabel setFont:[UIFont systemFontOfSize:12.0]];
    
    [self.tableView setTableHeaderView:headerLabel];
    
    [headerLabel release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //scroll selected row to the middle of the screen
    MZMapperContentManager* contentManager = [MZMapperContentManager sharedContentManager];
    NSUInteger logicalTypeOfEditedPointObject = [contentManager logicalTypeForServerTypeName:[contentManager fullTypeNameInServerRepresentationForNode:self.editedPointObject]];
    
    NSIndexPath* indexPath = nil;
    
    NSInteger sectionIndex = 0;
    for (NSMutableDictionary* sectionData in _content)
    {
        NSInteger rowIndex = 0;
        for (NSNumber* type in [sectionData valueForKey:@"items"])
        {
            if ([type unsignedIntegerValue] == logicalTypeOfEditedPointObject)
            {
                indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
                break;
            }
            
            rowIndex++;
        }
        
        if (indexPath)
        {
            break;
        }
        
        sectionIndex++;
    }
    
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_content release];
    
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_content count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_content objectAtIndex:section] valueForKey:@"categoryName"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[_content objectAtIndex:section] valueForKey:@"itemNames"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        //info button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [button addTarget:self action:@selector(infoButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell setAccessoryView:button];
    }
    
    // Configure the cell...
    [cell.imageView setImage:[[[_content objectAtIndex:indexPath.section] valueForKey:@"itemImages"] objectAtIndex:indexPath.row]];
    [cell.textLabel setText:[[[_content objectAtIndex:indexPath.section] valueForKey:@"itemNames"] objectAtIndex:indexPath.row]];
    
    
    //set tag of info button to get indexPath in the infoButtonTouched method
    [cell.accessoryView setTag:indexPath.section * 100 + indexPath.row];
    
    
    MZMapperContentManager* contentManager = [MZMapperContentManager sharedContentManager];
    NSUInteger logicalTypeOfEditedPointObject = [contentManager logicalTypeForServerTypeName:[contentManager fullTypeNameInServerRepresentationForNode:self.editedPointObject]];
    
    NSUInteger logicalTypeForRow = [[[[_content objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] unsignedIntegerValue];
    
    if (logicalTypeOfEditedPointObject == logicalTypeForRow)
    {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(MZPointObjectTypeSelectorTableViewControllerDelegate)] && [self.delegate respondsToSelector:@selector(typeSelectorTableView:didSelectObject:)])
    {
        [self.delegate typeSelectorTableView:self didSelectObject:[[[[_content objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row] unsignedIntegerValue]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark helper methods

- (void)infoButtonTouched:(UIButton*)sender
{    
    NSIndexPath* indexPath = [[NSIndexPath indexPathWithIndex:((NSInteger)sender.tag / 100)] indexPathByAddingIndex:((NSInteger)sender.tag % 100)];
        
    NSUInteger logicalTypeForRow = [[[[_content objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] unsignedIntegerValue];
    
    NSString* type = [[MZMapperContentManager sharedContentManager] serverTypeNameForLogicalType:logicalTypeForRow];
    NSString* subType = @"";
    
    for (NSString* pointObjectType in [MZMapperContentManager sharedContentManager].handledPointObjectTypes)
    {
        if ([type rangeOfString:pointObjectType].location != NSNotFound)
        {
            subType = [type stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@:",pointObjectType] withString:@""];
            type = pointObjectType;
        }
    }
    
    NSURL* infoUrl = [NSURL URLWithString:[[NSString stringWithFormat:@"http://wiki.openstreetmap.org/wiki/Tag:%@=%@",type,subType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest* request = [NSURLRequest requestWithURL:infoUrl];
    
    
    UIViewController* infoViewController = [[UIViewController alloc] init];
    [infoViewController setContentSizeForViewInPopover:CGSizeMake(800.0, 500.0)];
    UIWebView* infoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 735.0, 500.0)];
    [infoViewController.view addSubview:infoWebView];
    [infoWebView setDelegate:self];
    [infoWebView loadRequest:request];
    _blockView = [[MZBlockView alloc] initWithView:infoWebView];
    [_blockView show];
    [infoWebView release];
    
    UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:infoViewController];
    [popoverController setDelegate:self];
    [popoverController presentPopoverFromRect:((UIButton*)sender).frame inView:[self.tableView cellForRowAtIndexPath:indexPath].contentView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    [infoViewController release];
}

#pragma mark -
#pragma mark UIWebViewController delegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView
{    
    if (_blockView)
    {
        [_blockView hide];
        [_blockView release], _blockView = nil;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{    
    if (_blockView)
    {
        [_blockView hide];
        [_blockView release], _blockView = nil;
    }
}


#pragma mark -
#pragma mark UIPopoverControllerDelegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}

@end
