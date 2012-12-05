//
//  MZLoupeView.m
//  MZImageLoupe
//
//  Created by Zalan Mergl on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZLoupeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MZLoupeView

@synthesize viewToMagnify;
@synthesize touchPointInViewToMagnify;

- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
    {
        // Initialization code
        self.opaque = NO;
        super.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 4.0, [[UIColor colorWithWhite:0.05 alpha:0.8] CGColor]);
    UIBezierPath* bp = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5.0, 5.0, self.bounds.size.width - 10.0, self.bounds.size.height - 10.0)];
    [bp setLineWidth:2.0];
    [[UIColor colorWithWhite:0.43 alpha:1.0] set];
    [bp stroke];
    CGContextRestoreGState(context);
    
    
    UIBezierPath* bp3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5.0, 5.0, self.bounds.size.width - 10.0, self.bounds.size.height - 10.0)];
    [[UIColor colorWithWhite:0.91 alpha:1.0] set];    
    [bp3 fill];
    
    
    CGContextSaveGState(context);
    UIBezierPath* bp2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(9.0, 9.0, self.bounds.size.width - 18.0, self.bounds.size.height - 18.0)];
    [[UIColor colorWithWhite:0.43 alpha:1.0] set];
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 5.0, [[UIColor colorWithWhite:0.05 alpha:0.8] CGColor]);
    [bp2 stroke];
    CGContextRestoreGState(context);
        
    [bp2 addClip];
    
    
    // here we're just doing some transforms on the view we're magnifying,
	// and rendering that view directly into this view,
	// rather than the previous method of copying an image.
    CGContextSaveGState(context);
	CGContextTranslateCTM(context, self.frame.size.width * 0.5, self.frame.size.height * 0.5);
	CGContextScaleCTM(context, 2.0, 2.0);
	CGContextTranslateCTM(context, -touchPointInViewToMagnify.x, -touchPointInViewToMagnify.y);
	[self.viewToMagnify.layer renderInContext:context];
    CGContextRestoreGState(context);
	
    // Draw a circle (filled)
    CGContextSaveGState(context);
    CGContextSetRGBFillColor(context, 255.0, 0.0, 0.0, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(rect.size.width / 2.0 - 2.5, rect.size.width / 2.0 + 2.5, 5.0, 5.0));
    CGContextRestoreGState(context);
}
 

- (void)dealloc
{
    [super dealloc];
}


@end
