//
//  MZDraggedCategoryItemView.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/2/12.
//
//


@interface MZDraggedCategoryItemView : UIView
{
    UIImage*    _image;
    CGSize      _originalSize;
    CGFloat     _arrowHeight;
    BOOL        _arrowIsVisible;
}

@property (nonatomic, assign) BOOL      arrowIsVisible;
@property (nonatomic, readonly) CGFloat arrowHeight;

//designated initializer
- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)anImage;

@end
