//
//  MZOpenStreetBugsViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/21/12.
//
//

#import "MZOpenStreetBugsViewController.h"
#import "MZOpenStreetBug.h"

@interface MZOpenStreetBugsViewController ()

@end

@implementation MZOpenStreetBugsViewController

@synthesize aPopoverController;

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
    
    switch (_type)
    {
        case MZOpenStreetBugsViewControllerTypeCreateBug:
        {
            [self setView:_createView];
            
            UIEdgeInsets insets = UIEdgeInsetsMake(18.0, 18.0, 17.0, 17.0);
            
            UIImage* buttonBackgroundImage = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:insets];
            UIImage* highlightedButtonBGImage = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:insets];
            
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
                
                
                [self setContentSizeForViewInPopover:CGSizeMake(self.view.frame.size.width, 200)];
                
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
                CGFloat maxContentHeight = 600.0;
                
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
        }
            break;
        default:
            break;
    }
    
    
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
    if (_bug)
    {
        [_bug release];
    }
    
    [super dealloc];
}

@end
