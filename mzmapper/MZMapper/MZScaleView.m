//
//  MZScaleView.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/30/12.
//
//

#import "MZScaleView.h"

@implementation MZScaleView

@synthesize displayString = _displayString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setDisplayString:(NSString *)displayString
{
    if (![_displayString isEqualToString:displayString])
	{
        [_displayString release];
        
        _displayString = [displayString retain];
        
        [self setNeedsDisplay];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
//    UIBezierPath* bp = [UIBezierPath bezierPathWithRect:rect];
//    [[UIColor lightGrayColor] set];
//    
//    [bp fill];
    
    [[UIColor blackColor] set];
    
    UIBezierPath* bp = [UIBezierPath bezierPath];
    CGFloat lineWidth = 1.0;
    [bp moveToPoint:CGPointMake(lineWidth, 0.0)];
    [bp addLineToPoint:CGPointMake(lineWidth, rect.size.height - lineWidth)];
    [bp addLineToPoint:CGPointMake(rect.size.width - lineWidth, rect.size.height - lineWidth)];
    [bp addLineToPoint:CGPointMake(rect.size.width - lineWidth, 0.0)];
    
    
    
    [bp setLineWidth:lineWidth];
    
    [bp stroke];
    
    [_displayString drawAtPoint:CGPointMake(5.0, 2.0) withFont:[UIFont systemFontOfSize:12.0]];
    
//    //draw little arrow
//    UIBezierPath* bp = [UIBezierPath bezierPath];
//    [bp moveToPoint:CGPointMake((rect.size.width / 2.0) - (arrowWidth / 2.0), _originalSize.height)];
//    [bp addLineToPoint:CGPointMake((rect.size.width / 2.0) + (arrowWidth / 2.0), _originalSize.height)];
//    [bp addLineToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height)];
//    [bp closePath];
//    
//    [[UIColor blackColor] set];
//    
//    [bp fill];
}


@end
