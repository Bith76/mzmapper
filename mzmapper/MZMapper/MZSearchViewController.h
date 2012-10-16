//
//  MZSearchViewController.h
//  MZMapper
//
//  Created by Zalán Mergl on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@class MZPlace;
@class MZMapperViewController;

@interface MZSearchViewController : UIViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    MZMapperViewController* _controller;
    IBOutlet UITableView*   _tableView;
    
    NSXMLParser*            _parser;
    NSMutableArray*         _searchResults;
    MZPlace*                _currentPlace;
}

@property (nonatomic, assign) MZMapperViewController*   controller;

- (void)searchForString:(NSString*)searchString;

@end
