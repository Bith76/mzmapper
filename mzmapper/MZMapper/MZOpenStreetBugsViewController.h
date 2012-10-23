//
//  MZOpenStreetBugsViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//

#import <UIKit/UIKit.h>

@interface MZOpenStreetBugsViewController : UIViewController
{
    
}

@property (nonatomic, retain) IBOutlet UIButton*        cancelButton;
@property (nonatomic, retain) IBOutlet UIButton*        okButton;
@property (nonatomic, retain) UIPopoverController*		aPopoverController;

- (IBAction)cancelButtonTouched:(id)sender;

@end
