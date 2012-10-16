//
//  MZCategoryItemView.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//


@interface MZCategoryItemView : UIView
{
    UIImageView* _movedImageView;
}

@property (nonatomic, retain)   UIImage*    itemImage;
@property (nonatomic, retain)   NSString*   itemName;

@end
