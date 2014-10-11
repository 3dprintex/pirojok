//
//  PRSignUpData.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRSignUpData.h"

@implementation PRSignUpData

-(id)getData {
    NSDictionary *dict = @{
                           @"SignupForm": @{
                                   @"username": self.username,
                                   @"email": self.email,
                                   @"password": self.password,
                                   },
                           @"_csrf": self.csrf
                           };
    return dict;
}

@end
