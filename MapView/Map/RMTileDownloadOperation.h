//
//  RMTileDownloadOperation.h
//  MapView
//
//  Created by Justin Miller on 7/2/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTileDownloadOperation : NSOperation

@property (nonatomic, retain) NSURL *downloadURL;
@property (nonatomic, readonly, retain) NSData *downloadData;

@end
