//
//  MZPullView.h
//  MZPullViewSample
//
//  Created by Zalán Mergl on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface MZPullView : UIView
{
    UILabel*        _titleLabel;
    CGFloat			_startingYCoord;
}

@property (nonatomic, retain) UIViewController* contentViewController;
@property (nonatomic, assign) BOOL shown;

- (void)show;
- (void)hide;

@end
