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

- (void)testRequestURLWithIDsShouldReturnANonNilObject
{
    NSArray *ids = @[@5, @25];
    
    id urlWithIDs = [KCProperty requestURLWithIDs:ids];
    
    XCTAssertNotNil(urlWithIDs, @"urlWithIDs should NOT be nil");
}

- (void)testRequestURLWithIDsShouldReturnAnNSURL
{
    NSArray *ids = @[@5, @25];
    
    id urlWithIDs = [KCProperty requestURLWithIDs:ids];
    
    XCTAssertTrue([urlWithIDs isKindOfClass:[NSURL class]], @"urlWithIDs should be an NSURL");
}

- (void)testRequestURLWithIDsShouldContainTheCorrectNumberOfPropertyIDs
{
    NSArray *ids = @[@5, @25];
    NSUInteger expectedPropertyCount = [ids count];
    
    NSURL *urlWithIDs = [KCProperty requestURLWithIDs:ids];
    NSString *urlStr = [urlWithIDs absoluteString];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"property="
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:urlStr
                                                        options:0
                                                          range:NSMakeRange(0, [urlStr length])];
    
    XCTAssertEqual(numberOfMatches, expectedPropertyCount, @"numberOfMatches should equal expectedPropertyCount");
}

- (void)testRequestURLWithIDsShouldReturnURLStringMatchingExpectedString
{
    NSArray *ids = @[@5, @25];
    NSString *expectedURLStr = @"http://api.tablethotels.com/bear/property_info?property=5&property=25&language=en";
    
    NSURL *urlWithIDs = [KCProperty requestURLWithIDs:ids];
    NSString *urlStr = [urlWithIDs absoluteString];
    
    XCTAssertEqualObjects(urlStr, expectedURLStr, @"urlStr should match expectedURLStr");
}

@end
