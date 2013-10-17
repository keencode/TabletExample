//
//  KCPropertyResponseSerializer.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import "KCPropertyResponseSerializer.h"

@implementation KCPropertyResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    NSDictionary *json = [super responseObjectForResponse:response data:data error:error];
    NSArray *properties = [self parsePropertyJSON:json];
    return properties;
}

- (NSArray *)propertyIDsFromJSON:(NSDictionary *)json
{
    return [[json objectForKey:@"query"] objectForKey:@"property"];
}

- (NSArray *)parsePropertyJSON:(NSDictionary *)json
{
    NSArray *propertyIDs = [self propertyIDsFromJSON:json];
    NSMutableArray *properties = [NSMutableArray arrayWithCapacity:[propertyIDs count]];
    NSDictionary *response = [json objectForKey:@"response"];
    
    for (NSString *propID in propertyIDs) {
        NSDictionary *propertyInfo = [response objectForKey:propID];
        
        KCProperty *property = [[KCProperty alloc] init];
        property.propertyID = propID;
        [self updateProperty:property withInfo:propertyInfo];
        [properties addObject:property];
    }
    
    return properties;
}

- (void)updateProperty:(KCProperty *)property withInfo:(NSDictionary *)info;
{
    property.name = [info objectForKey:@"name"];
    property.neighborhood = [info objectForKey:@"neighborhood"];
    property.hotelContent = [info objectForKey:@"hotel_content"];
    property.reviewsCount = [info objectForKey:@"num_reviews"];
    property.meterScore = [[info objectForKey:@"feedback_stats"] objectForKey:@"meter_score"];
    
    NSArray *imagesJSON = [info objectForKey:@"images"];
    property.images = [self imageInfosFromJSON:imagesJSON];
    
    NSArray *addressJSON = [info objectForKey:@"address"];
    property.address = [self addressFromJSON:addressJSON];
}

- (NSArray *)addressFromJSON:(NSArray *)json
{
    NSMutableArray *address = [NSMutableArray arrayWithCapacity:[json count]];
    
    for (NSString *addressLine in json) {
        [address addObject:addressLine];
    }
    
    return address;
}

- (NSArray *)imageInfosFromJSON:(NSArray *)json
{
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[json count]];
    
    for (NSDictionary *imageJSON in json) {
        KCImageInfo *imageInfo = [[KCImageInfo alloc] init];
        [self updateImageInfo:imageInfo withJSON:imageJSON];
        [images addObject:imageInfo];
    }
    
    return images;
}

- (void)updateImageInfo:(KCImageInfo *)imageInfo withJSON:(NSDictionary *)info;
{
    imageInfo.uid = [info objectForKey:@"id"];
    imageInfo.thumbnailURL = [info objectForKey:@"thumbnail_url"];
    imageInfo.largeURL = [info objectForKey:@"large_url"];
    imageInfo.caption = [info objectForKey:@"caption"];
}

@end
