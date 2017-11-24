//
//  GMDatabaseNetwork.m
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "GMDatabaseNetwork.h"
static NSString *const kAPIBaseURL = @"API_BASE_URL";

@implementation GMDatabaseNetwork

#pragma mark - Public Methods
+ (instancetype)sharedClient {
    static GMDatabaseNetwork *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [self alloc];
    });
    
    return sharedClient;
}

- (void)requestWithAPI:(NSString *)api parameters:(id)parameters withCompletion:(void (^)(id, NSError *))block {
    NSString *urlConnection = [self setupBackendClientWithParameters:parameters andAPI:api];
    NSMutableURLRequest *requestURL = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlConnection]];
    [requestURL setHTTPMethod:@"GET"];
    [requestURL setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *jSONresponse = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
            block(jSONresponse, error);
        } else {
            block(nil, error);
        }
        
    }] resume];
}

#pragma mark - Methods Private
- (NSString *)urlEncode:(NSString *)object {
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    return [object stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (NSString *)setupBackendClientWithParameters:(id)parameters andAPI:(NSString *)api{
    NSString *stringURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:kAPIBaseURL];
    stringURL = [stringURL stringByAppendingString:api];
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (id key in parameters) {
        id value = [parameters objectForKey: key];
        NSString *query = [NSString stringWithFormat: @"%@=%@", [self urlEncode:key], [self urlEncode:value]];
        [queryItems addObject: query];
    }
    
    return [stringURL stringByAppendingString:[queryItems componentsJoinedByString: @"&"]];
}

@end