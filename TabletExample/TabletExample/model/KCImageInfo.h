//
//  KCImageInfo.h
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageInfo : NSObject

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSString *largeURL;
@property (nonatomic, strong) NSString *caption;

@end
