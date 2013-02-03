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
        _tiles = [NSMutableArray arrayWithCapacity:20];
        
        
        NSMutableArray *numberArray = [[NSMutableArray alloc] initWithObjects:@"2",@"3", @"3", @"4", @"4", @"5", @"5", @"6", @"6", @"7", @"8", @"8", @"9", @"9", @"10", @"10", @"11", @"11", @"12", @"13", nil];
        
        
        for (Resource resource = ResourceBrick; resource <= ResourceOre; ++resource) {
            for (int rcount = 0; rcount <= 3; ++rcount) {
                int i = arc4random() % [numberArray count];
                NSString *newValue = [numberArray objectAtIndex:i];
                Tile *tile = [[Tile alloc] initWithResource:resource value:[newValue intValue]];
                [_tiles addObject:tile];
                [numberArray removeObjectAtIndex:i];
            }
        }
    }
    return self;
}

-(NSArray *)tiles {
    return _tiles;
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
