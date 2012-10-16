//
//  MZDownloader.m
//  MZMapper
//
//  Created by Benjamin Salanki on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZDownloader.h"

@implementation MZDownloader

- (void)downloadRequestFromURL:(NSURL*)requestURL 
               progressHandler:(void(^)(long long totalBytes, long long currentBytes))progressHandler 
             completionHandler:(void(^)(NSString* resultString))completionHandler
{
    ShowNetworkActivityIndicator();
    
    if (completionHandler) 
	{
		_completionHandler = [completionHandler copy];
	}
	
	if (progressHandler) 
	{
		_progressHandler = [progressHandler copy];
	}
    
    _bytesDownloaded = 0;
    
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection start];
    
    [request release];
    [connection release];
}

- (void)cancel
{
	_shouldCancel = YES;
}

#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _totalBytes = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (_shouldCancel)
	{
		//cancel the download
		[connection cancel];
        
        HideNetworkActivityIndicator();
		
		[_downloadData release], _downloadData = nil;
        [_completionHandler release], _completionHandler = nil;
        [_progressHandler release], _progressHandler = nil;
	}
    else
    {
        _bytesDownloaded += (long long)[data length];
        
        if (!_downloadData)
        {
            _downloadData = [[NSMutableData alloc] init];
        }
        
        [_downloadData appendData:data];
        
        //if we have a progress handler, send out the updated progress to the block handler
        if (_progressHandler)
        {
            //NSLog(@"progressing...");
            ((void (^)(long long totalBytes, long long currentBytes))_progressHandler)(_totalBytes, _bytesDownloaded);
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    HideNetworkActivityIndicator();
    
    if (!_shouldCancel)
    {
        NSString* downloadResult = [[NSString alloc] initWithData:_downloadData encoding:NSUTF8StringEncoding];
        
        ((void (^)(NSString* resultString))_completionHandler)(downloadResult);
        
        [downloadResult release];
    }
    
    [_downloadData release], _downloadData = nil;
	[_completionHandler release], _completionHandler = nil;
	[_progressHandler release], _progressHandler = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    HideNetworkActivityIndicator();
    
    if (!_shouldCancel)
    {
        ((void (^)(NSString* resultString))_completionHandler)(HTTP_STATUS_CODE_CONNECTION_FAILED);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CommunicationErrorTitleKey", @"Title of connection problem alert view.")
                                                        message:NSLocalizedString(@"CommunicationErrorMessageKey", @"Message of connection problem alert view.")
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }
    
    [_downloadData release], _downloadData = nil;
	[_completionHandler release], _completionHandler = nil;
	[_progressHandler release], _progressHandler = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    // Access has failed two times...
    if ([challenge previousFailureCount] > 1)
    {
        HideNetworkActivityIndicator();
        
        if (!_shouldCancel)
        {
            ((void (^)(NSString* resultString))_completionHandler)(HTTP_STATUS_CODE_AUTHORIZATION_REQUIRED);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"LoginErrorTitleKey", @"Title of login error alert view.")
                                                            message:NSLocalizedString(@"LoginErrorMessageKey", @"Title of login error alert view.")
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        
        [_downloadData release], _downloadData = nil;
        [_completionHandler release], _completionHandler = nil;
        [_progressHandler release], _progressHandler = nil;
    }
    else 
    {
        // Answer the challenge
        NSString* userName = [MZMapperContentManager sharedContentManager].userName;
        NSString* password = [MZMapperContentManager sharedContentManager].password;
        
        NSURLCredential *cred = [[[NSURLCredential alloc] initWithUser:userName password:password
                                                           persistence:NSURLCredentialPersistenceForSession] autorelease];
        [[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
    }
}

- (void)dealloc
{
	[_downloadData release], _downloadData = nil;
	[_completionHandler release], _completionHandler = nil;
	[_progressHandler release], _progressHandler = nil;
    
	[super dealloc];
}

@end
