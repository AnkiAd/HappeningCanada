//
//  NetworkDataFetcher.h
//  HappeningCanada
//
//  Created by Ani Adhikary on 12/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NDF_CompletionBlock)(NSDictionary *response, NSError *error);

@interface NetworkClient : NSObject

+ (void)fetchDataFromNetwork:(NDF_CompletionBlock)completionBlock;

@end
