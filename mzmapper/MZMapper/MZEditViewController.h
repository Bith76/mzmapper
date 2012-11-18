//
//  MZEditViewController.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//


@class MZMapperViewController;
@class MZCategoryViewController;

@interface MZEditViewController : UIViewController
{
    MZMapperViewController* _controller;
    
    IBOutlet UIScrollView* _mainScrollView;
}

@property (nonatomic, assign) MZMapperViewController*   controller;

- (void)categoryVC:(MZCategoryViewController*)categoryVC changedHeightWith:(CGFloat)aValue;
- (void)categoryVC:(MZCategoryViewController*)categoryVC addedItemWithType:(NSUInteger)aType toPoint:(CGPoint)aPoint;

@end
