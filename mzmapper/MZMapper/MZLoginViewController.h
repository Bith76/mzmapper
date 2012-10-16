//
//  MZLoginViewController.h
//  MZMapper
//
//  Created by Zalán Mergl on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@protocol MZLoginViewControllerDelegate;
@class MZDownloader;

@interface MZLoginViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITableView*   _tableView;
    IBOutlet UIView*        _loadingBackgroundView;
    
    MZDownloader*           _downloader;
}

@property (nonatomic, assign) id <MZLoginViewControllerDelegate> delegate;

- (IBAction)cancelButtonTouched:(id)sender;

@end


@protocol MZLoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewControllerWillDismiss:(MZLoginViewController*)loginViewController;

@end