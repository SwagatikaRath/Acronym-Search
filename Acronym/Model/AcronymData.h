//
//  AcronymData.h
//  Acronym
//
//  Created by Swagatika on 9/19/15.
//  Copyright (c) 2015 swagatika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymData : NSObject


- (id)initWithDictionary:(NSDictionary *)data;

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSDictionary *data;

@end
