//
//  MZOpenStreetBugsViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//

#import "MZOpenStreetBugsViewController.h"
#import "MZMapperViewController.h"
#import "MZOpenStreetBug.h"
#import "MZNode.h"
#import "MZRESTRequestManager.h"

@interface MZOpenStreetBugsViewController ()

@end

@implementation MZOpenStreetBugsViewController

@synthesize controller;
@synthesize aPopoverController;
@synthesize imageViewForBug;
@synthesize node;

//designated initializer
- (id)initWithControllerType:(MZOpenStreetBugsViewControllerType)type andWithBug:(MZOpenStreetBug*)bug;
{
    self = [super initWithNibName:@"MZOpenStreetBugsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        
        _type = type;
        
        _bug = [bug retain];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithControllerType:MZOpenStreetBugsViewControllerTypeCreateBug andWithBug:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
    
    UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:insets];
    UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    switch (_type)
    {
        case MZOpenStreetBugsViewControllerTypeCreateBug:
        {
            [self setView:_createView];
            
            [_createViewOkButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
            [_createViewOkButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
            
            [_createViewCancelButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
            [_createViewCancelButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
        }
            break;
        case MZOpenStreetBugsViewControllerTypeFixedBug:
        {
            [self setView:_fixedView];
            
            CGSize constraint = CGSizeMake(_fixedViewDescriptionLabel.frame.size.width, 20000.0f);
            
            CGSize size = [_bug.description sizeWithFont:_fixedViewDescriptionLabel.font constrainedToSize:constraint lineBreakMode:_fixedViewDescriptionLabel.lineBreakMode];
            
            CGRect descLabelFrame = _fixedViewDescriptionLabel.frame;
            descLabelFrame.size.height = size.height;
            
            [_fixedViewDescriptionLabel setFrame:descLabelFrame];
            [_fixedViewDescriptionLabel setText:_bug.description];
            
            if ([_bug.comments count])
            {
                //adjust comment label frame
                CGRect titleLabelFrame = _fixedViewCommentTitleLabel.frame;
                titleLabelFrame.origin.y = _fixedViewDescriptionLabel.frame.origin.y + _fixedViewDescriptionLabel.frame.size.height + 16.0;
                [_fixedViewCommentTitleLabel setFrame:titleLabelFrame];
                
                
                CGRect prevCommentFrame = CGRectZero;
                
                for (NSUInteger i = 0; i < [_bug.comments count]; i++)
                {
                    NSString* comment = [_bug.comments objectAtIndex:i];
                    
                    UILabel* commentLabel = [[UILabel alloc] initWithFrame:_fixedViewDescriptionLabel.frame];
                    [commentLabel setFont:_fixedViewDescriptionLabel.font];
                    [commentLabel setLineBreakMode:_fixedViewDescriptionLabel.lineBreakMode];
                    [commentLabel setNumberOfLines:_fixedViewDescriptionLabel.numberOfLines];
                    
                    UILabel* commentTitleLabel = nil;
                    if (i > 0) //the first "Comment" label is created from xib (called _fixedViewCommentTitleLabel)
                    {
                        commentTitleLabel = [[UILabel alloc] initWithFrame:_fixedViewCommentTitleLabel.frame];
                        [commentTitleLabel setFont:_fixedViewCommentTitleLabel.font];
                        [commentTitleLabel setLineBreakMode:_fixedViewCommentTitleLabel.lineBreakMode];
                        [commentTitleLabel setNumberOfLines:_fixedViewCommentTitleLabel.numberOfLines];
                        [commentTitleLabel setTextAlignment:_fixedViewCommentTitleLabel.textAlignment];
                        [commentTitleLabel setText:_fixedViewCommentTitleLabel.text];
                    }
                    
                    size = [comment sizeWithFont:commentLabel.font constrainedToSize:constraint lineBreakMode:commentLabel.lineBreakMode];
                    CGRect newFrame = commentLabel.frame;
                    if (CGRectEqualToRect(prevCommentFrame, CGRectZero)) //this is the first comment
                    {
                        newFrame.origin.y = _fixedViewCommentTitleLabel.frame.origin.y;
                    }
                    else
                    {
                        newFrame.origin.y = prevCommentFrame.origin.y + prevCommentFrame.size.height + 10.0;
                    }
                    newFrame.size.height = size.height;
                    [commentLabel setFrame:newFrame];
                    
                    prevCommentFrame = newFrame;
                    
                    [commentLabel setText:comment];
                    
                    [self.view addSubview:commentLabel];
                    
                    [commentLabel release];
                    
                    if (i > 0) //the first "Comment" label is created from xib (called _fixedViewCommentTitleLabel)
                    {
                        CGRect commentTitleLabelFrame = commentTitleLabel.frame;
                        commentTitleLabelFrame.origin.y = commentLabel.frame.origin.y;
                        [commentTitleLabel setFrame:commentTitleLabelFrame];
                        
                        [self.view addSubview:commentTitleLabel];
                        
                        [commentTitleLabel release];
                    }
                }
                
                CGRect footerViewFrame = _fixedViewFooterView.frame;
                footerViewFrame.origin.y = prevCommentFrame.origin.y + prevCommentFrame.size.height + 16.0;
                
                [_fixedViewFooterView setFrame:footerViewFrame];
                
                
                CGFloat contentHeight = _fixedViewFooterView.frame.origin.y + _fixedViewFooterView.frame.size.height;
                CGFloat maxContentHeight = 400.0;
                
                if (self.contentSizeForViewInPopover.height < contentHeight)
                {
                    if (contentHeight < maxContentHeight)
                    {
                        [self setContentSizeForViewInPopover:CGSizeMake(self.contentSizeForViewInPopover.width, contentHeight)];
                    }
                    else
                    {
                        [self setContentSizeForViewInPopover:CGSizeMake(self.contentSizeForViewInPopover.width, maxContentHeight)];
                        _fixedView.contentSize = CGSizeMake(_fixedView.contentSize.width, contentHeight);
                    }
                }
            }
            else
            {
                [_fixedViewCommentTitleLabel setHidden:YES];
            }
        }
            break;
        case MZOpenStreetBugsViewControllerTypeUnresolvedBug:
        {
            [self setView:_unresolvedView];
            
            [_unresolvedAddCommentButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
            [_unresolvedAddCommentButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
            
            [_unresolvedMarkAsFixedButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
            [_unresolvedMarkAsFixedButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
            
            CGSize constraint = CGSizeMake(_unresolvedViewDescriptionLabel.frame.size.width, 20000.0f);
            
            CGSize size = [_bug.description sizeWithFont:_unresolvedViewDescriptionLabel.font constrainedToSize:constraint lineBreakMode:_unresolvedViewDescriptionLabel.lineBreakMode];
            
            CGRect descLabelFrame = _unresolvedViewDescriptionLabel.frame;
            descLabelFrame.size.height = size.height;
            
            [_unresolvedViewDescriptionLabel setFrame:descLabelFrame];
            [_unresolvedViewDescriptionLabel setText:_bug.description];
            
            if ([_bug.comments count])
            {
                //adjust comment label frame
                CGRect titleLabelFrame = _unresolvedViewCommentTitleLabel.frame;
                titleLabelFrame.origin.y = _unresolvedViewDescriptionLabel.frame.origin.y + _unresolvedViewDescriptionLabel.frame.size.height + 16.0;
                [_unresolvedViewCommentTitleLabel setFrame:titleLabelFrame];
                
                
                CGRect prevCommentFrame = CGRectZero;
                
                for (NSUInteger i = 0; i < [_bug.comments count]; i++)
                {
                    NSString* comment = [_bug.comments objectAtIndex:i];
                    
                    UILabel* commentLabel = [[UILabel alloc] initWithFrame:_unresolvedViewDescriptionLabel.frame];
                    [commentLabel setFont:_unresolvedViewDescriptionLabel.font];
                    [commentLabel setLineBreakMode:_unresolvedViewDescriptionLabel.lineBreakMode];
                    [commentLabel setNumberOfLines:_unresolvedViewDescriptionLabel.numberOfLines];
                    
                    UILabel* commentTitleLabel = nil;
                    if (i > 0) //the first "Comment" label is created from xib (called _unresolvedViewCommentTitleLabel)
                    {
                        commentTitleLabel = [[UILabel alloc] initWithFrame:_unresolvedViewCommentTitleLabel.frame];
                        [commentTitleLabel setFont:_unresolvedViewCommentTitleLabel.font];
                        [commentTitleLabel setLineBreakMode:_unresolvedViewCommentTitleLabel.lineBreakMode];
                        [commentTitleLabel setNumberOfLines:_unresolvedViewCommentTitleLabel.numberOfLines];
                        [commentTitleLabel setTextAlignment:_unresolvedViewCommentTitleLabel.textAlignment];
                        [commentTitleLabel setText:_unresolvedViewCommentTitleLabel.text];
                    }
                    
                    size = [comment sizeWithFont:commentLabel.font constrainedToSize:constraint lineBreakMode:commentLabel.lineBreakMode];
                    CGRect newFrame = commentLabel.frame;
                    if (CGRectEqualToRect(prevCommentFrame, CGRectZero)) //this is the first comment
                    {
                        newFrame.origin.y = _unresolvedViewCommentTitleLabel.frame.origin.y;
                    }
                    else
                    {
                        newFrame.origin.y = prevCommentFrame.origin.y + prevCommentFrame.size.height + 10.0;
                    }
                    newFrame.size.height = size.height;
                    [commentLabel setFrame:newFrame];
                    
                    prevCommentFrame = newFrame;
                    
                    [commentLabel setText:comment];
                    
                    [self.view addSubview:commentLabel];
                    
                    [commentLabel release];
                    
                    if (i > 0) //the first "Comment" label is created from xib (called _unresolvedViewCommentTitleLabel)
                    {
                        CGRect commentTitleLabelFrame = commentTitleLabel.frame;
                        commentTitleLabelFrame.origin.y = commentLabel.frame.origin.y;
                        [commentTitleLabel setFrame:commentTitleLabelFrame];
                        
                        [self.view addSubview:commentTitleLabel];
                        
                        [commentTitleLabel release];
                    }
                }
                
                CGRect footerViewFrame = _unresolvedViewFooterView.frame;
                footerViewFrame.origin.y = prevCommentFrame.origin.y + prevCommentFrame.size.height + 16.0;
                
                [_unresolvedViewFooterView setFrame:footerViewFrame];
                
                
                CGFloat contentHeight = _unresolvedViewFooterView.frame.origin.y + _unresolvedViewFooterView.frame.size.height;
                CGFloat maxContentHeight = 400.0;
                
                if (self.contentSizeForViewInPopover.height < contentHeight)
                {
                    if (contentHeight < maxContentHeight)
                    {
                        [self setContentSizeForViewInPopover:CGSizeMake(self.contentSizeForViewInPopover.width, contentHeight)];
                    }
                    else
                    {
                        [self setContentSizeForViewInPopover:CGSizeMake(self.contentSizeForViewInPopover.width, maxContentHeight)];
                        _unresolvedView.contentSize = CGSizeMake(_unresolvedView.contentSize.width, contentHeight);
                    }
                }
            }
            else
            {
                [_unresolvedViewCommentTitleLabel setHidden:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.aPopoverController setDelegate:self];
}

- (IBAction)cancelButtonTouched:(id)sender
{
    if (_type == MZOpenStreetBugsViewControllerTypeCreateBug && self.imageViewForBug && self.imageViewForBug.superview)
    {
        [self.imageViewForBug removeFromSuperview];
    }
    
    [self.aPopoverController dismissPopoverAnimated:YES];
    
    [self.aPopoverController performSelector:@selector(release) withObject:nil afterDelay:0.5];
}

- (IBAction)createViewOkButtonTouched:(id)sender
{
    NSString* description = _createViewDescriptionTextField.text;
    NSString* author = _createViewNicknameTextField.text;
    
    NSString* message = nil;
    
    if ([description isEqualToString:@""])
    {
        message = NSLocalizedString(@"PleaseAddCommentKey", @"Alert view message - alert view displays when user doesn't comment his OSMBug report");
    }
    else if ([author isEqualToString:@""])
    {
        message = NSLocalizedString(@"AddNamePleaseKey", @"Alert view message - alert view displays when user doesn't add his name by creating OSMBug report");
    }
    
    if (message)
    {
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorKey", @"Alert view title - alert view displays when user makes a mistake by creating OSMBug report") message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OkKey", @"") otherButtonTitles:nil];
        [av show];
        [av release];
    }
    else
    {
        [_createViewDescriptionTextField resignFirstResponder];
        [_createViewNicknameTextField resignFirstResponder];
        
        NSString* textParameter = [[NSString stringWithFormat:@"%@ [%@]", description, author] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //http://openstreetbugs.schokokeks.org/api/0.1/addPOIexec?lat=<Latitude>&lon=<Longitude>&text=<Bug description with author and date>&format=<Output format>
        
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openstreetbugs.schokokeks.org/api/0.1/addPOIexec?lat=%f&lon=%f&text=%@", self.node.latitude, self.node.longitude, textParameter]];
                
        MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
        
        [downloader downloadRequestFromURL:url
                           progressHandler:nil
                         completionHandler:^(NSString* resultString){
                             
                             if (![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                             {                                 
                                 [self.controller refreshOpenStreetBugs];
                                 
                                 [self.aPopoverController dismissPopoverAnimated:YES];
                                 
                                 [self.aPopoverController performSelector:@selector(release) withObject:nil afterDelay:0.5];
                             }
                         }];
        
        [downloader release];
        [url release];
    }
    
}

- (IBAction)addCommentOkButtonTouched:(id)sender
{
    NSString* comment = _addCommentCommentTextField.text;
    NSString* author = _addCommentNicknameTextField.text;
    
    NSString* message = nil;
    
    if ([comment isEqualToString:@""])
    {
        message = NSLocalizedString(@"PleaseAddCommentKey", @"Alert view message - alert view displays when user doesn't comment his OSMBug report");
    }
    else if ([author isEqualToString:@""])
    {
        message = NSLocalizedString(@"AddNamePleaseKey", @"Alert view message - alert view displays when user doesn't add his name by creating OSMBug report");
    }
    
    if (message)
    {
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorKey", @"Alert view title - alert view displays when user makes a mistake by creating OSMBug report") message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OkKey", @"") otherButtonTitles:nil];
        [av show];
        [av release];
    }
    else
    {
        [_addCommentCommentTextField resignFirstResponder];
        [_addCommentNicknameTextField resignFirstResponder];
        
        NSString* textParameter = [[NSString stringWithFormat:@"%@ [%@]", comment, author] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //http://openstreetbugs.schokokeks.org/api/0.1/editPOIexec?id=<Bug ID>&text=<Comment with author and date>&format=<Output format>
        
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openstreetbugs.schokokeks.org/api/0.1/editPOIexec?id=%@&text=%@", _bug.bugID, textParameter]];
                
        MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
        
        [downloader downloadRequestFromURL:url
                           progressHandler:nil
                         completionHandler:^(NSString* resultString){
                             
                             if (![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                             {                                 
                                 [self.controller refreshOpenStreetBugs];
                                 
                                 [self.aPopoverController dismissPopoverAnimated:YES];
                                 
                                 [self.aPopoverController performSelector:@selector(release) withObject:nil afterDelay:0.5];
                             }
                         }];
        
        [downloader release];
        [url release];
    }
}

- (IBAction)markAsFixedButtonTouched:(id)sender
{
    UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
    
    UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:insets];
    UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    [_markAsFixedYesButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_markAsFixedYesButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [_markAsFixedNoButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_markAsFixedNoButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [_markAsFixedDescriptionLabel setText:_unresolvedViewDescriptionLabel.text];
    
    CGSize constraint = CGSizeMake(_markAsFixedDescriptionLabel.frame.size.width, 20000.0f);
    CGSize size = [_markAsFixedDescriptionLabel.text sizeWithFont:_markAsFixedDescriptionLabel.font constrainedToSize:constraint lineBreakMode:_markAsFixedDescriptionLabel.lineBreakMode];
    
    CGRect descLabelFrame = _markAsFixedDescriptionLabel.frame;
    descLabelFrame.size.height = size.height;
    [_markAsFixedDescriptionLabel setFrame:descLabelFrame];
    
    CGRect footerViewFrame = _markAsFixedFooterView.frame;
    footerViewFrame.size.height = size.height + 20.0;
    [_markAsFixedFooterView setFrame:footerViewFrame];
    
    [_markAsFixedViewController setTitle:@"OpenStreetBug"];
    [_markAsFixedViewController.navigationItem setHidesBackButton:YES];
    
    [self.navigationController pushViewController:_markAsFixedViewController animated:YES];
}

- (IBAction)markAsFixedYesButtonTouched:(id)sender
{    
    NSString* comment = _markAsFixedCommentTextField.text;
    NSString* author = _markAsFixedNicknameTextField.text;
    
    [_markAsFixedCommentTextField resignFirstResponder];
    [_markAsFixedNicknameTextField resignFirstResponder];
    
    if (![comment isEqualToString:@""] || ![author isEqualToString:@""])
    {
        NSString* textParameter = [[NSString stringWithFormat:@"%@ [%@]", comment, author] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //http://openstreetbugs.schokokeks.org/api/0.1/editPOIexec?id=<Bug ID>&text=<Comment with author and date>&format=<Output format>
        
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openstreetbugs.schokokeks.org/api/0.1/editPOIexec?id=%@&text=%@", _bug.bugID, textParameter]];
                
        MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
        
        [downloader downloadRequestFromURL:url
                           progressHandler:nil
                         completionHandler:^(NSString* resultString){
                             
                             if (![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                             {
                                 //http://openstreetbugs.schokokeks.org/api/0.1/closePOIexec?id=<Bug ID>
                                 
                                 NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openstreetbugs.schokokeks.org/api/0.1/closePOIexec?id=%@", _bug.bugID]];
                                                                  
                                 MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
                                 
                                 [downloader downloadRequestFromURL:url
                                                    progressHandler:nil
                                                  completionHandler:^(NSString* resultString){
                                                      
                                                      if (![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                                                      {                                                          
                                                          [self.controller refreshOpenStreetBugs];
                                                          
                                                          [self.aPopoverController dismissPopoverAnimated:YES];
                                                          
                                                          [self.aPopoverController performSelector:@selector(release) withObject:nil afterDelay:0.5];
                                                      }
                                                  }];
                                 
                                 [downloader release];
                                 [url release];
                             }
                         }];
        
        [downloader release];
        [url release];
    }
    else
    {
        //http://openstreetbugs.schokokeks.org/api/0.1/closePOIexec?id=<Bug ID>
        
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openstreetbugs.schokokeks.org/api/0.1/closePOIexec?id=%@", _bug.bugID]];
                
        MZRESTRequestManager* downloader = [[MZRESTRequestManager alloc] init];
        
        [downloader downloadRequestFromURL:url
                           progressHandler:nil
                         completionHandler:^(NSString* resultString){
                             
                             if (![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                             {                                 
                                 [self.controller refreshOpenStreetBugs];
                                 
                                 [self.aPopoverController dismissPopoverAnimated:YES];
                                 
                                 [self.aPopoverController performSelector:@selector(release) withObject:nil afterDelay:0.5];
                             }
                         }];
        
        [downloader release];
        [url release];
    }
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if (_type == MZOpenStreetBugsViewControllerTypeCreateBug && self.imageViewForBug && self.imageViewForBug.superview)
    {
        [self.imageViewForBug removeFromSuperview];
    }
    
    return YES;
}

- (IBAction)addCommentButtonTouched:(id)sender
{
    UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
    
    UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:insets];
    UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:insets];
    
    [_addCommentOkButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_addCommentOkButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [_addCommentCancelButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [_addCommentCancelButton setBackgroundImage:highlightedButtonBGImage forState:UIControlStateHighlighted];
    
    [_addCommentDescriptionLabel setText:_unresolvedViewDescriptionLabel.text];
    
    CGSize constraint = CGSizeMake(_addCommentDescriptionLabel.frame.size.width, 20000.0f);
    CGSize size = [_addCommentDescriptionLabel.text sizeWithFont:_addCommentDescriptionLabel.font constrainedToSize:constraint lineBreakMode:_addCommentDescriptionLabel.lineBreakMode];
    
    CGRect descLabelFrame = _addCommentDescriptionLabel.frame;
    descLabelFrame.size.height = size.height;
    [_addCommentDescriptionLabel setFrame:descLabelFrame];
    
    CGRect footerViewFrame = _addCommentFooterView.frame;
    footerViewFrame.origin.y = _addCommentDescriptionLabel.frame.origin.y + size.height + 10.0;
    [_addCommentFooterView setFrame:footerViewFrame];
       
    [_addCommentViewController setTitle:@"OpenStreetBug"];
    [_addCommentViewController.navigationItem setHidesBackButton:YES];
    
    //self.navigationController.delegate = self;
    [self.navigationController pushViewController:_addCommentViewController animated:YES];
}

- (IBAction)addCommentCancelButtonTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (_bug)
    {
        [_bug release];
    }
    
    [super dealloc];
}

@end
