//
//  CanadaInfoTableViewCell.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaInfoTableViewCell.h"

@implementation CanadaInfoTableViewCell

    @synthesize titleLabel = _titleLabel;
    @synthesize descriptionLabel = _descriptionLabel;
    @synthesize customImageView = _customImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:19.0f];
        
//        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 300, 30)];
//        self.descriptionLabel.textColor = [UIColor blackColor];
//        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//
//        self.customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 60, 80, 80)];
        
        [self addSubview: self.titleLabel];
//        [self addSubview: self.descriptionLabel];
//        [self addSubview: self.customImageView];
    }
    return self;
}

@end
