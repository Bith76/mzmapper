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

//@synthesize zoomImage;
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

//    NSLog(@"%s",__PRETTY_FUNCTION__);
//    NSLog(@"rect: %@",NSStringFromCGRect(rect));
//    NSLog(@"self.frame: %@",NSStringFromCGRect(self.frame));
//    NSLog(@"location: %@",NSStringFromCGPoint(touchPointInViewToMagnify));
//    
//
//    
//	CGFloat boxWidth = self.bounds.size.width;
//	CGFloat boxHeight = self.bounds.size.height;
//	
//	CGFloat _cornerRadius = 50.0;
    
    
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
    
    
    
    
    
    
	//gradient
	CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
//    CGFloat locations[2] = { 0.0, 1.0 };
//	const CGFloat *firstComponents			= CGColorGetComponents([[UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] CGColor]); 
//	const CGFloat *secondComponents			= CGColorGetComponents([[UIColor colorWithRed:224.0/255.0 green:225.0/255.0 blue:227.0/255.0 alpha:1.0] CGColor]); 
//	
//	CGFloat components[8] = {firstComponents[0], firstComponents[1], firstComponents[2], firstComponents[3], secondComponents[0], secondComponents[1], secondComponents[2], secondComponents[3]}; 	
//	
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
//	
    CGPoint topCenter = CGPointMake(CGRectGetMidX(self.bounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
//	CGGradientRef	mainGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
//	
//	CGContextDrawLinearGradient (context, mainGradient, topCenter, midCenter, 0);
//	
//	CGGradientRelease(mainGradient);
    
    
    
    //overlayes rész 
//	CGMutablePathRef overlayRectPath = CGPathCreateMutable();
//	CGPathMoveToPoint(overlayRectPath, NULL, _cornerRadius, 0.0);
//	CGPathAddLineToPoint(overlayRectPath, NULL, boxWidth-_cornerRadius, 0.0);
//	CGPathAddQuadCurveToPoint(overlayRectPath, NULL, boxWidth, 0.0, boxWidth, _cornerRadius);
//	CGPathAddLineToPoint(overlayRectPath, NULL, boxWidth, boxHeight / 4.0);
//	CGPathAddCurveToPoint(overlayRectPath, NULL, boxWidth / 4 * 3, boxHeight / 5, boxWidth / 4 * 3, boxHeight / 5, boxWidth / 2.0, boxHeight / 5);
//	CGPathAddCurveToPoint(overlayRectPath, NULL, boxWidth / 4, boxHeight / 5, boxWidth / 4, boxHeight / 5, 0.0, boxHeight / 4);
//	CGPathAddLineToPoint(overlayRectPath, NULL, 0.0, _cornerRadius);
//	CGPathAddQuadCurveToPoint(overlayRectPath, NULL, 0.0, 0.0, _cornerRadius, 0.0);
//	CGPathCloseSubpath(overlayRectPath);
    
    UIBezierPath* overlayBP = [UIBezierPath bezierPath];
//    [overlayBP moveToPoint:CGPointMake(9.0, 63.0)];
//    [overlayBP addCurveToPoint:CGPointMake(self.bounds.size.width - 9.0, 63.0) controlPoint1:CGPointMake(CGRectGetMidX(self.bounds), 63.0 + 58.0) controlPoint2:CGPointMake(CGRectGetMidX(self.bounds), 58.0 + 63.0)];
//    [overlayBP addCurveToPoint:CGPointMake(9.0, 63.0) controlPoint1:CGPointMake(CGRectGetMidX(self.bounds), 63.0 + 9.0) controlPoint2:CGPointMake(CGRectGetMidX(self.bounds), 63.0 + 9.0)];

    [overlayBP moveToPoint:CGPointMake(self.bounds.size.width - 9.0, 63.0)];
    [overlayBP addCurveToPoint:CGPointMake(9.0, 63.0) controlPoint1:CGPointMake(CGRectGetMidX(self.bounds), 0.0) controlPoint2:CGPointMake(CGRectGetMidX(self.bounds), 0.0)];
    [overlayBP addCurveToPoint:CGPointMake(self.bounds.size.width - 9.0, 63.0) controlPoint1:CGPointMake(CGRectGetMidX(self.bounds), 30) controlPoint2:CGPointMake(CGRectGetMidX(self.bounds), 30)];

    
    
    
	//clip
	CGContextSaveGState(context);
	//CGContextAddPath(context, overlayRectPath);
//-    [overlayBP fill];
    
	//CGContextClip(context);
//-    [overlayBP addClip];
    
    
	//overlay gradient
	CGFloat overlayLocations[2] = { 0.0, 1.0 };
	const CGFloat *firstOverlayComponents	= CGColorGetComponents([[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4] CGColor]); 
	const CGFloat *secondOverlayComponents	= CGColorGetComponents([[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2] CGColor]); 
	
	CGFloat overlayComponents[8] = {firstOverlayComponents[0], firstOverlayComponents[1], firstOverlayComponents[2], firstOverlayComponents[3], secondOverlayComponents[0], secondOverlayComponents[1], secondOverlayComponents[2], secondOverlayComponents[3]}; 	
	
//	CGGradientRef	overlayGradient = CGGradientCreateWithColorComponents(rgbColorspace, overlayComponents, overlayLocations, num_locations);
	
	
//-	CGContextDrawLinearGradient (context, overlayGradient, topCenter, midCenter, 0);
	
	CGContextRestoreGState(context);
    
    
    
    
    
    
    
    
    
    
    
    
    
//    // Drawing code.	
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	
//	CGRect currentBounds = self.bounds;
//	CGFloat boxWidth = self.bounds.size.width;
//	CGFloat boxHeight = self.bounds.size.height;
//	
//	CGFloat _cornerRadius = 50.0;
//	
//	CGMutablePathRef rectPath = CGPathCreateMutable();
//	CGPathMoveToPoint(rectPath, NULL, _cornerRadius, 0.0);
//	CGPathAddLineToPoint(rectPath, NULL, boxWidth-_cornerRadius, 0.0);
//	CGPathAddQuadCurveToPoint(rectPath, NULL, boxWidth, 0.0, boxWidth, _cornerRadius);
//	CGPathAddLineToPoint(rectPath, NULL, boxWidth, boxHeight-_cornerRadius);
//	CGPathAddQuadCurveToPoint(rectPath, NULL, boxWidth, boxHeight, boxWidth-_cornerRadius, boxHeight);
//	CGPathAddLineToPoint(rectPath, NULL, _cornerRadius, boxHeight);
//	CGPathAddQuadCurveToPoint(rectPath, NULL, 0.0, boxHeight, 0.0, boxHeight-_cornerRadius);
//	CGPathAddLineToPoint(rectPath, NULL, 0.0, _cornerRadius);
//	CGPathAddQuadCurveToPoint(rectPath, NULL, 0.0, 0.0, _cornerRadius, 0.0);
//	CGPathCloseSubpath(rectPath);
//		
//	//clip
//	CGContextAddPath(context, rectPath);
//	CGContextClip(context);
//
//	//gradient
//	CGColorSpaceRef rgbColorspace;
//    size_t num_locations = 2;
//    CGFloat locations[2] = { 0.0, 1.0 };
//	const CGFloat *firstComponents			= CGColorGetComponents([[UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] CGColor]); 
//	const CGFloat *secondComponents			= CGColorGetComponents([[UIColor colorWithRed:224.0/255.0 green:225.0/255.0 blue:227.0/255.0 alpha:1.0] CGColor]); 
//	
//	CGFloat components[8] = {firstComponents[0], firstComponents[1], firstComponents[2], firstComponents[3], secondComponents[0], secondComponents[1], secondComponents[2], secondComponents[3]}; 	
//	
//    rgbColorspace = CGColorSpaceCreateDeviceRGB();
//	
//    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
//    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));
//	CGGradientRef	mainGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
//	
//	CGContextDrawLinearGradient (context, mainGradient, topCenter, midCenter, 0);
//	
//	CGGradientRelease(mainGradient);
//	
//	//draw image
//	[zoomImage drawInRect:CGRectMake(0.0, 0.0, 100.0, rect.size.height)];
//	
//    // Draw a circle (filled)
//    CGContextSetRGBFillColor(context, 255.0, 0.0, 0.0, 1.0);
//    CGContextFillEllipseInRect(context, CGRectMake(rect.size.width / 2.0 - 2.5, rect.size.width / 2.0 + 2.5, 5.0, 5.0));
//    
//    
//	CGMutablePathRef overlayRectPath = CGPathCreateMutable();
//	CGPathMoveToPoint(overlayRectPath, NULL, _cornerRadius, 0.0);
//	CGPathAddLineToPoint(overlayRectPath, NULL, boxWidth-_cornerRadius, 0.0);
//	CGPathAddQuadCurveToPoint(overlayRectPath, NULL, boxWidth, 0.0, boxWidth, _cornerRadius);
//	CGPathAddLineToPoint(overlayRectPath, NULL, boxWidth, boxHeight / 4.0);
//	CGPathAddCurveToPoint(overlayRectPath, NULL, boxWidth / 4 * 3, boxHeight / 5, boxWidth / 4 * 3, boxHeight / 5, boxWidth / 2.0, boxHeight / 5);
//	CGPathAddCurveToPoint(overlayRectPath, NULL, boxWidth / 4, boxHeight / 5, boxWidth / 4, boxHeight / 5, 0.0, boxHeight / 4);
//	CGPathAddLineToPoint(overlayRectPath, NULL, 0.0, _cornerRadius);
//	CGPathAddQuadCurveToPoint(overlayRectPath, NULL, 0.0, 0.0, _cornerRadius, 0.0);
//	CGPathCloseSubpath(overlayRectPath);
//	
//	//clip
//	CGContextSaveGState(context);
//	CGContextAddPath(context, overlayRectPath);
//	CGContextClip(context);
//    
//	//overlay gradient
//	CGFloat overlayLocations[2] = { 0.0, 1.0 };
//	const CGFloat *firstOverlayComponents	= CGColorGetComponents([[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4] CGColor]); 
//	const CGFloat *secondOverlayComponents	= CGColorGetComponents([[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2] CGColor]); 
//	
//	CGFloat overlayComponents[8] = {firstOverlayComponents[0], firstOverlayComponents[1], firstOverlayComponents[2], firstOverlayComponents[3], secondOverlayComponents[0], secondOverlayComponents[1], secondOverlayComponents[2], secondOverlayComponents[3]}; 	
//	
//	CGGradientRef	overlayGradient = CGGradientCreateWithColorComponents(rgbColorspace, overlayComponents, overlayLocations, num_locations);
//	
//	
//	CGContextDrawLinearGradient (context, overlayGradient, topCenter, midCenter, 0);
//	
//	CGContextRestoreGState(context);
//	
//	//clip
//	CGContextAddPath(context, rectPath);
//	CGContextClip(context);
//	
//	//shadow
//	
//	CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 1.0, [[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8] CGColor]);
//	
//	//stroke
//	CGContextAddPath(context, rectPath);
//	[[UIColor colorWithRed:170.0/255.0 green:169.0/255.0 blue:171.0/255.0 alpha:1.0] set];
//	CGContextSetLineWidth(context, 2.0);
//	CGContextStrokePath(context);
//	
//	
//	CGGradientRelease(overlayGradient);
//	CGColorSpaceRelease(rgbColorspace);
//	
//	CGPathRelease(rectPath);
//	CGPathRelease(overlayRectPath);
}
 

- (void)dealloc
{
    [super dealloc];
}


@end
