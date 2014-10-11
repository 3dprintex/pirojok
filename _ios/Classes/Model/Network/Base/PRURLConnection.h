//
//  PRURLConnection.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRResponseData.h"

typedef void(^ConnectionSuccessBlock)(PRResponseData *responseData);
typedef void(^ConnectionErrorBlock)(NSError *error);

@interface PRURLConnection : NSURLConnection

@property(nonatomic, copy) ConnectionSuccessBlock success;
@property(nonatomic, copy) ConnectionErrorBlock error;

@end
