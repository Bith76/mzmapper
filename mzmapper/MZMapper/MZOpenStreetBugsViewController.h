//
//  MZOpenStreetBugsViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//


enum
{
    MZOpenStreetBugsViewControllerTypeCreateBug = 0,
    MZOpenStreetBugsViewControllerTypeFixedBug,
    MZOpenStreetBugsViewControllerTypeUnresolvedBug
};
typedef NSUInteger MZOpenStreetBugsViewControllerType;

@class MZOpenStreetBug;

@interface MZOpenStreetBugsViewController : UIViewController
{
    MZOpenStreetBugsViewControllerType  _type;
    
    MZOpenStreetBug*                    _bug;
    
    //create view
    IBOutlet UIView*                    _createView;
    IBOutlet UITextField*               _createViewDescriptionTextField;
    IBOutlet UITextField*               _createViewNicknameTextField;
    IBOutlet UIButton*                  _createViewCancelButton;
    IBOutlet UIButton*                  _createViewOkButton;
    
    //fixed view
    IBOutlet UIScrollView*              _fixedView;
    IBOutlet UILabel*                   _fixedViewDescriptionLabel;
    IBOutlet UILabel*                   _fixedViewCommentTitleLabel;
    IBOutlet UIView*                    _fixedViewFooterView;
    
    //unresolved view
    IBOutlet UIView*                    _unresolvedView;
    
    
    
                     
}

@property (nonatomic, retain) UIPopoverController*		aPopoverController;

- (IBAction)cancelButtonTouched:(id)sender;

//designated initializer
- (id)initWithControllerType:(MZOpenStreetBugsViewControllerType)type andWithBug:(MZOpenStreetBug*)bug;

@end
