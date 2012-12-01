//
//  MZLoginViewController.m
//  MZMapper
//
//  Created by Zalán Mergl on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZLoginViewController.h"
#import "MZRESTRequestManager.h"

@interface MZLoginViewController ()

@end

@implementation MZLoginViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _downloader = [[MZRESTRequestManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    UITableViewCell* userNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField* userNameTextField = (UITextField*)[userNameCell viewWithTag:1];
    
    [userNameTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark Button touched methods

- (IBAction)cancelButtonTouched:(id)sender
{
    [_downloader cancel];
    
    if (_delegate && [_delegate respondsToSelector:@selector(loginViewControllerWillDismiss:)]) 
    {
        [_delegate loginViewControllerWillDismiss:self];
    }
}


#pragma mark -
#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString* cellIdentifier = nil;
    
    switch (indexPath.section) 
    {
        case 0:
        case 1:
            cellIdentifier = @"LoginTextFieldCell";
            break;
        case 2:
        case 3:
        case 4:
            cellIdentifier = @"LoginButtonCell";
            break;
        default:
            break;
    }
        
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
        switch (indexPath.section) 
        {
            case 0:
            case 1:
            {
                UITextField* aTextField = [[UITextField alloc] initWithFrame:cell.contentView.bounds];
                [aTextField setBackgroundColor:[UIColor clearColor]];
                [aTextField setTextAlignment:NSTextAlignmentCenter];
                [aTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [aTextField setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
                [aTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
                [aTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
                [aTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
                [aTextField setFont:[UIFont systemFontOfSize:12.0]];
                [aTextField setDelegate:self];
                [aTextField setTag:1];
                
                [[cell contentView] addSubview:aTextField];
                [aTextField release];
            }
                break;
            case 2:
            case 3:
            case 4:
            {
                UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [aButton setFrame:[[cell contentView] bounds]];
                [aButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
                [aButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
                [aButton setTitleColor:[UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                [aButton setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
                [aButton setTag:1];
                
                [[cell contentView] addSubview:aButton];
            }
                break;
            default:
                break;
        }
    }
    
    switch (indexPath.section) 
    {
        case 0:
        {
            UITextField* userNameTextField = (UITextField*)[cell viewWithTag:1];
            [userNameTextField setSecureTextEntry:NO];
            [userNameTextField setReturnKeyType:UIReturnKeyNext];
            [userNameTextField setPlaceholder:@"Felhasználónév"];
        }
            break;
        case 1:
        {
            UITextField* passwordTextField = (UITextField*)[cell viewWithTag:1];
            [passwordTextField setSecureTextEntry:YES];
            [passwordTextField setReturnKeyType:UIReturnKeyGo];
            [passwordTextField setPlaceholder:@"Jelszó"];
        }
            break;
        case 2:
        {
            UIButton* loginButton = (UIButton*)[cell viewWithTag:1];
            [loginButton addTarget:self action:@selector(tryLogin) forControlEvents:UIControlEventTouchUpInside];
            [loginButton setTitle:@"Rendben" forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            UIButton* registrationButton = (UIButton*)[cell viewWithTag:1];
            [registrationButton addTarget:self action:@selector(goToRegistration) forControlEvents:UIControlEventTouchUpInside];
            [registrationButton setTitle:@"Regisztráció" forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            UIButton* lostPasswordButton = (UIButton*)[cell viewWithTag:1];
            [lostPasswordButton addTarget:self action:@selector(goToLostPasswordHelp) forControlEvents:UIControlEventTouchUpInside];
            [lostPasswordButton setTitle:@"Elfelejtett jelszó" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableView delegate methods

#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField* userNameTextField = (UITextField*)[[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] viewWithTag:1];
    UITextField* passwordTextField = (UITextField*)[[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] viewWithTag:1];
    
    if ([textField isEqual:userNameTextField]) 
    {
        [passwordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:passwordTextField]) 
    {
        [self tryLogin];
    }
    
    return YES;
}

#pragma mark -
#pragma mark Helper methods

- (void)tryLogin
{
    [_loadingBackgroundView setHidden:NO];
    
    UITextField* userNameTextField = (UITextField*)[[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] viewWithTag:1];
    UITextField* passwordTextField = (UITextField*)[[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] viewWithTag:1];
    
    [MZMapperContentManager sharedContentManager].userName = userNameTextField.text;
    [MZMapperContentManager sharedContentManager].password = passwordTextField.text;
    
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/user/details", [NSString loginPath]]];
        
    
    
    [_downloader downloadRequestFromURL:url
                       progressHandler:nil
                     completionHandler:^(NSString* resultString){
                         
                         if (![resultString isEqualToString:HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED] && ![resultString isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
                         {
                             NSLog(@"result: %@",resultString);
                             
                             [MZMapperContentManager sharedContentManager].loggedIn = YES;
                             
                             if (_delegate && [_delegate respondsToSelector:@selector(loginViewControllerWillDismiss:)])
                             {
                                 [_delegate loginViewControllerWillDismiss:self];
                             }
                         }
                         else
                         {
                             [_loadingBackgroundView setHidden:YES];
                         }
                     }];
    
    [url release];
}

- (void)goToRegistration
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.openstreetmap.org/user/new"]];
}

- (void)goToLostPasswordHelp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.openstreetmap.org/user/forgot-password"]];
}

/*
 iPad keyboard will not dismiss if modal view controller presentation style is UIModalPresentationFormSheet

 here is the response of an Apple engineer on the developer forums:

 Was your view by any chance presented with the UIModalPresentationFormSheet style? To avoid frequent in-and-out animations, the keyboard will sometimes remain on-screen even when there is no first responder. This is not a bug.
*/
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)dealloc
{
    [_downloader cancel];
    [_downloader release];
    
    [super dealloc];
}

@end
