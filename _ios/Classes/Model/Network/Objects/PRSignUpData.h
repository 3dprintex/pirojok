//
//  PRSignUpData.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRRequestData.h"

@interface PRSignUpData : PRRequestData

@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *username;

@end
