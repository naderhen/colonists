//
//  Tile.h
//  colonists
//
//  Created by Nader Hendawi on 2/3/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ResourceBrick,
    ResourceWool,
    ResourceWheat,
    ResourceOre
} Resource;

@interface Tile : NSObject

@property (nonatomic, assign, readonly) Resource resource;
@property (nonatomic, assign, readonly) int value;

- (id)initWithResource:(Resource)resource value:(int)value;

@end
