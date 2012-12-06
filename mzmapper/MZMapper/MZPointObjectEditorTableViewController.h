//
//  MZPointObjectEditorTableViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//

#import "MZPointObjectTypeSelectorTableViewController.h"

@class MZNode;

@interface MZPointObjectEditorTableViewController : UITableViewController <MZPointObjectTypeSelectorTableViewControllerDelegate>
{
    NSString*       _headerCellIdentifier;
    NSString*       _typeChooserCellIdentifier;
    NSString*       _generalCellIdentifier;
    
    NSMutableArray* _content; //contains editable attributes for the given point object from schema
    
    BOOL            _enableDeleteButton;
    NSString*       _nameOfThePointObject;
}

@property (nonatomic, assign) MZMapperViewController*   controller;
@property (nonatomic, copy) MZNode*                     editedPointObject;

- (id)initWithDeleteButton:(BOOL)enableDeleteButton;

@end
