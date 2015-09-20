//
//  ACHttpClientApi.m
//  Acronym
//
//  Created by Swagatika on 9/19/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import "ACHttpClientApi.h"
#import "AcronymData.h"

@implementation ACHttpClientApi



+ (ACHttpClientApi *)sharedACHttpClientApi
{
    static ACHttpClientApi *_sharedACHttpClientApi = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedACHttpClientApi = [[self alloc] initWithBaseURL:[NSURL URLWithString:acronymBaseUrl]];
    });
    
    return _sharedACHttpClientApi;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        }
    
    return self;
}

-(void)fetchAcronym:(NSString *)url parameters:(NSDictionary*)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    // Make sure to set the responseSerializer correctly
    self.responseSerializer.acceptableContentTypes = nil;
    [self GET:acronymBaseUrl parameters:parameters success:success
        failure:failure];
}

@end
