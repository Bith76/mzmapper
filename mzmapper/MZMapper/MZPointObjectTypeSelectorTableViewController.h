//
//  MZPointObjectTypeSelectorTableViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//

#import <UIKit/UIKit.h>

@class MZPointObjectTypeSelectorTableViewController;

@protocol MZPointObjectTypeSelectorTableViewControllerDelegate <NSObject>

- (void)typeSelectorTableView:(MZPointObjectTypeSelectorTableViewController*)tableView didSelectObject:(NSUInteger)selectedObject;

@end



@interface MZPointObjectTypeSelectorTableViewController : UITableViewController <UIPopoverControllerDelegate>
{
@private
    NSMutableArray* _content;
}

@property (nonatomic, retain) MZNode*   editedPointObject;
@property (nonatomic, assign) id<MZPointObjectTypeSelectorTableViewControllerDelegate> delegate;

@end



