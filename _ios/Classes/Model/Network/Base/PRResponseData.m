//
//  PRResponseData.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRResponseData.h"

@interface PRResponseData()

@property(nonatomic, strong) NSData *data;

@end

@implementation PRResponseData

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

-(id)getJSONData {
    id data = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    return data;
}

+(PRResponseData *)createWithData:(NSData *)data {
    PRResponseData *responseData = [[PRResponseData alloc] initWithData:data];
    return responseData;
}

@end
