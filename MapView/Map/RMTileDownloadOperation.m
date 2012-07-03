//
//  RMTileDownloadOperation.m
//  MapView
//
//  Created by Justin Miller on 7/2/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import "RMTileDownloadOperation.h"

@implementation RMTileDownloadOperation
{
    NSURLConnection *download;
    NSMutableData *fetchData;
    BOOL finished;
}

@synthesize downloadURL;

- (void)start
{
    if ([self isCancelled])
        return;

    if ( ! [NSThread isMainThread])
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];

    download = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:self.downloadURL] delegate:self];
}

- (void)dealloc
{
    [download cancel];
    [download release]; download = nil;
    [fetchData release]; fetchData = nil;
    [super dealloc];
}

- (NSData *)downloadData
{
    if ([self isFinished] && [fetchData length])
        return [NSData dataWithData:fetchData];

    return nil;
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return (download && ! self.isFinished);
}

- (BOOL)isFinished
{
    return finished;
}

- (void)cancel
{
    [download cancel];
    [download release]; download = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    fetchData = [[NSMutableData data] retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [fetchData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self willChangeValueForKey:@"isFinished"];
    finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

@end
