//
//  PRCommon.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRCommon.h"

NSString *kDomine = @"93.158.189.30/";
NSString *kProtocol = @"http://";
NSString *kSignUp = @"signup";
NSString *kSignIn = @"login";
NSString *kSendMessage = @"mail/add";
const NSTimeInterval kActivityTimerInterval = 3;

CGRect CGRectRoundOrigin(CGRect rect) {
    CGRect result = CGRectMake(roundf(rect.origin.x),
                               roundf(rect.origin.y),
                               rect.size.width,
                               rect.size.height);
    return result;
}

@implementation PRCommon

@end
