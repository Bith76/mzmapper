//
//  MZLoupeView.h
//  MZImageLoupe
//
//  Created by Zalan Mergl on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface MZLoupeView : UIView

//@property(nonatomic, retain) UIImage *zoomImage;
@property (nonatomic, retain)   UIView* viewToMagnify;
@property (nonatomic, assign)   CGPoint touchPointInViewToMagnify;

@end