//
//  MZPointObjectEditorTableViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//

#import "MZPointObjectEditorTableViewController.h"
#import "MZPointObjectTypeSelectorTableViewController.h"

@interface MZPointObjectEditorTableViewController ()

@end

@implementation MZPointObjectEditorTableViewController

@synthesize controller, image, pointObjectName;

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
    
    _headerCellIdentifier = @"HeaderCell";
    _typeChooserCellIdentifier = @"TypeChooserCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MZPointObjectHeaderCell" bundle:nil] forCellReuseIdentifier:_headerCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MZPointObjectHeaderTypeCell" bundle:nil] forCellReuseIdentifier:_typeChooserCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"HeaderCell";
    UITableViewCell *cell = nil;
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
    
    // Configure the cell...
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:_headerCellIdentifier];
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
        [imageView setImage:self.image];
        
        UILabel* nameLabel = (UILabel*)[cell viewWithTag:2];
        [nameLabel setText:self.pointObjectName];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:_typeChooserCellIdentifier];
        UILabel* typeLabel = (UILabel*)[cell viewWithTag:1];
        [typeLabel setText:@"fajta"];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        MZPointObjectTypeSelectorTableViewController *detailViewController = [[MZPointObjectTypeSelectorTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [detailViewController setTitle:@"Types"];
        detailViewController.view.layer.cornerRadius = 5.0;
        
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* retVal = nil;
    
    if (section == 0)
    {
        //allocate the view if it doesn't exist yet
        UIView* footerView  = [[UIView alloc] init];
        
        //we would like to show a gloosy red button, so get the image first
        UIImage *image = [[UIImage imageNamed:@"orangeButton.png"]
                          stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        
        //the button should be as big as a table view cell
        [button setFrame:CGRectMake(10, 3, 300, 44)];
        
        //set title, font size and font color
        [button setTitle:@"Remove" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //set action of the button
        [button addTarget:self action:@selector(removeAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        //add the button to the view
        [footerView addSubview:button];
        
        //return the view for the footer
        retVal = footerView;
    }
    
    return retVal;
}

@end
