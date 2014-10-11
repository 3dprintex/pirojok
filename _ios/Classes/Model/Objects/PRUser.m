//
//  PRUser.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRUser.h"

@implementation PRUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSDictionary *user = dictionary[@"user"];
        self.name = user[@"name"];
        self.email = user[@"email"];
        self.lastVisitDate = [NSDate dateWithTimeIntervalSince1970:[user[@"lastdate"] intValue]] ;
    }
    return self;
}

+(PRUser *)createWithDictionary:(NSDictionary *)dictionary {
    return [[PRUser alloc] initWithDictionary:dictionary];;
}

@end
