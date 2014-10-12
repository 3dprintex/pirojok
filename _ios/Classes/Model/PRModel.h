//
//  PRModel.h
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRUser.h"
#import "PRMessageData.h"

@interface PRModel : NSObject

@property(nonatomic, readonly) BOOL isAuthorized;
@property(nonatomic, readonly) PRUser *user;
@property(nonatomic, readonly) PRMessageData *sendingMessage;

+(PRModel *)sharedInstance;
-(void)signUpWithLogin:(NSString *)login andPassword:(NSString *)password andUsername:(NSString *)username completion:(void(^)(BOOL success))completion;
-(void)signInWithLogin:(NSString *)login andPassword:(NSString *)password completion:(void(^)(BOOL success))completion;
-(void)sendMessage:(PRMessageData *)message completion:(void(^)(BOOL success, NSString *message))completion;
-(void)preSignUpWithCompletion:(void(^)(BOOL success))completion;
-(void)checkAuth:(void(^)(BOOL success))complition;
-(void)createMessage;

@end
