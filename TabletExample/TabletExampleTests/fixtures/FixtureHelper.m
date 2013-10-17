//
//  FixtureHelper.m
//  TweetClass
//
//  Created by Yee Peng Chia on 9/22/13.
//  Copyright (c) 2013 serkoart LLC. All rights reserved.
//

#import "FixtureHelper.h"

@implementation FixtureHelper

- (id)dataFromFixtureWithName:(NSString *)fileName
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"];
    return [NSData dataWithContentsOfFile:filePath];
}

- (NSData *)validDataFromFixture
{
    return [self dataFromFixtureWithName:@"property"];
}

- (NSData *)invalidDataFromFixture
{
    return [self dataFromFixtureWithName:@"property_invalid"];
}

@end
