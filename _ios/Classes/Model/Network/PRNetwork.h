//
//  PRNetwork.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRURLConnection.h"
#import "PRRequest.h"

@interface PRNetwork : NSObject

@property(nonatomic, copy) NSString *csrf;

-(void)sendWithRequest:(PRRequest *)request;
-(void)postWithUrlString:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error requestData:(PRRequestData *)requestData;
-(void)getWithUrlString:(NSString *)urlString onSuccess:(ConnectionSuccessBlock)success onError:(ConnectionErrorBlock)error;

@end
