//
//  MZSavingPanelViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/28/12.
//
//

#import <UIKit/UIKit.h>

@interface MZSavingPanelViewController : UIViewController
{
    IBOutlet UIButton*      _okButton;
    IBOutlet UIButton*      _cancelButton;
    IBOutlet UITextView*    _textView;
}

- (IBAction)okButtonTouched:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;

@end
