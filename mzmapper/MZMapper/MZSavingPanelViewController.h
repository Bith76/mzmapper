//
//  MZSavingPanelViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/28/12.
//
//


@protocol MZSavingPanelViewControllerDelegate;

@interface MZSavingPanelViewController : UIViewController
{
    IBOutlet UIButton*      _okButton;
    IBOutlet UIButton*      _cancelButton;
    IBOutlet UIButton*      _endEditingButton;
    IBOutlet UITextView*    _textView;
}

@property (nonatomic, assign) id <MZSavingPanelViewControllerDelegate> delegate;

- (IBAction)okButtonTouched:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;
- (IBAction)endEditingButtonTouched:(id)sender;

@end


@protocol MZSavingPanelViewControllerDelegate <NSObject>

@optional
- (void)savingPanelViewControllerWillDismiss:(MZSavingPanelViewController*)savingPanelViewController;
- (void)savingPanelViewControllerWillSave:(MZSavingPanelViewController*)savingPanelViewController withComment:(NSString*)comment;
- (void)savingPanelViewControllerWillCancelEditing:(MZSavingPanelViewController*)savingPanelViewController;

@end