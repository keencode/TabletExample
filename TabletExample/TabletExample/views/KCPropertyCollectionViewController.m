//
//  KCPropertyCollectionViewController.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/17/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import "KCPropertyCollectionViewController.h"
#import "KCProperty+Network.h"
#import "KCPropertyCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "KCImageInfo.h"

@interface KCPropertyCollectionViewController ()

@end

@implementation KCPropertyCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *ids = @[@7, @278];
    [KCProperty remotePropertiesWithIDs:ids onSuccess:^(NSArray *properties) {
        self.properties = properties;
        [self.collectionView reloadData];
    } onFailure:^(NSError *error) {
        [self handleFailure:error];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleFailure:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SORRY!"
                                                        message:@"A network error has occured. Please try again later."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [self.properties count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KCPropertyCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"PropertyCollectionViewCell" forIndexPath:indexPath];
    KCProperty *property = [self.properties objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = property.name;
    cell.neighborhoodLabel.text = property.neighborhood;
    cell.addressLabel.text = [property formattedAddressString];
    cell.descriptionLabel.text = [property cleanedHotelContent];
    cell.reviewsCountLabel.text = [NSString stringWithFormat:@"Reviews: %@", property.reviewsCount];
    cell.meterScoreLabel.text = [NSString stringWithFormat:@"Meter Score: %@", property.meterScore];
    
    KCImageInfo *imageInfo = [property.images objectAtIndex:0];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", imageInfo.largeURL]];
    [cell.imageView setImageWithURL:imageURL];

    return cell;
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(640, 706);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

@end
