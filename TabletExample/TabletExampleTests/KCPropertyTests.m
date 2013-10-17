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

#pragma mark - formattedAddressString

- (void)testFormattedAddressStringShouldReturnANonNilObject
{
    KCProperty *property = [[KCProperty alloc] init];
    property.address = @[@"60 Thompson Street", @"New York, NY 10011"];
    
    id formattedAddress = [property formattedAddressString];
    
    XCTAssertNotNil(formattedAddress, @"formattedAddress should NOT be nil");
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

#pragma mark - cleanedHotelContent

- (void)testCleanedHotelContentShouldReturnANonNilObject
{
    KCProperty *property = [[KCProperty alloc] init];
    property.hotelContent = @"Time was, a hotel’s life span was measured out in fractions of a century;";
    
    id cleanedhotelContent = [property cleanedHotelContent];
    
    XCTAssertNotNil(cleanedhotelContent, @"cleanedhotelContent should NOT be nil");
}

- (void)testCleanedHotelContentShouldReturnAString
{
    KCProperty *property = [[KCProperty alloc] init];
    property.hotelContent = @"Time was, a hotel’s life span was measured out in fractions of a century;";
    
    id cleanedhotelContent = [property cleanedHotelContent];

    XCTAssertTrue([cleanedhotelContent isKindOfClass:[NSString class]], @"cleanedhotelContent should be an NSString");
}

- (void)testCleanedHotelContentShouldContainReturnCharacters
{
    NSUInteger expectedNumberOfMatches = 0;
    KCProperty *property = [[KCProperty alloc] init];
    property.hotelContent = @"Time was, a hotel’s life span was measured out in fractions of a century; now just staying around for the better part of a decade is a genuine achievement. Having opened towards the end of the early wave of downtown Manhattan boutique hotels, 60 Thompson, a few years in, can now rightly be called an established classic.\r\\n\r\\nThe location doesn’t hurt, down one of SoHo’s swankier streets, and the carefully art-directed interiors have aged well (which is to say they haven’t visibly aged at all, unlike some other high-design vaguely Eastern-influenced properties). The soaring loft-style guest rooms are as quintessentially downtown as they come, a little bit luxe and a little bit boutique, with high-end Italian linens, 60 Thompson's Dean & Deluca pantries (we used to call them minibars) and bathrooms manage to be decadent and heavily marbled and yet stylish at the same time.\r\\n\r\\nOf course the rooms aren’t the whole story. A place like this lives and dies by its public spaces, which, in this case, are impeccable, from the guests-and-VIPs-only rooftop lounge to the Kittichai restaurant, an upscale Thai kitchen overseen by a Spice Market alumnus. This is the luxury boutique as it ought to be — plush but not precious, hip but not off-putting, and an authentic fixture in the nightlife of lower Manhattan.\r\\n\r\\n";
    
    NSString *cleanedhotelContent = [property cleanedHotelContent];

    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\r"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:cleanedhotelContent
                                                        options:0
                                                          range:NSMakeRange(0, [cleanedhotelContent length])];

    XCTAssertEqual(numberOfMatches, expectedNumberOfMatches, @"cleanedhotelContent should not contain return characters");
}


@end
