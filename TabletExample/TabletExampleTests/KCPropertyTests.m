//
//  KCPropertyTests.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/17/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KCProperty.h"

@interface KCPropertyTests : XCTestCase

@end

@implementation KCPropertyTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testFormattedAddressStringShouldReturnANonNilObject
{
    KCProperty *property = [[KCProperty alloc] init];
    property.address = @[@"60 Thompson Street", @"New York, NY 10011"];
    
    id formattedAddress = [property formattedAddressString];
    
    XCTAssertNotNil(formattedAddress, @"formattedAddress should not be nil");
}

- (void)testFormattedAddressStringShouldReturnAString
{
    KCProperty *property = [[KCProperty alloc] init];
    property.address = @[@"60 Thompson Street", @"New York, NY 10011"];
    
    id formattedAddress = [property formattedAddressString];
    
    XCTAssertTrue([formattedAddress isKindOfClass:[NSString class]], @"formattedAddress should be an NSString");
}

- (void)testFormattedAddressStringShouldMatchTheExpectedString
{
    KCProperty *property = [[KCProperty alloc] init];
    property.address = @[@"60 Thompson Street", @"New York, NY 10011"];
    NSString *expectedString = [NSString stringWithFormat:@"%@\n%@\n", [property.address objectAtIndex:0],
                                [property.address objectAtIndex:1]];
    
    NSString *formattedAddress = [property formattedAddressString];
    
    XCTAssertEqualObjects(formattedAddress, expectedString, @"formattedAddress should match expectedString");
}

@end
