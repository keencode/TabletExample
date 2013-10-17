//
//  KCProperty.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import "KCProperty.h"

@implementation KCProperty

- (NSString *)formattedAddressString
{
    NSMutableString *addressStr = [NSMutableString stringWithString:@""];
    
    for (NSString *str in self.address) {
        [addressStr appendFormat:@"%@\n", str];
    }
    
    return addressStr;
}

- (NSString *)cleanedHotelContent
{
    NSString *str = [self.hotelContent stringByReplacingOccurrencesOfString:@"\r\\n\r\\n" withString:@"\n\n"];
    return str;
}

@end
