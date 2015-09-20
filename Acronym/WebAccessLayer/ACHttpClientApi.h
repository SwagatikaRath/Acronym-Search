//
//  ACHttpClientApi.h
//  Acronym
//
//  Created by Swagatika on 9/19/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "AcronymConstant.h"

@protocol AcronymHttpClientDelegate;

@interface ACHttpClientApi : AFHTTPSessionManager

/*
 * @discussion
 * @return SingleTon instance of ACHttpClientApi
 */
+ (ACHttpClientApi*)sharedACHttpClientApi;


/*
 *Initialize the object with a base URL.
 *Request and expect JSON responses from the web service
*/
- (instancetype)initWithBaseURL:(NSURL *)url;


/*
 * @discussion - This method makes a GET request to the given URL.
 * @param url: url string of webservice
 * @parameters: Dictionary of parameters to be sent
 */
-(void)fetchAcronym:(NSString *)url parameters:(NSDictionary*)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

