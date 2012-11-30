//
//  MZSavingPanelViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/28/12.
//
//

#import "MZSavingPanelViewController.h"

@interface MZSavingPanelViewController ()

@end

@implementation MZSavingPanelViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
    
    UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"blueButton.png"] resizableImageWithCapInsets:insets];
    UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"blueButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    [_okButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_okButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    buttonBackgroundImage = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:insets];
    highlightedButtonBGImage = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    [_cancelButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [_endEditingButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_endEditingButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
}

- (IBAction)okButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if (_delegate && [_delegate respondsToSelector:@selector(savingPanelViewControllerWillSave:withComment:)])
    {
        [_delegate savingPanelViewControllerWillSave:self withComment:_textView.text];
    }
}

- (IBAction)cancelButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if (_delegate && [_delegate respondsToSelector:@selector(savingPanelViewControllerWillDismiss:)])
    {
        [_delegate savingPanelViewControllerWillDismiss:self];
    }
}

- (IBAction)endEditingButtonTouched:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if (_delegate && [_delegate respondsToSelector:@selector(savingPanelViewControllerWillCancelEditing:)])
    {
        [_delegate savingPanelViewControllerWillCancelEditing:self];
    }
}

/*
 iPad keyboard will not dismiss if modal view controller presentation style is UIModalPresentationFormSheet
 
 here is the response of an Apple engineer on the developer forums:
 
 Was your view by any chance presented with the UIModalPresentationFormSheet style? To avoid frequent in-and-out animations, the keyboard will sometimes remain on-screen even when there is no first responder. This is not a bug.
 */
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
