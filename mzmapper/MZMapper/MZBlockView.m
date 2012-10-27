//
//  MZBlockView.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/25/12.
//
//

#import <QuartzCore/QuartzCore.h>

#import "MZBlockView.h"


@interface MZBlockView ()
{
    UIView*                     _parentView;
    UIView*                     _blackCenterView;
    UIActivityIndicatorView*    _activityIndicator;
}

@end

@implementation MZBlockView

//designated initializer
- (id)initWithView:(UIView*)view
{
    if (view)
    {
        self = [super initWithFrame:view.bounds];
    }
    else
    {
        self = [super initWithFrame:CGRectZero];
    }
    
    if (self) {
        // Initialization code
        
        _parentView = [view retain];
        
        _blackCenterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_blackCenterView setBackgroundColor:[UIColor blackColor]];
        [_blackCenterView setAlpha:0.8];
        [_blackCenterView.layer setCornerRadius:10.0];
        [_blackCenterView setCenter:self.center];
        
        [self addSubview:_blackCenterView];
        
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activityIndicator setCenter:self.center];
        
        [self addSubview:_activityIndicator];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        [tap release];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithView:nil];
}

- (void)show
{
    if (!self.superview)
    {
        [_parentView addSubview:self];
        
        [UIView animateWithDuration:0.1 animations:^{
            [_blackCenterView setBounds:CGRectMake(0.0, 0.0, 100.0, 100.0)];
        } completion:^(BOOL finished) {
            [_activityIndicator startAnimating];
        }];   
    }
}

- (void)hide
{
    if (self.superview)
    {
        [_activityIndicator stopAnimating];
        
        [UIView animateWithDuration:0.1 animations:^{
            [_blackCenterView setBounds:CGRectZero];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_parentView release];
    
    [_blackCenterView release];
    
    [_activityIndicator release];
    
    [super dealloc];
}

@end
