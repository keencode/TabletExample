//
//  ImageInfoTests.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FixtureHelper.h"
#import "KCProperty+Network.h"
#import "KCImageInfo.h"

@interface ImageInfoTests : XCTestCase
{
    NSDictionary *imageInfo;
}

@end

@implementation ImageInfoTests

- (void)setUp
{
    [super setUp];
    
    FixtureHelper *fixtureHelper = [[FixtureHelper alloc] init];
    NSData *data = [fixtureHelper validDataFromFixture];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingMutableLeaves
                                                     error:nil];
    
    NSArray *idsFromJSON = [KCProperty propertyIDsFromJSON:responseJSON];
    NSString *propertyID = [idsFromJSON objectAtIndex:0];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *images = [propertyInfo objectForKey:@"images"];
    imageInfo = [images objectAtIndex:0];
}

- (void)tearDown
{
    imageInfo = nil;
    
    [super tearDown];
}



@end
