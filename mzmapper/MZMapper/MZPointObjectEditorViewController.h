//
//  MZPointObjectEditorViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/13/12.
//
//


@interface MZPointObjectEditorViewController : UINavigationController

@property (nonatomic, assign) MZMapperViewController*   controller;
@property (nonatomic, retain) UIImage*                  image;
@property (nonatomic, retain) IBOutlet UIImageView*     imageView;
@property (nonatomic, retain) IBOutlet UILabel*         nameLabel;
@property (nonatomic, retain) IBOutlet UIButton*        typeButton;
@property (nonatomic, retain) IBOutlet UIScrollView*    mainScrollView;
@property (nonatomic, retain) IBOutlet UITabBar*        tabBar;

- (IBAction)infoButtonTouched:(id)sender;

@end
