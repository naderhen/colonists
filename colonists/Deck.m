//
//  Deck.m
//  colonists
//
//  Created by Nader Hendawi on 2/3/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import "Deck.h"
#import "Tile.h"

@implementation Deck {
    
    NSMutableArray *_tiles;

}

- (id)init {
    if ((self = [super init])) {
        _tiles = [NSMutableArray arrayWithCapacity:50];
        for (Resource resource = ResourceBrick; resource <= ResourceOre; ++resource) {
            for (int value = 1; value <= 12; ++value) {
                Tile *tile = [[Tile alloc] initWithResource:resource value:value];
                [_tiles addObject:tile];
//                NSLog(@"%@: %@", tile.resource, tile.value);
            }
        }
    }
    return self;
}

- (int)tilesRemaining {
    return[_tiles count];
}

- (void)shuffle {
    NSUInteger count = [_tiles count];
    NSMutableArray *shuffled = [NSMutableArray arrayWithCapacity:count];
    
    for (int t=0; t < count; ++t) {
        int i = arc4random() % [self tilesRemaining];
        Tile *tile = [_tiles objectAtIndex:i];
        [shuffled addObject:tile];
        [_tiles removeObjectAtIndex:i];
    }
    
    NSAssert([self tilesRemaining] == 0, @"Original deck should now be empty");
    _tiles = shuffled;
}

- (Tile *)draw {
    NSAssert([self tilesRemaining] > 0, @"No more tiles in the deck");
    Tile *tile = [_tiles lastObject];
    [_tiles removeLastObject];
    return tile;
}

@end
