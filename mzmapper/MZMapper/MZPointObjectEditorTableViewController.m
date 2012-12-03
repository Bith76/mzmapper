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

- (id)initWithDeleteButton:(BOOL)enableDeleteButton
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _enableDeleteButton = enableDeleteButton;
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initWithDeleteButton:NO];
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
    
    NSMutableDictionary* schemaDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PointObjectSchemas" ofType:@"plist"]];
    
    NSString* typeOfEditedPointObject = [cm typeNameInServerRepresentationForNode:self.editedPointObject];
    NSString* subTypeOfEditedPointObject = [cm subTypeNameInServerRepresentationForNode:self.editedPointObject];
    
    //fill content from point object schema
    NSMutableArray* schema = [NSMutableArray arrayWithArray:[[[schemaDictionary valueForKey:typeOfEditedPointObject] valueForKey:subTypeOfEditedPointObject] valueForKey:@"tags"]];
    
    _content = [[NSMutableArray alloc] init];
    
    
    //fill content with values
    for (NSMutableDictionary* section in schema)
    {
        NSString* attributeName = [section valueForKey:@"attrName"];
        
        if ([[self.editedPointObject.tags allKeys] containsObject:attributeName])
        {
            NSMutableDictionary* sectionWithValue = [section mutableCopy];
            
            [sectionWithValue setValue:[self.editedPointObject.tags valueForKey:attributeName] forKey:@"value"];
            
            [_content addObject:sectionWithValue];
            
            [sectionWithValue release];
            
            //save name of the point object
            if ([attributeName isEqualToString:@"name"])
            {
                _nameOfThePointObject = [[self.editedPointObject.tags valueForKey:attributeName] copy];
            }
        }
        else
        {
            [_content addObject:section];
        }
    }
    
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
        NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        retVal = [[_content objectAtIndex:section-1] valueForKey:([language hasPrefix:@"hu"] ? @"sectionTitle_hu" : @"sectionTitle_en")];
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
        [nameLabel setText:_nameOfThePointObject];
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
        UITextField* textField = (UITextField*)[cell viewWithTag:1];
        
        [textField addTarget:self action:@selector(updateDataUsingContentsOfTextField:) forControlEvents:UIControlEventEditingChanged];
        
        NSString* value = [[_content objectAtIndex:indexPath.section - 1] valueForKey:@"value"];
        
        if (value)
        {
            [textField setText:value];
        }
        else
        {
            [textField setText:@""];
        }
    
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
        [detailViewController setTitle:NSLocalizedString(@"TypesKey", @"Title of the point object type selector controller")/* @"Types"*/];
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
    
    if (section == [_content count] && _enableDeleteButton)
    {
        retVal = 100.0;
    }
    
    return retVal;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* retVal = nil;
    
    if (section == [_content count] && _enableDeleteButton)
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
        [button setTitle:NSLocalizedString(@"DeleteKey", @"Title of the delete button") forState:UIControlStateNormal];
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
#pragma mark UITextField methods

- (void)updateDataUsingContentsOfTextField:(id)sender
{
    NSLog(@"aktuális szöveg: %@",((UITextField*)sender).text);
    
    UITableViewCell* cell = (UITableViewCell*)[[sender superview] superview];
    
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    
    //if cell is visible then indexPath is not nil
    if (indexPath)
    {
        NSString* attributeName = [[_content objectAtIndex:indexPath.section - 1] valueForKey:@"attrName"];
        
        if ([attributeName isEqualToString:@"name"])
        {
            if (_nameOfThePointObject)
            {
                [_nameOfThePointObject release], _nameOfThePointObject = nil;
            }
            
            _nameOfThePointObject = [((UITextField*)sender).text copy];
            
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        [[_content objectAtIndex:indexPath.section - 1] setValue:((UITextField*)sender).text forKey:@"value"];
        
        //add value to the edited node
        NSMutableDictionary* newTags = [[self.editedPointObject.tags mutableCopy] autorelease];
        [newTags setValue:((UITextField*)sender).text forKey:attributeName];
        [self.editedPointObject setTags:newTags];
    }
    
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
    
    [_nameOfThePointObject release], _nameOfThePointObject = nil;
    
    [super dealloc];
}

@end
