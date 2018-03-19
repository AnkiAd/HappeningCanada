//
//  CanadaInfo.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 11/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaInfoRow.h"
#import "Constants.h"

@implementation CanadaInfoRow

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
    self.titleDetail = EmptyString;
    self.descriptionDetail = EmptyString;
    self.imageHref = EmptyString;
    
    // Setting values from Dictionary
    if ([dictionary valueForKey:TitleKey] != [NSNull null] &&
        [dictionary valueForKey:TitleKey] != nil) {
        self.titleDetail = [dictionary valueForKey:TitleKey];
    }
    
    if ([dictionary valueForKey:DescriptionKey] != [NSNull null] &&
        [dictionary valueForKey:DescriptionKey] != nil) {
        self.descriptionDetail = [dictionary valueForKey:DescriptionKey];
    }
    
    if ([dictionary valueForKey:ImageHrefKey] != [NSNull null] &&
        [dictionary valueForKey:ImageHrefKey] != nil) {
        self.imageHref = [dictionary valueForKey:ImageHrefKey];
    }
    
    return YES;
}

@end
