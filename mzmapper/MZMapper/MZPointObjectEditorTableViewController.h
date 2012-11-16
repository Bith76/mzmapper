//
//  MZPointObjectEditorTableViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/15/12.
//
//


@interface MZPointObjectEditorTableViewController : UITableViewController
{
    NSString* _headerCellIdentifier;
    NSString* _typeChooserCellIdentifier;
}

@property (nonatomic, assign) MZMapperViewController*   controller;
@property (nonatomic, retain) UIImage*                  image;
@property (nonatomic, retain) NSString*                 pointObjectName;

@end
