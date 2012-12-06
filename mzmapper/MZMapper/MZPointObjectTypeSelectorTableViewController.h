//
//  MZPointObjectTypeSelectorTableViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//


@class MZPointObjectTypeSelectorTableViewController;

@protocol MZPointObjectTypeSelectorTableViewControllerDelegate <NSObject>

- (void)typeSelectorTableView:(MZPointObjectTypeSelectorTableViewController*)tableView didSelectObject:(NSUInteger)selectedObject;

@end


@class MZBlockView;

@interface MZPointObjectTypeSelectorTableViewController : UITableViewController <UIPopoverControllerDelegate, UIWebViewDelegate>
{
@private
    NSMutableArray* _content;
    MZBlockView* _blockView;
}

@property (nonatomic, retain) MZNode*   editedPointObject;
@property (nonatomic, assign) id<MZPointObjectTypeSelectorTableViewControllerDelegate> delegate;

@end



