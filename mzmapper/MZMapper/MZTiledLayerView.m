//
//  MZTiledLayerView.m
//  MZMapper
//
//  Created by Zalan Mergl on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MZTiledLayerView.h"
#import "MZMapView.h"

@implementation MZTiledLayerView

@synthesize scale = _scale;
@synthesize sourceView = _sourceView;

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        
        self.backgroundColor = [UIColor redColor];
        
        CATiledLayer *tiledLayer = (CATiledLayer*)[self layer];
        // levelsOfDetail and levelsOfDetailBias determine how
		// the layer is rendered at different zoom levels.  This
		// only matters while the view is zooming, since once the 
		// the view is done zooming a new TiledPDFView is created
		// at the correct size and scale.
        tiledLayer.levelsOfDetail = 1;
		tiledLayer.levelsOfDetailBias = 0;
		tiledLayer.tileSize = CGSizeMake(256.0, 256.0);

        _scale = 1.0;
    }
    
    return self;
}

+ (Class)layerClass
{
    return [CATiledLayer class];
}

-(void)drawRect:(CGRect)rect
{
    // UIView uses the existence of -drawRect: to determine if it should allow its CALayer
    // to be invalidated, which would then lead to the layer creating a backing store and
    // -drawLayer:inContext: being called.
    // By implementing an empty -drawRect: method, we allow UIKit to continue to implement
    // this logic, while doing our real drawing work inside of -drawLayer:inContext:
}

/*- (NSString *)applicationDocumentsDirectory 
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}*/

// Do all your drawing here. Do not use UIGraphics to do any drawing, use Core Graphics instead.
// Draw the CGPDFPageRef into the layer at the correct scale.
-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
	if (context)
	{
		CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
		CGContextFillRect(context,self.bounds);
        
		CGRect boundingRect = CGContextGetClipBoundingBox(context);
        
		CGContextSaveGState(context);
        
		[_sourceView.layer setNeedsDisplayInRect:boundingRect];
		
		[_sourceView.layer renderInContext:context];
		
		CGContextRestoreGState(context);
	}		
}

@end
