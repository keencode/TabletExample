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
//    @"The American Radiator building is a strange and imposing landmark, a black-and-gold gothic skyscraper, towering above Bryant Park like something out of a comic book. How pleasantly surprising, then, to find that it houses a boutique hotel that is as sober and restrained as many of its competitors are loud and garish.\n\nRestrained doesn’t mean boring—just that the Bryant Park hotel eschews the kind of flashy showmanship that has become all too familiar in the boutique hotel world. The lobby, though decked out in rather unconventional black terra cotta and red leather, feels as serious as the building’s facade, without too-clever furniture or whimsical sculptural statements, and the Cellar Bar is true to its roots as well, with vaulted ceilings and tilework reminiscent of nothing so much as a restored subway station.\n\nAll the architectural sobriety doesn’t seem to be cramping the clientele’s style, especially during fashion week, which turns the park into an exhibition hall and momentarily makes the Bryant Park Hotel the most desirable address in New York.\n\nAs for the accommodations, a complete renovation from the American Radiator days apparently meant the death of many an interior wall—the rooms today are spacious, especially for a midtown hotel, and boast loft-style hardwood floors. Views tend toward the extraordinary, looking over Bryant Park, and some rooms come with private terraces, not at all New York standard. Expect lush goose-down duvets and rich linens, and massive tubs and sinks in the travertine bathrooms.\n\nThe cachet-meter has risen another notch or two with the opening of the New York outpost of LA’s painfully hip KOI sushi restaurant. Yet another reason for Bryant Park regulars to stop worrying about Soho and learn to love midtown.\n\n\n\n\n";
    
    NSLog(@"cleanedHotelContent: %@", [property cleanedHotelContent]);

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
