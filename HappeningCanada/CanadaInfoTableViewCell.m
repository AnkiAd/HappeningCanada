//
//  CanadaInfoTableViewCell.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaInfoTableViewCell.h"

@implementation CanadaInfoTableViewCell

#pragma mark - Lifecycle methods

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initCellWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // Setting up the Table UI elements
        [self setupRowDetailImageView];
        [self setupTitleLabel];
        [self setupDescriptionLabel];
        
        // Setting UI Autolayout Constraints
        [self setupAutoLayoutConstraintsForRow];
    }
    
    return self;
}

#pragma mark - Setup UI Elements - Title, Desciption and ImageView

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 235, 21)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 20.0f];
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textColor = UIColor.brownColor;
    self.titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)setupDescriptionLabel {
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 31, 235, 21)];
    self.descriptionLabel.textAlignment = NSTextAlignmentJustified;
    self.descriptionLabel.font = [UIFont systemFontOfSize:16.0f];
    self.descriptionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.descriptionLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.descriptionLabel];
}

- (void)setupRowDetailImageView {
    self.customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
    self.customImageView.frame = CGRectMake(13, 8, 104, 94);
    self.customImageView.clipsToBounds = YES;
    [self.customImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.customImageView.layer.cornerRadius = 10.0f;
    
    [self.contentView addSubview:self.customImageView];
}

- (void)setupAutoLayoutConstraintsForRow {
    [self.customImageView removeConstraints:self.customImageView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.descriptionLabel removeConstraints:self.descriptionLabel.constraints];
    [self.contentView removeConstraints:self.contentView.constraints];
    
    [self.customImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Width constraint of self.customImageView
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_customImageView(==104)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView)]];
    
    // Height constraint of self.customImageView
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_customImageView(==94)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView)]];
    
    // Align self.customImageView, self.titleLabel from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[_customImageView]-13-[_titleLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView, _titleLabel)]];
    
    // Align self.customImageView from the top
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_customImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView)]];
    
    // Align self.descriptionLabel from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_customImageView]-13-[_descriptionLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView, _descriptionLabel)]];
    
    // Align self.titleLabel, self.descriptionLabel from the top/bottom
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_titleLabel]-5-[_descriptionLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel, _descriptionLabel)]];
}

#pragma mark - Assign values to UI Elements

//Set the values in Row Elements
- (void)setValuesToCell: (CanadaInfoRow *)canadaInfo {
    self.titleLabel.text = canadaInfo.titleDetail;
    self.descriptionLabel.text = canadaInfo.descriptionDetail;
    
    [self lazyLoadImageWithURLString:canadaInfo.imageHref];
}

//This method loads the images lazily from the ImageURL
- (void)lazyLoadImageWithURLString: (NSString *)imgURLString {
    self.customImageView.image = [UIImage imageNamed:@"placeholder"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:imgURLString]
    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                 UIImage *image = [UIImage imageWithData:data];
                 if (image) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.customImageView.image = image;
                     });
                 }
             }
         }];
    [task resume];
}

#pragma mark - Calculating Row Height

float const minCellHeight = 110.0f;

- (CGFloat)getHeightOfCell {
    float width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 140;
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGRect rectTitle = [attributedTitle boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    
    NSAttributedString *attributedDesc = [[NSAttributedString alloc] initWithString:self.descriptionLabel.text attributes:@{NSFontAttributeName:self.descriptionLabel.font}];
    CGRect rectDesc = [attributedDesc boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
    
    // Calculating the height of cell based on its content.
    float height = ceil(rectTitle.size.height) + ceil(rectDesc.size.height) + 15.0f; //15 is margin from top & bottom
    
    return (height < minCellHeight) ? minCellHeight : height;
}

@end
