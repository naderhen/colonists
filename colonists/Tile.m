//
//  Tile.m
//  colonists
//
//  Created by Nader Hendawi on 2/3/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import "Tile.h"

@implementation Tile

@synthesize resource = _resource;
@synthesize value = _value;

- (id)initWithResource:(Resource)resource value:(int)value {
    if ((self = [super init])) {
        _resource = resource;
        _value = value;
    }
    return self;
}

@end
