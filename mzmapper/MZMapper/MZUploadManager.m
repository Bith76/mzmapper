//
//  MZUploadManager.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/27/12.
//
//

#import "MZUploadManager.h"
#import "MZRESTRequestManager.h"
#import "XMLWriter.h"
#import "MZNode.h"

@implementation MZUploadManager

@synthesize delegate = _delegate;

- (void)uploadChangesToOSMWithComment:(NSString*)aComment
{
    MZMapperContentManager* cm = [MZMapperContentManager sharedContentManager];
    
    NSLog(@"törlendő node-ok: %@",cm.deletedPointObjects);
    NSLog(@"módosított node-ok: %@",cm.updatedPointObjects);
    NSLog(@"feltöltendő node-ok: %@",cm.addedPointObjects);
    
    [MZMapperContentManager sharedContentManager].userName = @"mergl.zalan@stud.u-szeged.hu";
    [MZMapperContentManager sharedContentManager].password = @"jelszavak";
    
    
    
    
    NSString* createChangesetXML = [self generateChangesetCreationXMLWithComment:aComment];
    
    MZRESTRequestManager* requestManager = [[MZRESTRequestManager alloc] init];
    
    [requestManager putRequestToURL:[NSURL urlForChangesetCreation] body:[createChangesetXML dataUsingEncoding:NSUTF8StringEncoding] completionHandler:^(id resultObject) {
        if (![resultObject isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
        {
            NSLog(@"changeset created: %@",resultObject);
            
            _changesetId = [resultObject retain];
            
            [self startDeleteRequests];
        }
    }];
    
    [requestManager release];
}

- (void)startDeleteRequests
{
    if ([[MZMapperContentManager sharedContentManager].deletedPointObjects count])
    {
        NSMutableArray* urls = [NSMutableArray array];
        NSMutableArray* bodies = [NSMutableArray array];
        
        for (MZNode* node in [MZMapperContentManager sharedContentManager].deletedPointObjects)
        {
            NSURL* deleteURL = [NSURL urlForDeleteNodeForNodeID:node.nodeid];
            NSData* deleteBody = [[self generateDeletionXMLForNode:node] dataUsingEncoding:NSUTF8StringEncoding];
            
            [urls addObject:deleteURL];
            [bodies addObject:deleteBody];
            
            NSLog(@"törlés: %@",[self generateDeletionXMLForNode:node]);
        }
        
        MZRESTRequestManager* requestManager = [[MZRESTRequestManager alloc] init];
        
        [requestManager processDeleteRequestsForURLs:urls andBodies:bodies competionHandler:^(id resultObject) {
            [self startAddRequests];
        }];
        
        [requestManager release];
    }
    else
    {
        [self startAddRequests];
    }
}

- (void)startAddRequests
{
    
    
    
    
    if ([[MZMapperContentManager sharedContentManager].addedPointObjects count])
    {
        NSMutableArray* urls = [NSMutableArray array];
        NSMutableArray* bodies = [NSMutableArray array];
        
        for (MZNode* node in [MZMapperContentManager sharedContentManager].addedPointObjects)
        {
            NSURL* createURL = [NSURL urlForCreateNode];
            NSData* createBody = [[self generateNodeCreationXMLWithNode:node] dataUsingEncoding:NSUTF8StringEncoding];
            
            [urls addObject:createURL];
            [bodies addObject:createBody];
            
            NSLog(@"hozzáadás: %@",[self generateNodeCreationXMLWithNode:node]);
        }
        
        
        
        //to-do tesztelni---------------------------------
        
        MZRESTRequestManager* requestManager = [[MZRESTRequestManager alloc] init];
        
        [requestManager processPutRequestsForURLs:urls andBodies:bodies competionHandler:^(id resultObject) {
            [self startUpdateRequests];
        }];
        
        [requestManager release];
    }
    else
    {
        [self startUpdateRequests];
    }
}

- (void)startUpdateRequests
{
    //to-do tesztelni---------------------------------kell hozzá a gui
    
    if ([[MZMapperContentManager sharedContentManager].updatedPointObjects count])
    {
        NSMutableArray* urls = [NSMutableArray array];
        NSMutableArray* bodies = [NSMutableArray array];
        
        for (MZNode* node in [MZMapperContentManager sharedContentManager].updatedPointObjects)
        {
            NSURL* createURL = [NSURL urlForUpdateNodeForNodeID:node.nodeid];
            NSData* createBody = [[self generateNodeUpdateXMLWithNode:node] dataUsingEncoding:NSUTF8StringEncoding];
            
            [urls addObject:createURL];
            [bodies addObject:createBody];
            
            NSLog(@"update-elés: %@",[self generateNodeCreationXMLWithNode:node]);
        }
        
        
        
        //to-do tesztelni---------------------------------
        
        MZRESTRequestManager* requestManager = [[MZRESTRequestManager alloc] init];
        
        [requestManager processPutRequestsForURLs:urls andBodies:bodies competionHandler:^(id resultObject) {
            [self startChangesetClosingRequest];
        }];
        
        [requestManager release];
    }
    else
    {
        [self startChangesetClosingRequest];
    }
}

- (void)startChangesetClosingRequest
{
    MZRESTRequestManager* requestManager = [[MZRESTRequestManager alloc] init];
    
    [requestManager putRequestToURL:[NSURL urlForChangesetClosingForChangesetID:_changesetId] body:[@"" dataUsingEncoding:NSUTF8StringEncoding] completionHandler:^(id resultObject) {
        if (![resultObject isEqualToString:HTTP_STATUS_CODE_CONNECTION_FAILED])
        {
            NSLog(@"changeset closed");
            
            [self cleanUp];
        }
    }];
    
    [requestManager release];
}


- (NSString*)generateChangesetCreationXMLWithComment:(NSString*)comment
{
    NSString* retVal = nil;
    
    XMLWriter* xmlWriter = [[XMLWriter alloc] init];
    
    [xmlWriter writeStartElement:@"osm"];
    [xmlWriter writeStartElement:@"changeset"];
    
    [xmlWriter writeStartElement:@"tag"];
    [xmlWriter writeAttribute:@"k" value:@"created_by"];
    [xmlWriter writeAttribute:@"v" value:@"OpenStreetMap editor for iPad"];
    [xmlWriter writeEndElement];
    
    [xmlWriter writeStartElement:@"tag"];
    [xmlWriter writeAttribute:@"k" value:@"version"];
    [xmlWriter writeAttribute:@"v" value:@"1.0"];
    [xmlWriter writeEndElement];
    
    [xmlWriter writeStartElement:@"tag"];
    [xmlWriter writeAttribute:@"k" value:@"comment"];
    [xmlWriter writeAttribute:@"v" value:comment];
    [xmlWriter writeEndElement];
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    retVal = [[xmlWriter toString] retain];
    
    [xmlWriter release];
    
    return [retVal autorelease];
}

- (NSString*)generateDeletionXMLForNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    XMLWriter* xmlWriter = [[XMLWriter alloc] init];
    
    [xmlWriter writeStartElement:@"osm"];
    [xmlWriter writeStartElement:@"node"];
    
    [xmlWriter writeAttribute:@"id" value:aNode.nodeid];
    [xmlWriter writeAttribute:@"version" value:[NSString stringWithFormat:@"%d",aNode.version]];
    [xmlWriter writeAttribute:@"changeset" value:_changesetId];
    [xmlWriter writeAttribute:@"lat" value:[NSString stringWithFormat:@"%f",aNode.latitude]];
    [xmlWriter writeAttribute:@"lon" value:[NSString stringWithFormat:@"%f",aNode.longitude]];
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    retVal = [[xmlWriter toString] retain];
    
    [xmlWriter release];
    
    return [retVal autorelease];
}

- (NSString*)generateNodeCreationXMLWithNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    XMLWriter* xmlWriter = [[XMLWriter alloc] init];
    
    [xmlWriter writeStartElement:@"osm"];
    [xmlWriter writeStartElement:@"node"];
    
    [xmlWriter writeAttribute:@"changeset" value:_changesetId];
    [xmlWriter writeAttribute:@"lat" value:[NSString stringWithFormat:@"%f",aNode.latitude]];
    [xmlWriter writeAttribute:@"lon" value:[NSString stringWithFormat:@"%f",aNode.longitude]];
    
    for (NSString* key in [aNode.tags allKeys])
    {
        [xmlWriter writeStartElement:@"tag"];
        [xmlWriter writeAttribute:@"k" value:key];
        [xmlWriter writeAttribute:@"v" value:[aNode.tags valueForKey:key]];
        [xmlWriter writeEndElement];
    }
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    retVal = [[xmlWriter toString] retain];
    
    [xmlWriter release];
    
    return [retVal autorelease];
}

- (NSString*)generateNodeUpdateXMLWithNode:(MZNode*)aNode
{
    NSString* retVal = nil;
    
    XMLWriter* xmlWriter = [[XMLWriter alloc] init];
    
    [xmlWriter writeStartElement:@"osm"];
    [xmlWriter writeStartElement:@"node"];
    
    [xmlWriter writeAttribute:@"id" value:aNode.nodeid];
    [xmlWriter writeAttribute:@"version" value:[NSString stringWithFormat:@"%d",aNode.version + 1]];
    [xmlWriter writeAttribute:@"changeset" value:_changesetId];
    [xmlWriter writeAttribute:@"lat" value:[NSString stringWithFormat:@"%f",aNode.latitude]];
    [xmlWriter writeAttribute:@"lon" value:[NSString stringWithFormat:@"%f",aNode.longitude]];
    
    for (NSString* key in [aNode.tags allKeys])
    {
        [xmlWriter writeStartElement:@"tag"];
        [xmlWriter writeAttribute:@"k" value:key];
        [xmlWriter writeAttribute:@"v" value:[aNode.tags valueForKey:key]];
        [xmlWriter writeEndElement];
    }
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    retVal = [[xmlWriter toString] retain];
    
    [xmlWriter release];
    
    return [retVal autorelease];
}

- (void)cleanUp
{
    if (_changesetId)
    {
        [_changesetId release];
    }
}

@end
