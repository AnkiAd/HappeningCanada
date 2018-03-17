//
//  CanadaInfo.h
//  HappeningCanada
//
//  Created by Ani Adhikary on 11/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CanadaInfoRow : NSObject
@property (strong, nonatomic) NSString *titleDetail;
@property (strong, nonatomic) NSString *descriptionDetail;
@property (strong, nonatomic) NSString *imageHref;

- (id)initWithDictionary:(NSDictionary *) dataDictionary;
@end
