//
//  MZDraggedCategoryItemView.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/2/12.
//
//

#import "MZDraggedCategoryItemView.h"

#define ARROW_HEIGHT 10.0

@implementation MZDraggedCategoryItemView

@synthesize arrowIsVisible = _arrowIsVisible;
@synthesize arrowHeight = _arrowHeight;

//designated initializer
- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)anImage
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _image = [anImage retain];
        
        _originalSize = frame.size;
        
        _arrowHeight = ARROW_HEIGHT;
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withImage:nil];
}

- (void)setArrowIsVisible:(BOOL)arrowIsVisible
{
    if (_arrowIsVisible != arrowIsVisible)
	{
		_arrowIsVisible = arrowIsVisible;
        
        if (_arrowIsVisible)
        {
            [self setBounds:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height + ARROW_HEIGHT)];
            
            [self setCenter:CGPointMake(self.center.x, self.center.y + ARROW_HEIGHT / 2.0)];
        }
        else
        {
            [self setBounds:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height - ARROW_HEIGHT)];
            
            [self setCenter:CGPointMake(self.center.x, self.center.y - ARROW_HEIGHT / 2.0)];
        }
		
		[self setNeedsDisplay];
	}
}

- (CGFloat)arrowHeight
{
    return _arrowHeight;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat arrowWidth = 16.0;
    
    if (_arrowIsVisible)
    {
        //draw image
        [_image drawInRect:CGRectMake(0.0, 0.0, _originalSize.width, _originalSize.height)];
        
        //draw little arrow
        UIBezierPath* bp = [UIBezierPath bezierPath];
        [bp moveToPoint:CGPointMake((rect.size.width / 2.0) - (arrowWidth / 2.0), _originalSize.height)];
        [bp addLineToPoint:CGPointMake((rect.size.width / 2.0) + (arrowWidth / 2.0), _originalSize.height)];
        [bp addLineToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height)];
        [bp closePath];
        
        [[UIColor blackColor] set];
        
        [bp fill];
    }
    else
    {
        //draw image
        [_image drawInRect:self.bounds];
    }
}


- (void)dealloc
{
    [_image release], _image = nil;
    
    [super dealloc];
}

@end
