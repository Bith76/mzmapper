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
    BOOL			_shown;
    CGFloat			_startingYCoord;
}

@property (nonatomic, retain) UIViewController* contentViewController;

- (void)show;
- (void)hide;

@end
