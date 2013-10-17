//
//  KCPropertyResponseSerializer.h
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import "AFURLResponseSerialization.h"
#import "KCProperty.h"
#import "KCImageInfo.h"

@interface KCPropertyResponseSerializer : AFJSONResponseSerializer

//+ (BOOL)isValidJSON:(id)json;

- (NSArray *)propertyIDsFromJSON:(NSDictionary *)json;

- (NSArray *)parsePropertyJSON:(NSDictionary *)json;

- (void)updateProperty:(KCProperty *)property withInfo:(NSDictionary *)info;

- (NSArray *)addressFromJSON:(NSArray *)json;

- (NSArray *)imageInfosFromJSON:(NSArray *)json;

- (void)updateImageInfo:(KCImageInfo *)imageInfo withJSON:(NSDictionary *)info;

@end
