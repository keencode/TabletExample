//
//  PropertyNetworkTests.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FixtureHelper.h"
#import "KCProperty+Network.h"

@interface PropertyNetworkTests : XCTestCase
{
    FixtureHelper *fixtureHelper;
    NSDictionary *responseJSON;
}

@end

@implementation PropertyNetworkTests

- (void)setUp
{
    [super setUp];
    
    fixtureHelper = [[FixtureHelper alloc] init];
    
    NSData *data = [fixtureHelper validDataFromFixture];
    responseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingMutableLeaves
                                                     error:nil];
}

- (void)tearDown
{
    fixtureHelper = nil;
    responseJSON = nil;
    
    [super tearDown];
}

#pragma mark - isValidJSON

//- (void)testIsValidJSONShouldReturnTrueForValidData
//{
//    NSData *data = [fixtureHelper validDataFromFixture];
//    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves
//                                                error:nil];
//    
//    BOOL isValidJSON = [KCProperty isValidJSON:json];
//    
//    XCTAssertTrue(isValidJSON, @"isValidJSON should be true");
//}
//
//- (void)testIsValidJSONShouldReturnFalseForInvalidData
//{
//    NSData *data = [fixtureHelper invalidDataFromFixture];
//    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves
//                                                error:nil];
//    
//    BOOL isValidJSON = [KCProperty isValidJSON:json];
//    
//    XCTAssertFalse(isValidJSON, @"isValidJSON should be false");
//}

@end
