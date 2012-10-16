//
//  MZPlace.h
//  MZMapper
//
//  Created by Zalán Mergl on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Used by searching results


@interface MZPlace : NSObject

@property (nonatomic, retain) NSString*     placeId;
@property (nonatomic, assign) CGFloat       latitude;
@property (nonatomic, assign) CGFloat       longitude;
@property (nonatomic, retain) NSString*     displayName;
@property (nonatomic, retain) NSString*     iconURL;

@end
