//
//  KCPropertyTableViewCell.h
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCPropertyTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *neighborhoodLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *reviewsCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *meterScoreLabel;

@end
