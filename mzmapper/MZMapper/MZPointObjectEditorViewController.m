//
//  MZPointObjectEditorViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/13/12.
//
//

#import "MZPointObjectEditorViewController.h"
#import "MZMapperViewController.h"
#import "MZNode.h"

@interface MZPointObjectEditorViewController ()

@end

@implementation MZPointObjectEditorViewController

@synthesize controller, image, imageView, nameLabel, typeButton, mainScrollView, tabBar;

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
    
    [self.imageView setImage:self.image];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
    
    UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"blackButton.png"] resizableImageWithCapInsets:insets];
    UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"blackButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    [self.typeButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [self.typeButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:0]];
}

- (IBAction)infoButtonTouched:(id)sender
{
    MZNode* selectedPointObject = self.controller.selectedPointObject;
    
    NSString* type = [[MZMapperContentManager sharedContentManager] typeForNode:selectedPointObject];
    NSString* subType = [[MZMapperContentManager sharedContentManager] subTypeForNode:selectedPointObject];
    
    NSURL* infoUrl = [NSURL URLWithString:[[NSString stringWithFormat:@"http://wiki.openstreetmap.org/wiki/Tag:%@=%@",type,subType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest* request = [NSURLRequest requestWithURL:infoUrl];
    
    
    UIViewController* infoViewController = [[UIViewController alloc] init];
    [infoViewController setContentSizeForViewInPopover:CGSizeMake(800.0, 500.0)];
    UIWebView* infoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 735.0, 500.0)];
    [infoViewController.view addSubview:infoWebView];
    [infoWebView loadRequest:request];
    
    UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:infoViewController];
    [popoverController presentPopoverFromRect:((UIButton*)sender).frame inView:self.mainScrollView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
