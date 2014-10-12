//
//  PRModel.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRModel.h"
#import "PRNetwork.h"
#import "PRCommon.h"
#import "PRSignUpData.h"
#import "PRSignInData.h"

@interface PRModel()

@property(nonatomic, strong) PRNetwork *network;

@end

@implementation PRModel

static PRModel *_sharedInstance = nil;
+(PRModel *)sharedInstance {
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isAuthorized = NO;
        self.network = [[PRNetwork alloc] init];
    }
    return self;
}

-(void)sendMessage:(PRMessageData *)message completion:(void(^)(BOOL success, NSString *message))completion {
    void(^invokeCompletion)(BOOL success, NSString *message) = ^(BOOL success, NSString *message) {
        if (completion) {
            completion(success, message);
        }
    };
    [self.network getWithUrlString:kSendMessage onSuccess:^(PRResponseData *responseData) {
        if ([self _csrfObtain:responseData.getJSONData]) {
            [self.network postWithUrlString:kSendMessage onSuccess:^(PRResponseData *responseData) {
                NSDictionary *result = responseData.getJSONData;
                if ([result[@"status"] isEqualToString:@"success"]) {
                    invokeCompletion(YES, nil);
                } else {
                    invokeCompletion(NO, [NSString stringWithFormat:@"%@", result[@"desc"]]);
                }
            } onError:^(NSError *error) {
                invokeCompletion(NO, nil);
            } requestData:message];
        } else {
            invokeCompletion(NO, nil);
        }
    } onError:^(NSError *error) {
        invokeCompletion(NO, nil);
    }];
}

-(void)signUpWithLogin:(NSString *)login andPassword:(NSString *)password andUsername:(NSString *)username completion:(void(^)(BOOL success))completion {
    PRSignUpData *data = [[PRSignUpData alloc] init];
    data.email = login;
    data.password = password;
    data.username = username;
    [self.network postWithUrlString:kSignUp onSuccess:^(PRResponseData *responseData) {
        BOOL auth = [self _isAuthResponse:responseData.getJSONData];
        if (completion) {
            completion(auth);
        }
    } onError:^(NSError *error) {
        if (completion) {
            completion(NO);
        }
    } requestData:data];
}

-(void)signInWithLogin:(NSString *)login andPassword:(NSString *)password completion:(void(^)(BOOL success))completion {
    PRSignInData *data = [[PRSignInData alloc] init];
    data.email = login;
    data.password = password;
    [self.network postWithUrlString:kSignIn onSuccess:^(PRResponseData *responseData) {
        NSDictionary *response = responseData.getJSONData;
        BOOL auth = [self _isAuthResponse:response];
        if (completion) {
            completion(auth);
        }
    } onError:^(NSError *error) {
        if (completion) {
            completion(NO);
        }
    } requestData:data];
}

-(void)preSignUpWithCompletion:(void(^)(BOOL success))completion {
    [self.network getWithUrlString:kSignUp onSuccess:^(PRResponseData *responseData) {
        NSDictionary *response = responseData.getJSONData;
        if (completion) {
            if ([self _csrfObtain:response]) {
                completion(YES);
            } else {
                completion(NO);
            }
        }
    } onError:^(NSError *error) {
        if (completion) {
            completion(NO);
        }
    }];
}

-(void)checkAuth:(void(^)(BOOL success))complition {
    [self.network getWithUrlString:kSignIn onSuccess:^(PRResponseData *responseData) {
        NSDictionary *result = responseData.getJSONData;
        if ([result[@"status"] isEqualToString:@"auth"]) {
            _isAuthorized = YES;
        } else {
            _isAuthorized = NO;
        }
        [self _csrfObtain:result];
        if (complition) {
            complition(_isAuthorized);
        }
    } onError:^(NSError *error) {
        if (complition) {
            complition(NO);
        }
        _isAuthorized = NO;
    }];
}

-(void)createMessage {
    _sendingMessage = [[PRMessageData alloc] init];
}

#pragma mark - internal methods
-(BOOL)_csrfObtain:(NSDictionary *)dict {
    NSString *csrf = dict[@"form"][@"_csrf"];
    if (csrf) {
        self.network.csrf = csrf;
        return YES;
    }
    return NO;
}

-(BOOL)_isAuthResponse:(NSDictionary *)response {
    BOOL auth = NO;
    if ([response[@"status"] isEqualToString:@"auth"]) {
        _user = [PRUser createWithDictionary:response];
        auth = YES;
    }
    return auth;
}

@end
