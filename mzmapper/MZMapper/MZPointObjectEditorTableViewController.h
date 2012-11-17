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
    NSString* _headerCellIdentifier;
    NSString* _typeChooserCellIdentifier;
}

@property (nonatomic, assign) MZMapperViewController*   controller;
@property (nonatomic, retain) MZNode*                   editedPointObject;
//@property (nonatomic, retain) UIImage*                  image;
//@property (nonatomic, retain) NSString*                 pointObjectName;
//@property (nonatomic, retain) NSString*                 pointObjectTypeName;

@end
