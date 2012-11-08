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

//designated initializer
- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)anImage
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _image = [anImage retain];
        
        _originalSize = frame.size;
        
        [self setBounds:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height + ARROW_HEIGHT)];
        
        [self setCenter:CGPointMake(self.center.x, self.center.y + ARROW_HEIGHT / 2.0)];
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withImage:nil];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat arrowWidth = 16.0;
    
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


- (void)dealloc
{
    [_image release], _image = nil;
    
    [super dealloc];
}

@end
