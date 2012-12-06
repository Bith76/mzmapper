//
//  MZOpenStreetBug.h
//  MZMapper
//
//  Created by Zalan Mergl on 10/22/12.
//
//


@interface MZOpenStreetBug : NSObject
{
    
}

@property (nonatomic, retain) NSString*     bugID;
@property (nonatomic, assign) CGFloat       longitude;
@property (nonatomic, assign) CGFloat       latitude;
@property (nonatomic, retain) NSString*     description;
@property (nonatomic, assign) BOOL          status;
@property (nonatomic, retain) NSArray*      comments;

@end