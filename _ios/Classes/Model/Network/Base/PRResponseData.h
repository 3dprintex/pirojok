//
//  PRResponseData.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRResponseData : NSObject

+(PRResponseData *)createWithData:(NSData *)data;
-(id)getJSONData;

@end
