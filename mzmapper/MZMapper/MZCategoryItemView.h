//
//  MZCategoryItemView.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//


@class MZDraggedCategoryItemView;

@interface MZCategoryItemView : UIView
{
    MZDraggedCategoryItemView* _draggedView;
}

@property (nonatomic, retain)   UIImage*    itemImage;
@property (nonatomic, retain)   NSString*   itemName;

@end
