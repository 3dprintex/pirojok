//
//  PRBaseData.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRRequest.h"

@interface PRRequest()

@end

@implementation PRRequest

+(PRRequest *)createRequestWith:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error requestData:(PRRequestData *)requestData {
    PRRequest *request = [[PRRequest alloc] initWith:urlString onSuccess:success onError:error requestData:requestData];
    return request;
}

- (instancetype)initWith:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error requestData:(PRRequestData *)requestData
{
    self = [super init];
    if (self) {
        self.success = success;
        self.error = error;
        self.urlString = urlString;
        self.requestData = requestData;
    }
    return self;
}

@end
