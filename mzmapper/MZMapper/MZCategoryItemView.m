//
//  MZCategoryItemView.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "MZCategoryItemView.h"
#import "MZDraggedCategoryItemView.h"

@interface MZCategoryItemView ()
{
    UILongPressGestureRecognizer* _longPressGesture;
    UIPanGestureRecognizer* _panGesture;
    CGPoint _delta;
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
    }
    return self;
}

- (void)didMoveToSuperview
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 10.0, self.bounds.size.width - 60.0, 30.0)];
    //[titleLabel setBackgroundColor:[UIColor purpleColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [titleLabel setText:self.itemName];
    
    [self addSubview:titleLabel];
}

- (void)enableMove:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    CGPoint recognizedAtPoint = [gestureRecognizer locationInView:self.window.rootViewController.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        _draggedView = [[MZDraggedCategoryItemView alloc] initWithFrame:CGRectMake(9.0, 9.0, 32.0, 32.0) withImage:self.itemImage];
        [_draggedView setAlpha:0.7];
        
        CGPoint convertedCenterPoint = [self convertPoint:_draggedView.center toView:self.window.rootViewController.view];
        [_draggedView setCenter:convertedCenterPoint];
        [self.window.rootViewController.view addSubview:_draggedView];
        
        _delta = CGPointMake(recognizedAtPoint.x - _draggedView.center.x, recognizedAtPoint.y - _draggedView.center.y);
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        [_draggedView setCenter:CGPointMake(recognizedAtPoint.x - _delta.x, recognizedAtPoint.y - _delta.y)];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [_draggedView setAlpha:1.0];
        [_draggedView release], _draggedView = nil;
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

    //maybe unneeded
    //draw item name
//    CGSize constraint = CGSizeMake(20000.0f, 20000.0f);
//    
//    CGSize size = [self.itemName sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:constraint lineBreakMode:OS_IS_LOWER_THAN_6_0 ? UILineBreakModeWordWrap : NSLineBreakByWordWrapping];
//    CGRect itemNameRect = CGRectMake(53.0, (self.frame.size.height - size.height) / 2.0, self.frame.size.width - 56.0, size.height);
//    
//    [self.itemName drawInRect:itemNameRect withFont:[UIFont systemFontOfSize:17.0]];
}

- (void)dealloc
{
    [_longPressGesture release];
    [_panGesture release];
    
    [super dealloc];
}

@end