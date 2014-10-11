//
//  PRUser.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRUser : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, strong) NSDate *lastVisitDate;

+(PRUser *)createWithDictionary:(NSDictionary *)dictionary;

@end
