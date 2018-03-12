//
//  NetworkDataFetcher.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 12/03/18.
//  Copyright © 2018 Example. All rights reserved.
//


#import "NetworkClient.h"

#define CanadaFactsURLString @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@implementation NetworkClient

+ (void)fetchDataRowFromServerWithCompletion:(NDF_CompletionBlock)completionBlock {
    // Represent a URL load request
    NSURL *URL = [NSURL URLWithString:CanadaFactsURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    // Creates a session with the specified session configuration.
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            completionBlock(nil, error);
        }
        else {
            // NSISOLatin1StringEncoding gives the well result for character code of "ö"
            NSString *isoEncoding = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
            // Encoding can the bytes of the NSData be interpreted as a valid string
            NSData *utfEncoding = [isoEncoding dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:utfEncoding options:NSJSONReadingMutableContainers error:&error];
            
            completionBlock(jsonDict, error);
        }
    }];
    
    [dataTask resume];
}

@end
