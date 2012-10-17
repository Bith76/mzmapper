//
//  MZEditViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/10/12.
//
//

#import "MZEditViewController.h"
#import "MZMapperViewController.h"
#import "MZCategoryViewController.h"

@interface MZEditViewController ()
{
    NSMutableArray* _categoryViewControllers;
}
@end

@implementation MZEditViewController

@synthesize controller = _controller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _categoryViewControllers = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = MZMapperPointCategoryNone + 1; i < MZMapperPointCategoryCountOfCategories; i++)
        {
            MZCategoryViewController* categoryVC = [[MZCategoryViewController alloc] initWithCategoryType:i];
            
            [categoryVC.view setFrame:CGRectMake(0.0, (i-1) * 200.0, self.view.bounds.size.width, 200.0)];
            
            [categoryVC.view setTag:i];
            
            [categoryVC setEditViewController:self];
            
            [_mainScrollView addSubview:categoryVC.view];
            
            [_categoryViewControllers addObject:categoryVC];
            
            [categoryVC release];
        }
        
        [_mainScrollView setContentSize:CGSizeMake(self.view.bounds.size.width, (MZMapperPointCategoryCountOfCategories - 1) * 200.0)];
    }
    return self;
}

- (void)categoryVC:(MZCategoryViewController*)categoryVC changedHeightWith:(CGFloat)aValue
{
    for (NSUInteger i = categoryVC.view.tag - 1; i < [_categoryViewControllers count]; i++)
    {
        MZCategoryViewController* categoryViewController = [_categoryViewControllers objectAtIndex:i];
        
        CGRect newFrame = categoryViewController.view.frame;
        
        if (categoryViewController.view.tag == categoryVC.view.tag)
        {
            newFrame.size.height += aValue;
        }
        else
        {
            newFrame.origin.y += aValue;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [categoryViewController.view setFrame:newFrame];
        }];
    }
    
    //adjust contentSize of the scrollView to the new height
    [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.contentSize.width, _mainScrollView.contentSize.height + aValue)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_categoryViewControllers release];
    
    [super dealloc];
}

@end
