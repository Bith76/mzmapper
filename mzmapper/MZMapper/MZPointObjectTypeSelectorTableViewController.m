//
//  MZPointObjectTypeSelectorTableViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//

#import "MZPointObjectTypeSelectorTableViewController.h"
#import "MZMapperContentManager.h"

@interface MZPointObjectTypeSelectorTableViewController ()

@end

@implementation MZPointObjectTypeSelectorTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        _content = [[NSMutableArray alloc] init];
        
        
        for (NSInteger i = 1; i < MZMapperPointCategoryCountOfCategories; i++)
        {
            
            
            NSMutableArray* categoryItemNames = [NSMutableArray array];
            NSMutableArray* categoryItemImages = [NSMutableArray array];
            
            if (i == MZMapperPointCategoryShopping)
            {
                for (NSInteger j = 0; j < MZMapperPointCategoryShoppingElementCountOfElements; j++)
                {
                    [categoryItemNames addObject:[NSString nameOfPointCategoryShoppingElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryShoppingElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryFoodAndDrink)
            {
                for (NSInteger j = 0; j < MZMapperPointCategoryFoodAndDrinkElementCountOfElements; j++)
                {
                    [categoryItemNames addObject:[NSString nameOfPointCategoryFoodAndDrinkElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryFoodAndDrinkElement:j]];
                }
            }
            else if (i == MZMapperPointCategoryAmenity)
            {
                for (NSInteger j = 0; j < MZMapperPointCategoryAmenityElementCountOfElements; j++)
                {
                    [categoryItemNames addObject:[NSString nameOfPointCategoryAmenityElement:j]];
                    [categoryItemImages addObject:[UIImage imageForPointCategoryAmenityElement:j]];
                }
            }
            
            NSMutableDictionary* sectionData = [NSMutableDictionary dictionary];
            [sectionData setValue:[NSString nameOfPointCategory:i] forKey:@"categoryName"];
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
    [headerLabel setText:@"Please select a type for the point object."];
    [headerLabel setFont:[UIFont systemFontOfSize:12.0]];
    
    [self.tableView setTableHeaderView:headerLabel];
    
    [headerLabel release];
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
    }
    
    [cell.imageView setImage:[[[_content objectAtIndex:indexPath.section] valueForKey:@"itemImages"] objectAtIndex:indexPath.row]];
    [cell.textLabel setText:[[[_content objectAtIndex:indexPath.section] valueForKey:@"itemNames"] objectAtIndex:indexPath.row]];
    // Configure the cell...
    
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
}

@end
