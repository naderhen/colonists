//
//  Stack.h
//  colonists
//
//  Created by Nader Hendawi on 2/3/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tile;

@interface Stack : NSObject

- (void)addTileToTop:(Tile *)tile;
- (NSUInteger)tileCount;
- (NSArray *)array;

@end
