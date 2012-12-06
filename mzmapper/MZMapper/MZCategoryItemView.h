//
//  MZCategoryItemView.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//


@class MZDraggedCategoryItemView;
@class MZCategoryViewController;

@interface MZCategoryItemView : UIView
{
    MZDraggedCategoryItemView* _draggedView;
}

@property (nonatomic, assign)   MZCategoryViewController* categoryViewController;
@property (nonatomic, assign)   NSUInteger itemType;

@end
