//
//  CanadaInfoTableViewCell.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaInfoTableViewCell.h"

@implementation CanadaInfoTableViewCell

#pragma mark - Lifecycle & Init Methods

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // Setting up the Table UI elements
        [self setupThumbImageView];
        [self setupTitle];
        [self setupDescription];
        
        // Setting UI Autolayout Constraints
        [self setupAutoLayoutConstraintsForRow];
    }
    
    return self;
}

#pragma mark - Custom inintlization methods

- (void)setupThumbImageView
{
    self.customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
    self.customImageView.frame = CGRectMake(13, 8, 104, 84);
    self.customImageView.clipsToBounds = YES;
    [self.customImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.customImageView.layer.borderColor = [[UIColor colorWithRed:0.0f green:128.0/255.0f blue:128.0/255.0f alpha:1.0f] CGColor];
    self.customImageView.layer.borderWidth = 3.0f;
    self.customImageView.layer.cornerRadius = 5.0f;
    
    [self.contentView addSubview:self.customImageView];
}

- (void)setupTitle
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 235, 21)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textColor = [UIColor colorWithRed:0.0f green:128.0/255.0f blue:128.0/255.0f alpha:1.0f];
    self.titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)setupDescription
{
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 31, 235, 21)];
    self.descriptionLabel.textAlignment = NSTextAlignmentJustified;
    self.descriptionLabel.font = [UIFont systemFontOfSize:14.0f];
    self.descriptionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.descriptionLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.descriptionLabel];
}

- (void)setupAutoLayoutConstraintsForRow
{
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
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_customImageView(==84)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView)]];
    
    // Align self.customImageView, self.titleLabel from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[_customImageView]-13-[_titleLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView, _titleLabel)]];
    
    // Align self.customImageView from the top
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_customImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView)]];
    
    // Align self.descriptionLabel from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_customImageView]-13-[_descriptionLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customImageView, _descriptionLabel)]];
    
    // Align self.titleLabel, self.descriptionLabel from the top/bottom
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_titleLabel]-5-[_descriptionLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel, _descriptionLabel)]];
}

#pragma mark - Property Assignmnet Method

- (void)setValuesToCell:(CanadaInfo *)canadaInfo
{
    self.titleLabel.text = canadaInfo.titleDetail;
    self.descriptionLabel.text = canadaInfo.descriptionDetail;
    
    [self lazyLoadImageWithURLString:canadaInfo.imageHref];
}

- (void)lazyLoadImageWithURLString:(NSString *)strImgURL
{
    self.customImageView.image = [UIImage imageNamed:@"placeholder"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:strImgURL]
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

#pragma mark - Calculating Cell Height

float const minCellHeight = 100.0f;

- (CGFloat)getHeightOfCell
{
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
