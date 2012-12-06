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

#define ITEM_HEIGHT 40.0

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
    [_titleLabel setText:[NSString nameOfPointCategory:type]];
    
    switch (type)
    {
        case MZMapperPointCategoryAccomodation:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryAccomodationElementUnknown + 1; i < MZMapperPointCategoryAccomodationElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryAmenity:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryAmenityElementUnknown + 1; i < MZMapperPointCategoryAmenityElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryBarrier:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryBarrierElementUnknown + 1; i < MZMapperPointCategoryBarrierElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryEducation:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryEducationElementUnknown + 1; i < MZMapperPointCategoryEducationElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryEntertainmentArtsCulture:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryEntertainmentArtsCultureElementUnknown + 1; i < MZMapperPointCategoryEntertainmentArtsCultureElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryFoodAndDrink:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryFoodAndDrinkElementUnknown + 1; i < MZMapperPointCategoryFoodAndDrinkElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryHealthCare:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryHealthcareElementUnknown + 1; i < MZMapperPointCategoryHealthcareElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryLanduse:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryLanduseElementUnknown + 1; i < MZMapperPointCategoryLanduseElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryPlaces:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryPlacesElementUnknown + 1; i < MZMapperPointCategoryPlacesElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryPower:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryPowerElementUnknown + 1; i < MZMapperPointCategoryPowerElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryShopping:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryShoppingElementUnknown + 1; i < MZMapperPointCategoryShoppingElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategorySportAndLeisure:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategorySportAndLeisureElementUnknown + 1; i < MZMapperPointCategorySportAndLeisureElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryTourism:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryTourismElementUnknown + 1; i < MZMapperPointCategoryTourismElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        case MZMapperPointCategoryTransport:
        {
            NSUInteger j = 0;
            for (NSUInteger i = MZMapperPointCategoryTransportElementUnknown + 1; i < MZMapperPointCategoryTransportElementCountOfElements; i++, j++)
            {
                MZCategoryItemView* itemView = [[MZCategoryItemView alloc] initWithFrame:CGRectMake(0.0, _titleLabel.frame.size.height + (j * ITEM_HEIGHT), self.view.bounds.size.width, ITEM_HEIGHT)];
                [itemView setCategoryViewController:self];
                [itemView setItemType:i];
                [self.view addSubview:itemView];
                [_categoryItemViews addObject:itemView];
                [itemView release];
            }
        }
            break;
        default:
            break;
    }
    
    if ([_categoryItemViews count] > 4)
    {
        [_showMoreButton setHidden:NO];
    }
    else
    {
        [_showMoreButton setHidden:YES];
    }
}

- (IBAction)showMoreButtonTouched:(id)sender
{
    CGFloat growingValue = 0.0;
    
    if (_isOpen)
    {
        CGFloat actFrameHeight = self.view.frame.size.height;
        CGFloat newFrameHeight = 200.0;
        
        growingValue = newFrameHeight - actFrameHeight;
        
        [(UIButton*)sender setTransform:CGAffineTransformIdentity];
    }
    else
    {
        if ([_categoryItemViews count] > 3)
        {
            CGFloat actFrameHeight = self.view.frame.size.height;
            CGFloat newFrameHeight = _titleLabel.frame.size.height + ([_categoryItemViews count] * ITEM_HEIGHT);
            
            growingValue = newFrameHeight - actFrameHeight;
            
            [(UIButton*)sender setTransform:CGAffineTransformMakeRotation(degreesToRadians(180.0))];
        }
    }
    
    [self.editViewController categoryVC:self changedHeightWith:growingValue];
    
    _isOpen = !_isOpen;
}

#pragma mark -
#pragma mark helper methods

- (void)addCategoryItemType:(NSUInteger)type toPoint:(CGPoint)toPoint
{
    [self.editViewController categoryVC:self addedItemWithType:type toPoint:toPoint];
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
    
    _titleLabel     = nil;
    _showMoreButton = nil;
    
    [super dealloc];
}

@end
