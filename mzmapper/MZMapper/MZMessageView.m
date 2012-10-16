//
//  MZMessageView.m
//  MZMapper
//
//  Created by Zalán Mergl on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZMessageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MZMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setBackgroundColor:[UIColor blackColor]];
        self.layer.cornerRadius = 6.0f;
        [self setAlpha:0.0f];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, self.bounds.size.width - 10.0, self.bounds.size.height - 10.0)];
        [_messageLabel setBackgroundColor:[UIColor clearColor]];
        [_messageLabel setFont:[UIFont systemFontOfSize:17.0]];
        [_messageLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_messageLabel];
    }
    
    return  self;
}

- (void)showMessage:(NSString*)message
{
    [_messageLabel setText:message];
    
    [UIView animateWithDuration:0.1 
                     animations:^{
                         [self setAlpha:0.8f];
                     }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self setAlpha:0.0f];
                     }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    [_messageLabel release];
    
    [super dealloc];
}

@end
