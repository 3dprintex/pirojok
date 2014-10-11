//
//  PRBaseData.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRURLConnection.h"
#import "PRRequestData.h"

typedef enum {
    MethodTypeGET,
    MethodTypePOST
} MethodType;

@interface PRRequest : NSObject

@property(nonatomic, copy) NSString *urlString;
@property(nonatomic, copy) ConnectionSuccessBlock success;
@property(nonatomic, copy) ConnectionErrorBlock error;
@property(nonatomic, assign) MethodType method;
@property(nonatomic, strong) NSURLRequest *request;
@property(nonatomic, strong) PRRequestData *requestData;

+(PRRequest *)createRequestWith:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error requestData:(PRRequestData *)requestData;

@end
