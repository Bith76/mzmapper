//
//  MZCategoryViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//

#import "MZCategoryViewController.h"
#import "MZCategoryItemView.h"
#import "MZEditViewController.h"

@interface MZCategoryViewController ()
{
    NSMutableArray* _categoryItemViews;
    BOOL            _isOpen;
}
@end


@implementation MZCategoryViewController

#pragma mark - View lifecycle

// designated initializer
- (id)initWithCategoryType:(MZMapperPointCategory)type
{
    self = [super initWithNibName:@"MZCategoryViewController" bundle:nil];
    
    if (self)
    {
        _categoryType = type;
        _categoryItemViews = [[NSMutableArray alloc] init];
        _isOpen = NO;
    }
    
    return self;
}

- (id)init
{
    return [self initWithCategoryType:MZMapperPointCategoryNone];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithCategoryType:MZMapperPointCategoryNone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupForType:_categoryType];
}

#pragma mark - Private methods

- (void)setupForType:(MZMapperPointCategory)type
{
    switch (type)
    {
        case MZMapperPointCategoryAccomodation:
        {
            MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height, self.view.bounds.size.width, 50.0)];
            [itemView setItemName:@"itemName"];
            [itemView setItemImage:[UIImage imageNamed:@"icon_bookshop.jpeg"]];
            [self.view addSubview:itemView];
            [_categoryItemViews addObject:itemView];
            [itemView release];
        }
            break;
        case MZMapperPointCategoryAmenity:
        {
            
        }
            break;
        case MZMapperPointCategoryBarrier:
        {
            
        }
            break;
            //to-do continue----------------
        
        case MZMapperPointCategoryShopping:
        {
            for (NSUInteger i = 0; i < MZMapperPointCategoryShoppingElementCountOfElements; i++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (i * 50.0), self.view.bounds.size.width, 50.0)];
                [itemView setItemName:@"itemName"];
                [itemView setItemImage:[UIImage imageNamed:@"icon_bookshop.jpeg"]];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        default:
            break;
    }
}

- (IBAction)showMoreButtonTouched:(id)sender
{
    NSLog(@"sender.frame: %@",NSStringFromCGRect(((UIButton*)sender).frame));
    CGFloat growingValue = 0.0;
    
    if (_isOpen)
    {
        CGFloat actFrameHeight = self.view.frame.size.height;
        CGFloat newFrameHeight = 200.0;
        
        growingValue = newFrameHeight - actFrameHeight;
    }
    else
    {
        if ([_categoryItemViews count] > 3)
        {
            CGFloat actFrameHeight = self.view.frame.size.height;
            CGFloat newFrameHeight = _titleLabel.frame.size.height + ([_categoryItemViews count] * 50.0);
            
            growingValue = newFrameHeight - actFrameHeight;
        }
    }
    
    [self.editViewController categoryVC:self changedHeightWith:growingValue];
    NSLog(@"sender.frame2: %@",NSStringFromCGRect(((UIButton*)sender).frame));
    _isOpen = !_isOpen;
}
#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_categoryItemViews release];
    
    [super dealloc];
}

@end
