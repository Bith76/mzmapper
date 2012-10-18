//
//  MZCategoryItemView.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "MZCategoryItemView.h"

@interface MZCategoryItemView ()
{
    UILongPressGestureRecognizer* _longPressGesture;
    UIPanGestureRecognizer* _panGesture;
    CGFloat _firstX;
    CGFloat _firstY;
}
@end

@implementation MZCategoryItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(enableMove:)];
        [self addGestureRecognizer:_longPressGesture];
        
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
        [_panGesture setEnabled:NO];
        [self addGestureRecognizer:_panGesture];
    }
    return self;
}

- (void)enableMove:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"began");
        UIView *view = [gestureRecognizer view];
        
        for (UIGestureRecognizer *gr in view.gestureRecognizers)
        {
            if ([gr isKindOfClass:[UIPanGestureRecognizer class]])
            {
                [gr setEnabled:YES];
            }
        }
        
        _movedImageView = [[UIImageView alloc] initWithImage:self.itemImage];
        [_movedImageView setFrame:CGRectMake(3.0, 3.0, 44.0, 44.0)];
        [_movedImageView setAlpha:0.7];
        
        CGPoint convertedCenterPoint = [self convertPoint:_movedImageView.center toView:self.window.rootViewController.view];
        [_movedImageView setCenter:convertedCenterPoint];
        [self.window.rootViewController.view addSubview:_movedImageView];
        NSLog(@"type: %@",[self.window.rootViewController class]);
    }
}

// shift the piece's center by the pan amount
// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position
- (void)moveImage:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    CGPoint translatedPoint = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        _firstX = _movedImageView.center.x;
        _firstY = _movedImageView.center.y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    
    [_movedImageView setCenter:translatedPoint];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [_movedImageView setAlpha:1.0];
        [_movedImageView release], _movedImageView = nil;
        
        [_panGesture setEnabled:NO];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    
    //draw item image
    //[self.itemImage drawInRect:CGRectMake(3.0, 3.0, 44.0, 44.0)];
    [self.itemImage drawInRect:CGRectMake(17.0, 17.0, 16.0, 16.0)];
    
    //draw item name
    CGSize constraint = CGSizeMake(20000.0f, 20000.0f);
    
    CGSize size = [self.itemName sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:constraint lineBreakMode:OS_IS_LOWER_THAN_6_0 ? UILineBreakModeWordWrap : NSLineBreakByWordWrapping];
    CGRect itemNameRect = CGRectMake(53.0, (self.frame.size.height - size.height) / 2.0, self.frame.size.width - 56.0, size.height);
    
    [self.itemName drawInRect:itemNameRect withFont:[UIFont systemFontOfSize:17.0]];
}

- (void)dealloc
{
    [_longPressGesture release];
    [_panGesture release];
    
    [super dealloc];
}

@end
