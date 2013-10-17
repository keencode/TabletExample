//
//  KCProperty+Network.m
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import "KCProperty+Network.h"
#import "KCImageInfo.h"
#import "AFHTTPRequestOperation.h"
#import "KCPropertyResponseSerializer.h"

static NSString * const BaseURLString = @"http://api.tablethotels.com";

@implementation KCProperty (Network)

+ (void)remotePropertiesWithIDs:(NSArray *)ids
                      onSuccess:(void (^)(NSArray *properties))successBlock
                      onFailure:(void (^)(NSError *error))failureBlock;
{
    NSURL *url = [NSURL URLWithString:@"http://api.tablethotels.com/bear/property_info?property=7&language=en"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [KCPropertyResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *properties = (NSArray *)responseObject;
        successBlock(properties);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        failureBlock(error);
    }];
    
    [operation start];
}



@end
