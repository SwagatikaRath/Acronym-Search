//
//  AcronymData.m
//  Acronym
//
//  Created by Swagatika on 9/19/15.
//  Copyright (c) 2015 swagatika. All rights reserved.
//

#import "AcronymData.h"

@implementation AcronymData

@synthesize data=_data;

- (id)init {
    if (self = [self initWithDictionary:nil]) {
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
        if (_data == nil) {
            _data = [NSDictionary dictionary];
        }
    }
    return self;
}

- (NSArray *)results {
    return self.data[@"lfs"];
}

@end
