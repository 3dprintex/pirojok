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

-(void)signUpWithLogin:(NSString *)login andPassword:(NSString *)password andUsername:(NSString *)username completion:(void(^)(BOOL success))completion {
    PRSignUpData *data = [[PRSignUpData alloc] init];
    data.email = login;
    data.password = password;
    data.username = username;
    [self.network postWithUrlString:kSignUp onSuccess:^(PRResponseData *responseData) {
        if (completion) {
            completion(YES);
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
        BOOL auth = NO;
        if ([response[@"status"] isEqualToString:@"auth"]) {
            _user = [PRUser createWithDictionary:response];
            auth = YES;
        }
        if (completion) {
            completion(YES);
        } else {
            completion(NO);
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

#pragma mark - internal methods
-(BOOL)_csrfObtain:(NSDictionary *)dict {
    NSString *csrf = dict[@"form"][@"_csrf"];
    if (csrf) {
        self.network.csrf = csrf;
        return YES;
    }
    return NO;
}

@end
