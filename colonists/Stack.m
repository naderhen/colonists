//
//  Stack.m
//  colonists
//
//  Created by Nader Hendawi on 2/3/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import "Stack.h"
#import "Tile.h"

@implementation Stack {
    NSMutableArray *_tiles;
}

- (id)init {
    if ((self = [super init])) {
        _tiles = [NSMutableArray arrayWithCapacity:20];
    }
    return self;
}

- (void)addTileToTop:(Tile *)tile {
    NSAssert(tile != nil, @"Tile cannot be nil");
	NSAssert([_tiles indexOfObject:tile] == NSNotFound, @"Already have this Tile");
	[_tiles addObject:tile];
}

- (NSUInteger)tileCount {
    return [_tiles count];
}

- (NSArray *)array {
    return [_tiles copy];
}

@end
