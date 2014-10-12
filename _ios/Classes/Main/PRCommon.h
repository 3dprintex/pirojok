//
//  PRCommon.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *kDomine;
extern NSString *kProtocol;
extern NSString *kSignUp;
extern NSString *kSignIn;
extern NSString *kSendMessage;
extern const NSTimeInterval kActivityTimerInterval;

CGRect CGRectRoundOrigin(CGRect rect);

@interface PRCommon : NSObject

@end
