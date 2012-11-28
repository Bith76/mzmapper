//
//  MZPointObjectEditorTableViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//

#import "MZPointObjectEditorTableViewController.h"
#import "MZMapperViewController.h"
#import "MZNode.h"

@interface MZPointObjectEditorTableViewController ()

@end

@implementation MZPointObjectEditorTableViewController

@synthesize controller, editedPointObject;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    
    //register custom cells
    _headerCellIdentifier = @"HeaderCell";
    _typeChooserCellIdentifier = @"TypeChooserCell";
    _generalCellIdentifier = @"GeneralCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MZPointObjectHeaderCell" bundle:nil] forCellReuseIdentifier:_headerCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MZPointObjectHeaderTypeCell" bundle:nil] forCellReuseIdentifier:_typeChooserCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MZPointObjectGeneralCell" bundle:nil] forCellReuseIdentifier:_generalCellIdentifier];
    
    //prepare content
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSDictionary* schemaDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PointObjectSchemas" ofType:@"plist"]];
    
    NSString* typeOfEditedPointObject = [cm typeNameInServerRepresentationForNode:self.editedPointObject];
    NSString* subTypeOfEditedPointObject = [cm subTypeNameInServerRepresentationForNode:self.editedPointObject];
    
    _content = [[NSMutableArray arrayWithArray:[[[schemaDictionary valueForKey:typeOfEditedPointObject] valueForKey:subTypeOfEditedPointObject] valueForKey:@"tags"]] retain];
    
    NSLog(@"_content: %@",_content);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1 + [_content count]; //fix header + count of editable attributes
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger retVal = 1;
    
    if (section == 0)
    {
        retVal = 2;
    }
    else
    {
        retVal = 1;
    }
    
    return retVal;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* retVal = @"";
    
    if (section != 0)
    {
        retVal = [[_content objectAtIndex:section-1] valueForKey:@"sectionTitle_en"];
    }
    
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"HeaderCell";
    UITableViewCell *cell = nil;
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
    
    // Configure the cell...
    
    MZMapperContentManager* contentManager = [MZMapperContentManager sharedContentManager];
    
    NSUInteger logicalTypeOfEditedPointObject = [contentManager logicalTypeForServerTypeName:[contentManager fullTypeNameInServerRepresentationForNode:self.editedPointObject]];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:_headerCellIdentifier];
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
        [imageView setImage:[UIImage imageForPointCategoryElement:logicalTypeOfEditedPointObject]];
        
        UILabel* nameLabel = (UILabel*)[cell viewWithTag:2];
        [nameLabel setText:[self.editedPointObject.tags valueForKey:@"name"]];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:_typeChooserCellIdentifier];
        UILabel* typeLabel = (UILabel*)[cell viewWithTag:1];
        [typeLabel setText:[NSString nameOfPointCategoryElement:logicalTypeOfEditedPointObject]];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:_generalCellIdentifier];
        UITextView* textView = (UITextView*)[cell viewWithTag:1];
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* retVal = nil;
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        retVal = indexPath;
    }
    
    return retVal;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        MZPointObjectTypeSelectorTableViewController *detailViewController = [[MZPointObjectTypeSelectorTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [detailViewController setTitle:@"Types"];
        [detailViewController setDelegate:self];
        [detailViewController setEditedPointObject:self.editedPointObject];
        detailViewController.view.layer.cornerRadius = 5.0;
        
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat retVal = 0.0;
    
    if (section == [_content count])
    {
        retVal = 100.0;
    }
    
    return retVal;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* retVal = nil;
    
    if (section == [_content count])
    {
        //allocate the view if it doesn't exist yet
        UIView* footerView  = [[UIView alloc] init];
        
        //we would like to show a gloosy red button, so get the image first
        UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
        UIImage *buttonBackgroundImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:insets];
        UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:insets];
        
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
        
        //the button should be as big as a table view cell
        [button setFrame:CGRectMake(10.0, 28.0, 240.0, 44.0)];
        
        //set title, font size and font color
        [button setTitle:@"Delete" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //set action of the button
        [button addTarget:self action:@selector(deleteButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        //add the button to the view
        [footerView addSubview:button];
        
        //return the view for the footer
        retVal = footerView;
    }
    
    return retVal;
}

#pragma mark -
#pragma mark typeSelectorTableView delegate methods

- (void)typeSelectorTableView:(MZPointObjectTypeSelectorTableViewController*)tableView didSelectObject:(NSUInteger)selectedObject
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSLog(@"selectedObject: %d",selectedObject);
    
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSString* actualTypeName = [cm typeNameInServerRepresentationForNode:self.editedPointObject];
    NSString* newTypeName = [cm typeNameInServerRepresentationForLogicalType:selectedObject];
    NSString* newSubTypeName = [cm subTypeNameInServerRepresentationForLogicalType:selectedObject];
    
    [self.editedPointObject.tags removeObjectForKey:actualTypeName];
    [self.editedPointObject.tags setObject:newSubTypeName forKey:newTypeName];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark helper methods

- (void)deleteButtonTouched:(UIButton*)sender
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DeletePointObjectAlertViewTitleKey", @"Title of the alert view, which appears when user want to delete a point object.") message:NSLocalizedString(@"DeletePointObjectAlertViewMessageKey", @"Message of the alert view, which appears when user want to delete a point object.") delegate:self cancelButtonTitle:NSLocalizedString(@"CancelKey", @"Title of the cancel button.") otherButtonTitles:NSLocalizedString(@"OkKey", @"Title of the ok button."), nil];
    
    [av show];
    
    [av release];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) //Ok button was pressed
    {
        [self.controller deleteEditedPointObject];
    }
}

- (void)dealloc
{
    [_content release], _content = nil;
    
    [super dealloc];
}

@end
