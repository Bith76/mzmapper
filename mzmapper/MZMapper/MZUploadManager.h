//
//  MZUploadManager.h
//  MZMapper
//
//  Created by Zalan Mergl on 11/27/12.
//
//

@protocol MZUploadManagerDelegate;

@interface MZUploadManager : NSObject
{
    id          _delegate;
    NSString*   _changesetId;
}

@property (nonatomic, assign)   id<MZUploadManagerDelegate> delegate;

- (void)uploadChangesToOSMWithComment:(NSString*)aComment;

@end


@protocol MZUploadManagerDelegate <NSObject>

@optional

- (void)uploadManagerDidFinishWithUploading:(MZUploadManager*)uploadManager;

@end