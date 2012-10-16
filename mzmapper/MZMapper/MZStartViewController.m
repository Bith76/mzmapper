//
//  MZStartViewController.m
//  MZMapper
//
//  Created by Zalan Mergl on 10/8/12.
//
//

#import "MZStartViewController.h"


@implementation MZStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


- (void)hide
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [self.view removeFromSuperview];
                         }
                     }];
    
}

@end
