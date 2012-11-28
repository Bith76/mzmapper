//
//  MZRESTRequestManager.h
//  MZMapper
//
//  Created by Benjamin Salanki on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED @"401"
#define HTTP_STATUS_CODE_CONNECTION_FAILED @"911"

@interface MZRESTRequestManager : NSObject <NSURLConnectionDelegate>
{
    NSMutableData*	_downloadData;
    
    id				_completionHandler;
	id				_progressHandler;
    long long		_bytesDownloaded;
	long long		_totalBytes;
    BOOL            _shouldCancel;
}

- (void)downloadRequestFromURL:(NSURL*)requestURL 
               progressHandler:(void(^)(long long totalBytes, long long currentBytes))progressHandler 
             completionHandler:(void(^)(NSString* resultString))completionHandler;

- (void)putRequestToURL:(NSURL*)requestURL body:(NSData*)UTF8EncodedBody completionHandler:(void (^)(id resultObject))completionHandler;
- (void)deleteRequestToURL:(NSURL*)requestURL body:(NSData*)UTF8EncodedBody completionHandler:(void (^)(id resultObject))completionHandler;

- (void)processPutRequestsForURLs:(NSMutableArray*)urls andBodies:(NSMutableArray*)bodies competionHandler:(void (^)(id resultObject))completionHandler;
- (void)processDeleteRequestsForURLs:(NSMutableArray*)urls andBodies:(NSMutableArray*)bodies competionHandler:(void (^)(id resultObject))completionHandler;

- (void)cancel;

@end
