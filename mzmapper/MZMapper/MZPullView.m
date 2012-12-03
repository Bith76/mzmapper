//
//  MZPullView.m
//  MZPullViewSample
//
//  Created by Zalán Mergl on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZPullView.h"

@implementation MZPullView

@synthesize contentViewController = _contentViewController;
@synthesize shown = _shown;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 29.0, self.bounds.size.height / 2.0 - 40.0, 25.0, 80.0)];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
		_titleLabel.opaque = NO;
		_titleLabel.textColor = [UIColor lightGrayColor];
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.shadowColor = [UIColor darkGrayColor];
		_titleLabel.shadowOffset = CGSizeMake(0.0, 0.0);
		_titleLabel.text = @">";
		_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
		_titleLabel.userInteractionEnabled = YES;
        
        // tap gesture recognizer on the titleLabel
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleState)];
		tapGesture.numberOfTapsRequired = 1;
		
		[_titleLabel addGestureRecognizer:tapGesture];
		
		[tapGesture release];
		
		[self addSubview:_titleLabel];
        
        // swipe left gesture recognizer on self
        UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self addGestureRecognizer:swipeLeftGesture];
        
        [swipeLeftGesture release];

        // swipe right gesture recognizer on self
        UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
        
        [self addGestureRecognizer:swipeRightGesture];
        
        [swipeRightGesture release];
    }
    return self;
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (![[contentViewController class] isEqual:[_contentViewController class]] || ![contentViewController isEqual:_contentViewController])
    {
        if (_contentViewController.view.superview)
        {
            [_contentViewController.view removeFromSuperview];
        }
        
        [_contentViewController release];
        _contentViewController = [contentViewController retain];
    }
    
    [_contentViewController.view setFrame:CGRectMake(5.0, 10.0, self.frame.size.width - 40.0, self.frame.size.height - 20.0)];
    
    [self addSubview:_contentViewController.view];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextSaveGState(UIGraphicsGetCurrentContext());
    
	//CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(0.0, -1.0), 5.0, [[UIColor colorWithWhite:0.05 alpha:0.30] CGColor]);
    CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(1.0, -1.0), 5.0, [[UIColor colorWithWhite:0.05 alpha:0.30] CGColor]);
    
	UIBezierPath* bp = [UIBezierPath bezierPath];
	
	CGFloat curve = 10.0;
	CGFloat offset = 5.0;
	
	//[bp moveToPoint:CGPointMake(0.0, 20.0 + offset)];
    [bp moveToPoint:CGPointMake(self.bounds.size.width - 20.0 - offset, 0.0)];
	
    //[bp addLineToPoint:CGPointMake(self.bounds.size.width / 2.0 - 30.0 - curve, 20.0 + offset)];
    [bp addLineToPoint:CGPointMake(self.bounds.size.width - 20.0 - offset, self.bounds.size.height / 2.0 - 30.0 - curve)];
	
    
    //[bp addCurveToPoint:CGPointMake(self.bounds.size.width / 2.0 - 30.0, 20.0  - curve + offset) controlPoint1:CGPointMake(self.bounds.size.width / 2.0 - 30.0, 20.0 + offset) controlPoint2:CGPointMake(self.bounds.size.width / 2.0 - 30.0, 20.0 + offset)];
    [bp addCurveToPoint:CGPointMake(self.bounds.size.width - (20.0 - curve + offset), self.bounds.size.height / 2.0 - 30.0) controlPoint1:CGPointMake(self.bounds.size.width - (20.0 + offset), self.bounds.size.height / 2.0 - 30.0) controlPoint2:CGPointMake(self.bounds.size.width - (20.0 + offset), self.bounds.size.height / 2.0 - 30.0)];
    
	//[bp addLineToPoint:CGPointMake(self.bounds.size.width / 2.0 - 30.0, curve + offset)];
    [bp addLineToPoint:CGPointMake(self.bounds.size.width - (curve + offset), self.bounds.size.height / 2.0 - 30.0)];
    
	//[bp addCurveToPoint:CGPointMake(self.bounds.size.width / 2.0 - 30.0 + curve, 0.0 + offset) controlPoint1:CGPointMake(self.bounds.size.width / 2.0 - 30.0, 0.0 + offset) controlPoint2:CGPointMake(self.bounds.size.width / 2.0 - 30.0, 0.0 + offset)];
    [bp addCurveToPoint:CGPointMake(self.bounds.size.width - offset, self.bounds.size.height / 2.0 - 30.0 + curve) controlPoint1:CGPointMake(self.bounds.size.width - offset, self.bounds.size.height / 2.0 - 30.0) controlPoint2:CGPointMake(self.bounds.size.width - offset, self.bounds.size.height / 2.0 - 30.0)];
    
	//[bp addLineToPoint:CGPointMake(self.bounds.size.width / 2.0 + 30.0 - curve, 0.0 + offset)];
    [bp addLineToPoint:CGPointMake(self.bounds.size.width - offset, self.bounds.size.height / 2.0 + 30.0 - curve)];
    
	//[bp addCurveToPoint:CGPointMake(self.bounds.size.width / 2.0 + 30.0, curve + offset) controlPoint1:CGPointMake(self.bounds.size.width / 2.0 + 30.0, 0.0 + offset) controlPoint2:CGPointMake(self.bounds.size.width / 2.0 + 30.0, 0.0 + offset)];
    [bp addCurveToPoint:CGPointMake(self.bounds.size.width - (curve + offset), self.bounds.size.height / 2.0 + 30.0) controlPoint1:CGPointMake(self.bounds.size.width - offset, self.bounds.size.height / 2.0 + 30.0) controlPoint2:CGPointMake(self.bounds.size.width - offset, self.bounds.size.height / 2.0 + 30.0)];
    
	//[bp addLineToPoint:CGPointMake(self.bounds.size.width / 2.0 + 30.0, 20.0 - curve + offset)];
    [bp addLineToPoint:CGPointMake(self.bounds.size.width - (20.0 - curve + offset), self.bounds.size.height / 2.0 + 30.0)];
    
	//[bp addCurveToPoint:CGPointMake(self.bounds.size.width / 2.0 + 30.0 + curve, 20.0 + offset) controlPoint1:CGPointMake(self.bounds.size.width / 2.0 + 30.0, 20.0 + offset) controlPoint2:CGPointMake(self.bounds.size.width / 2.0 + 30.0, 20.0 + offset)];
    [bp addCurveToPoint:CGPointMake(self.bounds.size.width - (20.0 + offset), self.bounds.size.height / 2.0 + 30.0 + curve) controlPoint1:CGPointMake(self.bounds.size.width - (20.0 + offset), self.bounds.size.height / 2.0 + 30.0) controlPoint2:CGPointMake(self.bounds.size.width - (20.0 + offset), self.bounds.size.height / 2.0 + 30.0)];
    
	//[bp addLineToPoint:CGPointMake(self.bounds.size.width, 20.0 + offset)];
    [bp addLineToPoint:CGPointMake(self.bounds.size.width - (20.0 + offset), self.bounds.size.height)];
    
	//[bp addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [bp addLineToPoint:CGPointMake(0.0, self.bounds.size.height)];
    
	//[bp addLineToPoint:CGPointMake(0.0, self.bounds.size.height)];
    [bp addLineToPoint:CGPointMake(0.0, 0.0)];
    
    //[bp addLineToPoint:CGPointMake(0.0, 20.0 + offset)];
    [bp addLineToPoint:CGPointMake(self.bounds.size.width - (20.0 + offset), 0.0)];
    
	[bp closePath];
    
	[[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood_pattern.jpg"]] set];
	
	[bp fill];
    
	CGContextRestoreGState(UIGraphicsGetCurrentContext());
    
	//CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(0.0, 1.0), 1.0, [[UIColor colorWithWhite:1.0 alpha:0.75] CGColor]);
    CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(-1.0, 0.0), 1.0, [[UIColor colorWithWhite:1.0 alpha:0.75] CGColor]);
	
	[[UIColor darkGrayColor] set];
	
	[bp setLineWidth:2.0];
	
	CGContextSaveGState(UIGraphicsGetCurrentContext());
    
	CGContextAddPath(UIGraphicsGetCurrentContext(), [bp CGPath]);
	
	CGContextClip(UIGraphicsGetCurrentContext());
    
	[bp stroke];
	
	CGContextRestoreGState(UIGraphicsGetCurrentContext());

}

- (void)didMoveToSuperview
{
	CGRect newFrame = self.frame;
	newFrame.origin.x = - (newFrame.size.width - 30.0);
	
	self.frame = newFrame;
}

#pragma mark - private methods

- (void)toggleState
{
	if (!_shown) 
	{
		[self show];
	}
	else
	{
		[self hide];
	}
}
/*
- (void)didPan:(UIPanGestureRecognizer*)pan
{
	switch (pan.state) 
	{			
		case UIGestureRecognizerStateBegan:
		{
			_startingYCoord = self.frame.origin.y;
		}
			break;
            
		case UIGestureRecognizerStateEnded:
		{
			if (!_shown)
			{
				if ((self.frame.origin.y < self.superview.frame.size.height / 3.0 * 2.0) || ([pan velocityInView:self.superview].y < -750.0)) 
				{
					//not shown yet, but we pulled over 1/3 of the screen we show
					[self show];
				}
				else
				{
					//else hide
					[self hide];
				}
			}
			else
			{
				if ((self.frame.origin.y > self.superview.frame.size.height / 3.0 * 2.0) || ([pan velocityInView:self.superview].y > 750.0))
				{
					//already shown, but we pulled under 1/3 of the screen we hide
					[self hide];
				}
				else
				{
					//else show
					[self show];
				}
			}
		}
			break;
			
		default:
		{
//			CGPoint translationPoint = [pan translationInView:self.superview];
//            
//			NSInteger itemsPerRow = (self.bounds.size.width - 40.0) / (_itemSize.width + 10.0);
//			
//			NSInteger offset = ((self.bounds.size.width - 40.0) - (itemsPerRow * _itemSize.width)) / (itemsPerRow == 1 ? 1 : itemsPerRow - 1);
//			
//			NSInteger numberOfRows = [_content count] / itemsPerRow + ([_content count] % itemsPerRow ? 1 : 0);
//			
//			CGRect newFrame = self.superview.bounds;
//			newFrame.origin.y = self.superview.bounds.size.height - (65 + (numberOfRows * _itemSize.height + offset));
//			
//            //limit
//            if (newFrame.origin.y < 86.0) 
//            {
//                newFrame.origin.y = 86.0;
//            }
//            
//            
//			if (!_shown && (_startingYCoord + translationPoint.y < _startingYCoord) && _startingYCoord + translationPoint.y > newFrame.origin.y - 44.0) 
//			{
//				//do not allow the view to be pushed off the screen or pulled too high
//				CGRect myFrame = self.frame;
//				
//				myFrame.origin.y = _startingYCoord + translationPoint.y;
//								
//				self.frame = myFrame;
//			}	
//			else if (_shown && (_startingYCoord + translationPoint.y > _startingYCoord - 44.0))
//			{
//				//do not allow the view to be pulled too high
//				CGRect myFrame = self.frame;
//				
//				myFrame.origin.y = _startingYCoord + translationPoint.y;
//				
//				self.frame = myFrame;
//			}
		}
			break;
	}
}
*/
- (void)swipeLeft:(UISwipeGestureRecognizer*)swipe
{
	[self hide];
}

- (void)swipeRight:(UISwipeGestureRecognizer*)swipe
{
	[self show];
}

#pragma mark - action methods

- (void)show
{
    [_titleLabel setText:@"<"];
    
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration:0.5];
		
	CGRect newFrame = self.frame;
	newFrame.origin.x = 0.0;
	
	self.frame = newFrame;
    
	[UIView commitAnimations];
	
	_shown = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PullViewToggledState" object:nil];
}

- (void)hide
{
    [_titleLabel setText:@">"];
    
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration:0.5];
    
	CGRect newFrame = self.frame;
	newFrame.origin.x = - (newFrame.size.width - 30.0);
	
	self.frame = newFrame;
	
	[UIView commitAnimations];
	
	_shown = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PullViewToggledState" object:nil];
}

- (void)dealloc
{
    [_titleLabel release], _titleLabel = nil;
    
    [super dealloc];
}
@end
