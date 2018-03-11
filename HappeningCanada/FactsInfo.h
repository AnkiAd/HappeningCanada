//
//  FactsInfo.h
//  HappeningCanada
//
//  Created by Ani Adhikary on 12/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanadaInfo.h"

@interface FactsInfo : NSObject

@property (strong, nonatomic) NSString *screenTitle;
@property (strong, nonatomic) NSArray *canadaInfoArray;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
