//
//  KCProperty+Network.h
//  TabletExample
//
//  Created by Yee Peng Chia on 10/16/13.
//  Copyright (c) 2013 Keen Code. All rights reserved.
//

#import "KCProperty.h"

@interface KCProperty (Network)

+ (void)remotePropertiesWithIDs:(NSArray *)ids
                      onSuccess:(void (^)(NSArray *properties))successBlock
                      onFailure:(void (^)(NSError *error))failureBlock;

@end
