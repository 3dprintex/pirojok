//
//  PRMessage.m
//  Pirojok
//
//  Created by Slava Bulgakov on 12.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRMessageData.h"

@implementation PRMessageData

-(id)getData {
    NSString *base64String = [UIImagePNGRepresentation(self.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *dict = @{
                           @"AddMailForm": @{
                                   @"mess": self.text,
                                   @"images": @[base64String]
                                   },
                           @"_csrf": self.csrf
                           };
    return dict;
}

@end
