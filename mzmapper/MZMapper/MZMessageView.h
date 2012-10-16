//
//  MZMessageView.h
//  MZMapper
//
//  Created by Zalán Mergl on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface MZMessageView : UIView
{
    @private
    UILabel*    _messageLabel;
}

- (void)showMessage:(NSString*)message;
- (void)hide;

@end
