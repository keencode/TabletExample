//
//  PropertyResponseSerializer.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/17/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FixtureHelper.h"
#import "KCPropertyResponseSerializer.h"
#import "KCImageInfo.h"

@interface PropertyResponseSerializerTests : XCTestCase
{
    NSDictionary *responseJSON;
    KCPropertyResponseSerializer *responseSerializer;
}

@end

@implementation PropertyResponseSerializerTests

- (void)setUp
{
    [super setUp];
    
    FixtureHelper *fixtureHelper = [[FixtureHelper alloc] init];
    NSData *data = [fixtureHelper validDataFromFixture];
    responseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingMutableLeaves
                                                     error:nil];
    
    responseSerializer = [KCPropertyResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];
}

- (void)tearDown
{
    responseSerializer = nil;
    responseJSON = nil;

    [super tearDown];
}

#pragma mark - propertyIDsFromJSON

- (void)testPropertyIDsFromJSONReturnsAnArrayForValidData
{
    id idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    
    XCTAssertTrue([idsFromJSON isKindOfClass:[NSArray class]], @"idsFromJSON is an NSArray");
}

- (void)testPropertyIDsFromJSONReturnsAnArrayMatchingTheExpectedArray
{
    NSArray *expectedIDs = [[responseJSON objectForKey:@"query"] objectForKey:@"property"];
    
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    
    XCTAssertEqualObjects(idsFromJSON, expectedIDs, @"idsFromJSON should match expectedIDs");
}

#pragma mark - parsePropertyJSON

- (void)testParsePropertyJSONReturnsANonNilObject
{
    id properties = [responseSerializer parsePropertyJSON:responseJSON];
    
    XCTAssertNotNil(properties, @"properties should NOT be nil");
}

- (void)testParsePropertyJSONReturnsAnArray
{
    id properties = [responseSerializer parsePropertyJSON:responseJSON];
    
    XCTAssertTrue([properties isKindOfClass:[NSArray class]], @"properties should an NSArray");
}

- (void)testParsePropertyJSONReturnsAnArrayWithTheCorrectCount
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger expectedCount = [idsFromJSON count];
    
    NSArray *properties = [responseSerializer parsePropertyJSON:responseJSON];
    
    XCTAssertEqual([properties count], expectedCount, @"properties count should equal expectedCount");
}

- (void)testParsePropertyJSONContainsPropertyWithTheExpectedID
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *expectedPropertyID = [idsFromJSON objectAtIndex:propertyIndex];
    
    NSArray *properties = [responseSerializer parsePropertyJSON:responseJSON];
    KCProperty *property = [properties objectAtIndex:propertyIndex];
    
    XCTAssertEqualObjects(property.propertyID, expectedPropertyID, @"propertyID attribute should match expectedPropertyID");
}

#pragma mark - updateWithInfo

- (void)testUpdateWithInfoShouldAssignTheCorrectName
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSString *expectedName = [propertyInfo objectForKey:@"name"];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqualObjects(property.name, expectedName, @"property.name should match expectedName");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectNeighborhood
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSString *expectedNeighborhood = [propertyInfo objectForKey:@"neighborhood"];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqualObjects(property.neighborhood, expectedNeighborhood, @"property.neighborhood should match expectedNeighborhood");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectAddress
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *expectedAddress = [propertyInfo objectForKey:@"address"];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqualObjects(property.address, expectedAddress, @"property.address should match expectedAddress");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectHotelContent
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSString *expectedHotelContent = [propertyInfo objectForKey:@"hotel_content"];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqualObjects(property.hotelContent, expectedHotelContent, @"property.hotelContent should match expectedHotelContent");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectNumberOfReviews
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSNumber *expectedReviewsCount = [propertyInfo objectForKey:@"num_reviews"];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqualObjects(property.reviewsCount, expectedReviewsCount, @"property.reviewsCount should match expectedReviewsCount");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectMeterScore
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSNumber *expectedMeterScore = [[propertyInfo objectForKey:@"feedback_stats"] objectForKey:@"meter_score"];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqualObjects(property.meterScore, expectedMeterScore, @"property.meterScore should match expectedMeterScore");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectImagesCount
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *images = [propertyInfo objectForKey:@"images"];
    NSUInteger expectedImagesCount = [images count];
    
    KCProperty *property = [[KCProperty alloc] init];
    [responseSerializer updateProperty:property withInfo:propertyInfo];
    
    XCTAssertEqual([property.images count], expectedImagesCount, @"images count should equal expectedImagesCount");
}

#pragma mark - imageInfosFromJSON

- (void)testImageInfosFromJSONShouldReturnANonNilObject
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *imagesJSON = [propertyInfo objectForKey:@"images"];
    
    id images = [responseSerializer imageInfosFromJSON:imagesJSON];
    
    XCTAssertNotNil(images, @"images should NOT be nil");
}

- (void)testImageInfosFromJSONShouldReturnAnArray
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *imagesJSON = [propertyInfo objectForKey:@"images"];
    
    id images = [responseSerializer imageInfosFromJSON:imagesJSON];
    
    XCTAssertTrue([images isKindOfClass:[NSArray class]], @"images should be a NSArray");
}

- (void)testImageInfosFromJSONShouldReturnCorrectCount
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *imagesJSON = [propertyInfo objectForKey:@"images"];
    NSUInteger expectedCount = [imagesJSON count];
    
    NSArray *images = [responseSerializer imageInfosFromJSON:imagesJSON];
    
    XCTAssertEqual([images count], expectedCount, @"images count should be equal to expectedCount");
}

#pragma mark - updateWithInfo

- (void)testUpdateWithInfoShouldAssignTheCorrectID
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *images = [propertyInfo objectForKey:@"images"];
    NSDictionary *imageJSON = [images objectAtIndex:0];
    NSNumber *expectedID = [imageJSON objectForKey:@"id"];
    
    KCImageInfo *imageInfo = [[KCImageInfo alloc] init];
    [responseSerializer updateImageInfo:imageInfo withJSON:imageJSON];
    
    XCTAssertEqualObjects(imageInfo.uid, expectedID, @"image.uid should match expectedID");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectThumbnailURL
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *images = [propertyInfo objectForKey:@"images"];
    NSDictionary *imageJSON = [images objectAtIndex:0];
    NSNumber *expectedThumbnailURL = [imageJSON objectForKey:@"thumbnail_url"];
    
    KCImageInfo *imageInfo = [[KCImageInfo alloc] init];
    [responseSerializer updateImageInfo:imageInfo withJSON:imageJSON];
    
    XCTAssertEqualObjects(imageInfo.thumbnailURL, expectedThumbnailURL, @"image.thumbnailURL should match expectedThumbnailURL");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectLargeURL
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *images = [propertyInfo objectForKey:@"images"];
    NSDictionary *imageJSON = [images objectAtIndex:0];
    NSNumber *expectedLargeURL = [imageJSON objectForKey:@"large_url"];
    
    KCImageInfo *imageInfo = [[KCImageInfo alloc] init];
    [responseSerializer updateImageInfo:imageInfo withJSON:imageJSON];
    
    XCTAssertEqualObjects(imageInfo.largeURL, expectedLargeURL, @"image.largeURL should match expectedLargeURL");
}

- (void)testUpdateWithInfoShouldAssignTheCorrectCaption
{
    NSArray *idsFromJSON = [responseSerializer propertyIDsFromJSON:responseJSON];
    NSUInteger propertyIndex = 0;
    NSString *propertyID = [idsFromJSON objectAtIndex:propertyIndex];
    NSDictionary *propertyInfo = [[responseJSON objectForKey:@"response"] objectForKey:propertyID];
    NSArray *images = [propertyInfo objectForKey:@"images"];
    NSDictionary *imageJSON = [images objectAtIndex:0];
    NSNumber *expectedCaption = [imageJSON objectForKey:@"caption"];
    
    KCImageInfo *imageInfo = [[KCImageInfo alloc] init];
    [responseSerializer updateImageInfo:imageInfo withJSON:imageJSON];
    
    XCTAssertEqualObjects(imageInfo.caption, expectedCaption, @"image.caption should match expectedCaption");
}

@end
