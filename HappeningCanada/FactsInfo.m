//
//  FactsInfo.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 12/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "FactsInfo.h"
#import "Constants.h"

@implementation FactsInfo

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if(![self setPropertiesWithDictionary:dictionary]) {
            self = nil;
        }
    }
    return self;
}

- (BOOL)setPropertiesWithDictionary:(NSDictionary *)dictionary {
    
    // This check was added to detect NSNull
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if ([dictionary valueForKey:TitleKey] != [NSNull null] &&
        [dictionary valueForKey:TitleKey] != nil) {
        self.screenTitle = [dictionary valueForKey:TitleKey];
    }
    
    if ([[dictionary valueForKey:RowsKey] isKindOfClass:[NSArray class]]) {
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in [dictionary valueForKey:RowsKey]) {
            CanadaInfoRow *row = [[CanadaInfoRow alloc] initWithDictionary:dic];
            [arrTemp addObject:row];
        }
        
        self.canadaInfoArray = [[NSArray alloc] initWithArray:(NSArray*)arrTemp];
    }
    
    return YES;
}

@end
