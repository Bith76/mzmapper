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

@class MZMapperViewController;
@class MZOpenStreetBug;
@class MZNode;

@interface MZOpenStreetBugsViewController : UIViewController <UIPopoverControllerDelegate>
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
    IBOutlet UIScrollView*              _unresolvedView;
    IBOutlet UILabel*                   _unresolvedViewDescriptionLabel;
    IBOutlet UILabel*                   _unresolvedViewCommentTitleLabel;
    IBOutlet UIView*                    _unresolvedViewFooterView;
    IBOutlet UIButton*                  _unresolvedAddCommentButton;
    IBOutlet UIButton*                  _unresolvedMarkAsFixedButton;
    
    //add comment view controller
    IBOutlet UIViewController*          _addCommentViewController;
    IBOutlet UILabel*                   _addCommentDescriptionLabel;
    IBOutlet UITextField*               _addCommentCommentTextField;
    IBOutlet UITextField*               _addCommentNicknameTextField;
    IBOutlet UIView*                    _addCommentFooterView;
    IBOutlet UIButton*                  _addCommentOkButton;
    IBOutlet UIButton*                  _addCommentCancelButton;
    
    //mark as fixed view controller
    IBOutlet UIViewController*          _markAsFixedViewController;
    IBOutlet UILabel*                   _markAsFixedDescriptionLabel;
    IBOutlet UITextField*               _markAsFixedCommentTextField;
    IBOutlet UITextField*               _markAsFixedNicknameTextField;
    IBOutlet UIView*                    _markAsFixedFooterView;
    IBOutlet UIButton*                  _markAsFixedYesButton;
    IBOutlet UIButton*                  _markAsFixedNoButton;
    
    
                     
}

@property (nonatomic, assign) MZMapperViewController*   controller;
@property (nonatomic, retain) UIPopoverController*		aPopoverController;
@property (nonatomic, retain) UIImageView*              imageViewForBug;
@property (nonatomic, retain) MZNode*                   node;   //to hold the latitude/longitude values by bug creating

- (IBAction)cancelButtonTouched:(id)sender;
- (IBAction)createViewOkButtonTouched:(id)sender;
- (IBAction)addCommentButtonTouched:(id)sender;
- (IBAction)addCommentOkButtonTouched:(id)sender;
- (IBAction)markAsFixedButtonTouched:(id)sender;
- (IBAction)markAsFixedYesButtonTouched:(id)sender;

//designated initializer
- (id)initWithControllerType:(MZOpenStreetBugsViewControllerType)type andWithBug:(MZOpenStreetBug*)bug;

@end
