//
//  NSURL+MZMapperUtilities.m
//  MZMapper
//
//  Created by Zalan Mergl on 11/27/12.
//
//

#import "NSURL+MZMapperUtilities.h"

@implementation NSURL (MZMapperUtilities)

+ (NSURL*)urlForChangesetCreation
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/changeset/create",[NSString loginPath]]];
}

+ (NSURL*)urlForChangesetClosingForChangesetID:(NSString*)changesetID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/changeset/%@/close",[NSString loginPath], changesetID]];
}

+ (NSURL*)urlForDeleteNodeForNodeID:(NSString*)nodeID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/node/%@",[NSString loginPath], nodeID]];
}

+ (NSURL*)urlForCreateNode
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/node/create",[NSString loginPath]]];
}

+ (NSURL*)urlForUpdateNodeForNodeID:(NSString*)nodeID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/node/%@",[NSString loginPath], nodeID]];
}

@end
