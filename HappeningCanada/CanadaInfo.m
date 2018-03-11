//
//  CanadaInfo.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 11/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaInfo.h"

@implementation CanadaInfo

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
    
    // This check was added to detect Null
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    // Setting default values
    self.titleDetail = @"";
    self.descriptionDetail = @"";
    self.imageHref = @"";
    
    // Setting values from Dictionary
    if ([dictionary valueForKey:@"title"] != [NSNull null] &&
        [dictionary valueForKey:@"title"] != nil) {
        self.titleDetail = [dictionary valueForKey:@"title"];
    }
    
    if ([dictionary valueForKey:@"description"] != [NSNull null] &&
        [dictionary valueForKey:@"description"] != nil) {
        self.descriptionDetail = [dictionary valueForKey:@"description"];
    }
    
    if ([dictionary valueForKey:@"imageHref"] != [NSNull null] &&
        [dictionary valueForKey:@"imageHref"] != nil) {
        self.imageHref = [dictionary valueForKey:@"imageHref"];
    }
    
    return YES;
}
@end
