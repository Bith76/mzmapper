//
//  MZOpenStreetBugsViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//

#import "MZOpenStreetBugsViewController.h"

@interface MZOpenStreetBugsViewController ()

@end

@implementation MZOpenStreetBugsViewController

@synthesize okButton, cancelButton, aPopoverController;

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
    
    UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:insets];
    UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    [self.okButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [self.okButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [self.cancelButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
}

- (IBAction)cancelButtonTouched:(id)sender
{
    [self.aPopoverController dismissPopoverAnimated:NO];
    
    [self.aPopoverController performSelector:@selector(release) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.cancelButton = nil;
    self.okButton = nil;
    
    [super dealloc];
}

@end
