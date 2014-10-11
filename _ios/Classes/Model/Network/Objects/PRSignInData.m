//
//  PRSignInData.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRSignInData.h"

@implementation PRSignInData

-(id)getData {
    NSDictionary *dict = @{
                           @"LoginForm": @{
                                   @"email": self.email,
                                   @"password": self.password,
                                   @"rememberMe": @"1"
                                   },
                           @"_csrf": self.csrf
                           };
    return dict;
}

@end
