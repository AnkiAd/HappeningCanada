//
//  CanadaInfoTableViewCell.h
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanadaInfoRow.h"

@interface CanadaInfoTableViewCell : UITableViewCell

    @property (nonatomic, strong) UILabel *titleLabel;
    @property (nonatomic, strong) UILabel *descriptionLabel;
    @property (nonatomic, strong) UIImageView *customImageView;

    - (id)initCellWithReuseIdentifier:(NSString *)reuseIdentifier;
    - (void)setValuesToCell:(CanadaInfoRow *)canadaInfo;
    - (CGFloat)getHeightOfCell;

@end
