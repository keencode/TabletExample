//
//  KCProperty.h
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCProperty : NSObject

@property (nonatomic, strong) NSString *propertyID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *neighborhood;
@property (nonatomic, strong) NSArray *address;
@property (nonatomic, strong) NSString *hotelContent;
@property (nonatomic, strong) NSNumber *reviewsCount;
@property (nonatomic, strong) NSNumber *meterScore;
@property (nonatomic, strong) NSArray *images;

- (NSString *)formattedAddressString;
- (NSString *)cleanedHotelContent;

@end
