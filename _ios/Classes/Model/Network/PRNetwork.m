//
//  PRNetwork.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRNetwork.h"
#import "PRCommon.h"

@interface PRNetwork()<NSURLConnectionDataDelegate>

@end

@implementation PRNetwork

#pragma mark - public
-(void)postWithUrlString:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error requestData:(PRRequestData *)requestData {
    urlString = [self _fullUrlString:urlString];
    requestData.csrf = self.csrf;
    PRRequest *request = [PRRequest createRequestWith:urlString onSuccess:success onError:error requestData:requestData];
    request.method = MethodTypePOST;
    [self _startConnectionWithRequest:request];
}

-(void)getWithUrlString:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error {
    urlString = [self _fullUrlString:urlString];
    PRRequest *request = [PRRequest createRequestWith:urlString onSuccess:success onError:error requestData:nil];
    [self _startConnectionWithRequest:request];
}

-(void)sendWithRequest:(PRRequest *)request {
    [self _startConnectionWithRequest:request];
}

#pragma mark - internal methods
-(NSString *)_fullUrlString:(NSString *)urlString {
    urlString = [NSString stringWithFormat:@"%@%@%@", kProtocol, kDomine, urlString];
    return urlString;
}

#pragma mark - core
-(void)_startConnectionWithRequest:(PRRequest *)request {
    [self _createRequestWithRequest:request];
    PRURLConnection *connection = [[PRURLConnection alloc] initWithRequest:request.request delegate:self];
    connection.success = request.success;
    connection.error = request.error;
    [connection start];
}

-(void)_createRequestWithRequest:(PRRequest *)request {
    NSURL *url = [NSURL URLWithString:request.urlString];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    if (request.method == MethodTypePOST) {
        [mutableRequest setHTTPMethod:@"POST"];
        [mutableRequest setHTTPBody:request.requestData.getPhpData];
    }
    request.request = mutableRequest.copy;
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(PRURLConnection *)connection didFailWithError:(NSError *)error {
    if (connection.error) {
        connection.error(error);
    }
}

-(void)connection:(PRURLConnection *)connection didReceiveData:(NSData *)data {
    if (connection.success) {
        PRResponseData *responseData = [PRResponseData createWithData:data];
        connection.success(responseData);
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    int sdf = 0;
}

@end
